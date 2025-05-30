# Installing 

`$ stow -S alacritty btop Code fish ghostty helix kitty ranger starship zellij`

If the stow command fails, because the files already exist, first adopt the existing files and then reset the adopted files, which are now symlinked to the repo, using git:

```
$ stow -S alacritty btop Code fish ghostty helix kitty ranger starship zellij --adopt
$ git reset --hard  
```
