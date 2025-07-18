# Git.
abbr --add ga git add
abbr --add gap git add --patch
abbr --add gp git push
abbr --add gpf git push --force
abbr --add gpl git pull
abbr --add gplr git pull --rebase
abbr --add gs git status
if type --query difft
    abbr --add gd git -c diff.external=difft diff
else
    abbr --add gd git diff
end

function remote_and_branch
    set branch (git rev-parse --abbrev-ref HEAD)
    echo (git config --get branch.$branch.remote) $branch
end

abbr --command git cb --function remote_and_branch

# Zig build.
abbr --add zb zig build
abbr --add zbw zig build --watch
abbr --add zbr zig build run
abbr --add zbf zig build -Doptimize=ReleaseFast
abbr --add zbfl zig build -Doptimize=ReleaseFast --prefix ~/.local
abbr --add zbs zig build -Doptimize=ReleaseSafe
abbr --add zbsl zig build -Doptimize=ReleaseSafe --prefix ~/.local
abbr --add zt zig test
abbr --add zbt zig build test --summary all

if type --query eza
    abbr --add ls eza --icons
    abbr --add ll eza --icons -lh
    abbr --add la eza --icons -lha
end

if type --query bat
    abbr --add cat bat
else if type --query zat
    abbr --add cat zat
end
