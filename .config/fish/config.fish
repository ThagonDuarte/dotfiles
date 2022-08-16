if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \b backward-kill-word
    export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
end

starship init fish | source
