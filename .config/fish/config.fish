if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \b backward-kill-word
end

export STARSHIP_CONFIG=/home/alex/.config/starship/starship.toml
starship init fish | source
