#!/bin/sh

# exit on errors
set -e

# print usage information and exit
print_usage() {
    >&2 echo \
"Usage: $(basename $0) [OPTIONS]
Apply (parts of) the configuration to the system.

Available options (at least one required):
  -a    Apply all of the configuration, equivalent to -slpfn
  -s    Install user scripts
  -u    Install git submodules
  -l    Create symlinks for configuration files and directories
  -p    Install packages listed in packages.txt using paru
  -n    Setup neovim and install neovim plugins
  -f    Setup fish and install fish plugins
  -y    Install hyprland related packages and configuration files
  -h    Show this help message"
    exit 0
}

# output message to stderr
print_debug() {
    >&2 echo "$1"
}

# print error message and exit
print_error() {
	if [ "$#" -gt 0 ]; then
		>&2 echo "$1"
	fi
	>&2 echo "Use \"$(basename $0) -h\" for further information."
	exit 1
}

# flags to be set
install_user_scripts=false
install_submodules=false
create_links=false
install_packages=false
setup_nvim=false
setup_fish=false
setup_hyprland=false

# set flags according to input parameters
while getopts "asulpfnyh" arg; do
    case $arg in
        "a") install_user_scripts=true; install_submodules=true create_links=true; install_packages=true;
             setup_fish=true; setup_nvim=true; setup_hyprland=true ;;
        "s") install_user_scripts=true ;;
        "u") install_submodules=true ;;
        "l") create_links=true ;;
        "p") install_packages=true ;;
        "f") setup_fish=true ;;
        "n") setup_nvim=true ;;
        "y") setup_hyprland=true ;;
        "h") print_usage; exit 0 ;;
        "?") print_error; exit 1 ;;
    esac
done

# test if at least one flag was specified
if [ "$OPTIND" -eq 1 ]; then
    print_error "No options specified."
fi
shift $(( OPTIND - 1 ))

# commands and directories
ln_cmd="ln -sf"
config_dir="$HOME/.config"
dot_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
device=$(hostnamectl hostname | cut -d- -f2)

# install git submodules
if [ "$install_submodules" = true ]; then
    print_debug "Install git submodules..."
    git submodule update --init --recursive
    print_debug ""
fi

# create symbolic links for config files and directories
if [ "$create_links" = true ]; then
    print_debug "Creating symlinks for the configuration files and directories..."
    mkdir -p "$config_dir"
    $ln_cmd "$dot_dir/btop" "$config_dir/"
    $ln_cmd "$dot_dir/cava" "$config_dir/"
    $ln_cmd "$dot_dir/Code - OSS/User" "$config_dir/Code - OSS/"
    $ln_cmd "$dot_dir/dunst" "$config_dir/"
    $ln_cmd "$dot_dir/git" "$config_dir/"
    $ln_cmd "$dot_dir/gtk/gtk-3.0" "$config_dir/"
    $ln_cmd "$dot_dir/gtk/gtk-4.0" "$config_dir/"
    $ln_cmd "$dot_dir/kitty" "$config_dir/"
    $ln_cmd "$dot_dir/misc" "$config_dir/../.misc"
    $ln_cmd "$dot_dir/ranger" "$config_dir/"
    $ln_cmd "$dot_dir/rofi" "$config_dir/"
    $ln_cmd "$dot_dir/starship" "$config_dir/"
    $ln_cmd "$dot_dir/tmux" "$config_dir/"
    $ln_cmd "$dot_dir/vimrc" "$HOME/.vimrc"
    $ln_cmd "$dot_dir/zathura" "$config_dir/"
    print_debug ""
fi

# install my own scripts
if [ "$install_user_scripts" = true ]; then
    print_debug "Installing user created scripts to /usr/bin/ ..."
    for script in `ls $dot_dir/scripts`; do
        if [ $script != link.sh ]; then
            sudo chmod +x ~/.scripts/$script 
            sudo $ln_cmd -f "$dot_dir/scripts/$script" /usr/bin/`echo $script | cut -d "." -f 1`
        fi
    done 
    print_debug ""
fi

# install packages using paru
if [ "$install_packages" = true ]; then
    print_debug "Installing packages from package.txt using paru..."
    paru -S --needed - < "$dot_dir/packages.txt"
    print_debug ""
fi

# install hyprland related packages and move its config files to ~/.config
if [ "$setup_hyprland" = true ]; then
    print_debug "Installing packages from package-hyprland.txt using paru..."
    paru -S --needed - < "$dot_dir/packages-hyprland.txt"
    print_debug "Creating symlinks for hyprland config files"
    $ln_cmd "$dot_dir/hyprland" "$config_dir"
    print_debug ""
fi

# setup fish and install fish plugins
if [ "$setup_fish" = true ]; then
    $ln_cmd "$dot_dir/fish" "$config_dir/"
    print_debug "Setting up fish..."
    fish "$dot_dir/fish/install.fish"
    print_debug ""
fi

# setup neovim
if [ "$setup_nvim" = true ]; then
    print_debug "Setting up neovim..."
    $ln_cmd "$dot_dir/astronvim" "$config_dir/"
    if [ -d "$config_dir/nvim" ]; then
        rm -rf "$config_dir/nvim"
    fi
    git clone https://github.com/AstroNvim/AstroNvim "$config_dir/nvim"
    nvim --headless -c 'AstroUpdate' -c 'quitall' 2> /dev/null
    print_debug "Syncing neovim plugins using packer..."
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' 2> /dev/null
    print_debug ""
fi

# setup firefox custom css
if [ "$setup_firefox" = true ]; then
    print_debug "Moving firefox custom css files..."
    $ln_cmd "$dot_dir/firefox "
    print_debug "Setting firefox variables..."
    print_debug ""
fi

print_debug "Configuration applied sucessfully."