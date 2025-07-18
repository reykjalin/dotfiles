set paths (yazi $argv[2] --chooser-file=/dev/stdout)
zellij action toggle-floating-panes

if test -n "$paths"
    zellij action write 27 # send <escape> key.
    zellij action write-chars ":$argv[1] $paths"
    zellij action write 13 # send <enter> key.
end
