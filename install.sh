#!/bin/bash

echo "Do you need to install Oh My ZSH?"
select ohmyzsh in "Install OhMyZSH" "Skip"; do
    case $ohmyzsh in
        # Install Oh My ZSH
        "Install OhMyZSH" ) sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"; break;;
        Skip ) break;;
    esac
done

# TODO: Automate symlinking of files in directories
printf "\nAttempting to symlink dotfiles...\n"
# Git
ln -svi ~/dotfiles/git/.gitconfig ~
ln -svi ~/dotfiles/git/.gitignore_global ~

# Ruby/Gems
ln -svi ~/dotfiles/ruby/gems/.gemrc ~

echo "Do you want to reset your Sublime Text 3 and replace with these dotfiles? (Original settings will be backed up to the Desktop)."
select sublime in "Reset Sublime" "Leave as is/Sublime Not Installed"; do
  if [ "$sublime" == "Reset Sublime" ]; then
    if [ -d ~/Library/Application\ Support/Sublime\ Text\ 3/ ]; then
      # Backup existing folder
      printf "\nBacking up Sublime Text 3 Settings and Packages to the Desktop...\n\n"
      mv ~/Library/Application\ Support/Sublime\ Text\ 3/ ~/Desktop/Sublime\ Text\ 3\ Backup
      printf "Recreating empty Sublime Text 3 User folder...\n\n"
      # Recreate empty folder
      mkdir -vp ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
    fi
    printf "\nInstalling Sublime dotfiles\n"
    # Sublime Settings
    ln -svi ~/dotfiles/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -svi ~/dotfiles/sublime/settings/Default \(OSX\).sublime-keymap ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -svi ~/dotfiles/sublime/settings/JavaScriptNext.sublime-settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    ln -svi "~/dotfiles/sublime/settings/Package Control.sublime-settings" ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

    # Sublime Snippets
    ln -svi ~/dotfiles/sublime/snippets/do.sublime-snippet ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
    break;
  else
    printf "\nSkipping Sublime Text dotfiles...\n"
    break;
  fi
done

# Vim
ln -svi ~/dotfiles/vim/.vim/colors/solarized.vim ~/.vim/colors
ln -svi ~/dotfiles/vim/.vimrc ~

ln -svi ~/dotfiles/zsh/.zshrc ~
