if type --query hx
    set -gx EDITOR hx
    return
end

if type --query nvim
    set -gx EDITOR nvim
    return
end

if type --query vim
    set -gx EDITOR vim
    return
end

if type --query vi
    set -gx EDITOR vi
    return
end

if type --query pico
    set -gx EDITOR pico
    return
end

if type --query nano
    set -gx EDITOR nano
    return
end
