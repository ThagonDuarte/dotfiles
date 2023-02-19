# Initial setup for fish.
set script_dir "~/.config/fish"

# disable greeting
set -U fish_greeting
set -l script_dir (realpath (dirname (status -f)))

# generate zoxide config
mkdir -p "$script_dir/conf.d"
zoxide init fish > "$script_dir/conf.d/zoxide.fish"

# generate abbreviations and aliases
source "$script_dir/abbreviations.fish"
source "$script_dir/aliases.fish"

# use starship as prompt
starship init fish | source
funcsave fish_prompt
export STARSHIP_CONFIG=$HOME/.config/starship/kitty-starship.toml

# install plugins listed in fish_plugins
curl -sL https://git.io/fisher | source && fisher update

# add paths
# fish_add_path /home/alex-kde/.spicetify
# fish_add_path ~/.local/bin
