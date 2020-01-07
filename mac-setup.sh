## Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install command line tools
brew install hub
brew install wget
brew install shpotify

## Install applications

brew install cask
brew cask install google-chrome
brew cask install station
brew cask install visual-studio-code
brew cask install lastpass
brew cask install docker
brew cask install skype
brew cast install spotify
brew cask install whatsapp

# Set git as an alias for hub
alias git='hub'


## Sym link the bash profile defined in this repo to yours
if [ ! -f  ~/.bash_profile ]; then
    # cp bash_profile.sh ~/.bash_profile
    ln -s $PWD/bash_profile.sh ~/.bash_profile
else
   echo "A bash profile already exists. Check if you want to copy anything from this bash_profile.sh"
fi
