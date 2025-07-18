local comlink = require('comlink')
local watcher = require('watcher')

local function run_command_and_trim(command)
	-- Execute the command and capture output
	local handle = io.popen(command)
	assert(handle, "Failed to execute command")

	-- Read the output
	local result = handle:read("*a")
	local success, exit_type, exit_code = handle:close()

	-- Check if command executed successfully
	assert(success, "Command failed with exit code: " .. (exit_code or "unknown"))

	-- Trim whitespace (including newlines)
	if result then
		result = result:match("^%s*(.-)%s*$")
	end

	return result
end

local config = {
  server = 'chat.sr.ht',
  user = 'reykjalin',
  nick = 'reykjalin',
  password = run_command_and_trim('op read "op://Private/chat.sr.ht app password/password"'),
  tls = true,
  real_name = 'Kristófer Reykjalín',
}

-- Set channel watch config to receive notifications on any message in the provided channels.
local connection = comlink.connect(config)
connection.on_message = watcher.on_message

watcher.channels = {
  "#comlink",
  "#ghostty",
  "#vaxis",
}

-- Keybindings.
comlink.bind("ctrl+c", "quit")
comlink.bind("ctrl+n", "next-channel")
comlink.bind("ctrl+j", "next-channel")
comlink.bind("ctrl+p", "prev-channel")
comlink.bind("ctrl+l", "redraw")

local function mark_read(_)
	local maybe_channel = comlink.selected_channel()
	if maybe_channel then
		maybe_channel:mark_read()
	end
end
comlink.bind("ctrl+r", mark_read)

-- /tableflip and /shrug.
local function tableflip(_)
	local channel = comlink.selected_channel()
	if channel then
		channel:send_msg("(╯°□°)╯︵ ┻━┻")
	end
end

local function shrug(_)
	local channel = comlink.selected_channel()
	if channel then
		channel:send_msg("¯\\_(ツ)_/¯")
	end
end

comlink.add_command("tableflip", tableflip)
comlink.add_command("shrug", shrug)

-- /fmt <text>.
local function replace(string, old, new)
	local s = string
	local search_start_idx = 1

	while true do
		local start_idx, end_idx = s:find(old, search_start_idx, true)
		if not start_idx then
			break
		end

		local postfix = s:sub(end_idx + 1)
		s = s:sub(1, (start_idx - 1)) .. new .. postfix

		search_start_idx = -1 * postfix:len()
	end

	return s
end

local function format(cmdline)
	local channel = comlink.selected_channel()
	if channel then
		local s = replace(cmdline, "**", "\x02")
		s = replace(s, "*", "\x1D")
		s = replace(s, "~", "\x1E")
		s = replace(s, "_", "\x1F")
		s = replace(s, "<blue>", "\x0302")
		s = replace(s, "</blue>", "\x03")
		channel:send_msg(s)
	end
end
comlink.add_command("fmt", format)
