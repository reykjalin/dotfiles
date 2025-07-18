local comlink = require("comlink")

---The Watcher module sends a notification for every message in a "watched" channel
---@class Watcher
---
---@field channels string[] List of channels that are being watched
local M = {
	channels = {},
}

---Adds a channel to the list of watchers
---@param channel string The channel to add
function M.add(channel)
	if channel == nil or channel == "" then
		local maybe_channel = comlink.selected_channel()
		if maybe_channel then
			channel = maybe_channel:name()
		end
	end
	table.insert(M.channels, channel)
	comlink.notify("comlink", "watching " .. channel)
end

---Removes a channel from the list of watchers
---@param channel string The channel to remove
function M.remove(channel)
	if channel == "" then
		local maybe_channel = comlink.selected_channel()
		if maybe_channel then
			channel = maybe_channel:name()
		end
	end
	for i, chan in ipairs(M.channels) do
		if chan == channel then
			table.remove(M.channels, i)
			comlink.notify("comlink", "removed watcher for " .. channel)
			return
		end
	end
end

---Callback when a message is received
---@param channel string The channel the message was sent in
---@param sender string The sender of the message
---@param msg string The sender of the message
function M.on_message(channel, sender, msg)
	for _, watched in ipairs(M.channels) do
		if watched == channel then
			if channel:sub(1, 2) == "#" then
				comlink.notify(sender .. " in " .. channel, msg)
				return
			end
			comlink.notify(sender, msg)
			return
		end
	end
end

comlink.add_command("watch", M.add)
comlink.add_command("unwatch", M.remove)

return M
