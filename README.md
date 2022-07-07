# New .dotfile git repo in home directory

1. Initialize empty repository  
```$ git init --bare ~/.dotfiles``` 
2. Bind config alias to have ```$HOME``` as the work tree while setting the git-dir to the ```.dotfiles``` directory.  
Making the alias permanent in different shells:
    * _bash_:  
    ```$ echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc```
    * _zsh_:  
    ```$ echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc```
    * _fish_:  
    ```$ alias -s config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'```
3. Set all other files in ```$HOME``` to be untracked. Thus every new file cannot be viewed via ```config status```.  
```$ config config status.showUntrackedFiles no```
4. And it's done! 

# Install this .dotfiles repo onto new System
## Shortcut for the following steps. 
Pull installDotsToNewSystem.sh and run it:  
```
$ git fetch https://github.com/ThagonDuarte/dotfiles.git 
$ git checkout FETCH_HEAD - - installDotsToNewSystem.sh
$ sh installDotsToNewSystem.sh
```

## Long Version:
1. Bind config alias to have ```$HOME``` as the work tree while setting the git-dir to the ```.dotfiles``` directory.  
Making the alias permanent in different shells:
    * _bash_:  
    ```$ echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc```
    * _zsh_:  
    ```$ echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc```
    * _fish_:  
    ```$ alias -s config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'```
2. Make sure that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:  
```$ echo ".dotfiles" >> .gitignore```
3. Clone .dotfile repo:  
```$ git clone --bare https://github.com/ThagonDuarte/dotfiles.git $HOME/.dotfiles/```
4. Checkout the actual content from the bare repository to your ```$HOME```:  
```$ config checkout```  
    - In case this result in a error message like this:  
        ```
        error: The following untracked working tree files would be overwritten by checkout:
            .bashrc
            .gitignore
        Please move or remove them before you can switch branches.
        Aborting
        ``` 
    - Backup old .dotfiles:  
    ```$ mkdir -p .dotfiles-backup && \```  
    ```config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | \```  
    ```xargs -I{} mv {} .dotfiles-backup/{}```  
    - Re-run check out:     
```$ config checkout```
4. Disable _showUntrackedFiles_:  
```$ config config --local status.showUntrackedFiles no```  
5. And it's done! 

## Example usage

> ```$ config status```  
```$ config add .vimrc```  
```$ config commit -m "Add vimrc"```  
```$ config add .bashrc```  
```$ config commit -m "Add bashrc"```  
```$ config push```   

# Generating a new SSH key and adding it to the ssh-agent

1. Open Terminal.
2. Paste the text below, substituting in your GitHub email address.  
```$ ssh-keygen -t ed25519 -C "your_email@example.com"```  

This creates a new SSH key, using the provided email as a label.

1. When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.  
```> Enter a file in which to save the key (/home/you/.ssh/algorithm): [Press enter]```  
2. At the prompt, type a secure passphrase. For more information, see ["Working with SSH key passphrases."](https://docs.github.com/en/articles/working-with-ssh-key-passphrases)  
```> Enter passphrase (empty for no passphrase): [Type a passphrase]```  
```> Enter same passphrase again: [Type passphrase again ```  

## Adding your SSH key to the ssh-agent
Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for existing SSH keys and generated a new SSH key.

1. Start the ssh-agent in the background.  
```$ eval "$(ssh-agent -s)"```  
```> Agent pid 59566```  
Depending on your environment, you may need to use a different command. For example, you may need to use root access by running ``` sudo -s -H```  before starting the ssh-agent, or you may need to use ``` exec ssh-agent bash```  or ```exec ssh-agent zsh```  to run the ssh-agent.
2. Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_ed25519 in the command with the name of your private key file.  
```$ ssh-add ~/.ssh/id_ed25519```
3. Add the SSH key to your account on GitHub. For more information, see ["Adding a new SSH key to your GitHub account."](https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)