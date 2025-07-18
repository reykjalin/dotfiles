if type --query difft
    GIT_PAGER="less -+F --clear-screen" git -c diff.external=difft diff $argv
else
    GIT_PAGER="less -+F --clear-screen" git diff $argv
end
