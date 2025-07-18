function pp
    if not type --query project-picker
        echo "project-picker not installed"
        return 1
    end

    set dir (project-picker)

    # A non-zero exit code means no project was selected.
    if test $status -eq 0
        cd $dir
    end
end
