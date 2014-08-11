#!/bin/zsh

export UNLINK=true

function symlinkifne {
    echo "WORKING ON: $1"
    
    # does it exist
    if [[ -a $1 ]]; then
      echo "  WARNING: $1 already exists."
      
      # If Unlink is requested
      if [ "$UNLINK" = "true" ]; then
          unlink $1
          echo "  Unlinking $1"
          
          # create the link
          echo "  Symlinking $DOTFILESDIRRELATIVETOHOME/$1 to $1"
          ln -s $DOTFILESDIRRELATIVETOHOME/$1 $1
      else
        echo "  SKIPPING $1."  
      fi
    # does not exist
    else
      # create the link
      echo "  Symlinking $DOTFILESDIRRELATIVETOHOME/$1 to $1"
      ln -s $DOTFILESDIRRELATIVETOHOME/$1 $1
    fi
}


echo "This script must be run from the dotfiles directory"
echo "Setting up..."

echo "formatting the configs for this user"

sed -i '' 's/eivya001/'$(whoami)'/g' .zshrc;

#export DOTFILESDIRRELATIVETOHOME=$PWD
export DOTFILESDIRRELATIVETOHOME=.dotfiles
echo "DOTFILESDIRRELATIVETOHOME = $DOTFILESDIRRELATIVETOHOME"

pushd ~

symlinkifne .bowerrc
symlinkifne .crontab
symlinkifne .gemrc
symlinkifne .gitconfig
symlinkifne .gitignore
symlinkifne .hgrc
symlinkifne .npmrc
symlinkifne .profile
symlinkifne .rvmrc
symlinkifne .screenrc
symlinkifne .shellaliases
symlinkifne .shellfn
symlinkifne .shellpaths
symlinkifne .shellvars
symlinkifne .vim
# in case there was already a ~/.vim
# but it doesn't contain these folders
symlinkifne .vim/autoload
symlinkifne .vim/backup
symlinkifne .vim/bundle
symlinkifne .vim/colors
symlinkifne .vim/temp
symlinkifne .vim/.netrwhist
symlinkifne .vimrc
symlinkifne .zlogout
symlinkifne .zprofile
symlinkifne .zshenv
symlinkifne .zshrc

popd

echo "running OSX config and Brew installations"

./.osx