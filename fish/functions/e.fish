function e --description 'opens a fuzzy file selector to open your editor if available'
    set fuzzer ''
    if type --query zf
        set fuzzer zf
    else if type --query fzf
        set fuzzer fzf
    end

    # If a fuzzer isn't available we don't try it and just run the editor.
    if not test -n "$fuzzer"
        $EDITOR $argv
        return
    end

    # We use `fd` if available.
    set find find . -type f
    if type --query fd
        set find fd --type f
    end

    if count $argv >/dev/null
        # If a directory is provided, we move there first.
        # Otherwise: open the provided file in the editor.
        if test -d $argv
            cd $argv
            set file ($find | $fuzzer)
            if test -z $file
                return 1
            end

            $EDITOR $file
        else
            $EDITOR $argv
        end
    else
        # If nothing is provided, open a picker for files in the current directory.
        set file ($find | $fuzzer)
        if test -z $file
            return 1
        end

        $EDITOR $file
    end
end
