# Installing

## System packages

### Arch 

`$ paru -S (cat ./packages.txt)`

## Dotfiles

`$ stow -S alacritty btop Code fish ghostty helix kitty starship wezterm yazi zellij`

If the stow command fails, because the files already exist, first adopt the existing files and then reset the adopted files, which are now symlinked to the repo, using git:

```
$ stow -S alacritty btop Code fish ghostty helix kitty starship wezterm yazi zellij --adopt
$ git reset --hard  
```
