function j
    set old_cwd $PWD
    if test -n "$argv[1]"
        cd "$argv[1]"
        set should_alter_history yes
    end

    set dir (fd . --type d --max-depth 4 | zf --height 40 --preview 'eza --icons=always -1 --classify=always ')
    if test -z "$dir"
        cd "$old_cwd"
        if test -n "$should_alter_history"
            set dirprev $dirprev[1..-3]
        else
            set dirprev $dirprev[1..-2]
        end
        return 1
    end

    cd $dir
    if test -n "$should_alter_history"
        set dirprev $dirprev[1..-2]
    end
end
