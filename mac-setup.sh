## Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install command line tools
brew install ag
brew install gnupg
brew install vault
brew install jq
brew install hub
brew install wget
brew install shpotify
brew install node # npm
brew install minikube # kubernetes

## Install applications

brew install cask
brew cask install google-chrome
brew cask install station
brew cask install visual-studio-code
brew cask install lastpass
brew cask install docker
brew cask install discord
brew cask install skype
brew cast install spotify
brew cask install whatsapp
brew cask install postman
brew cask install virtualbox
brew cask install vagrant
brew install kube-ps1

## Install pip
sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python get-pip.py
rm get-pip.py

## Install terraform
curl https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_darwin_amd64.zip -o terraform.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/
rm -f terraform.zip
terraform -version

## Install aws-vault
brew cask install aws-vault


# Set git as an alias for hub
alias git='hub'

# Change default screenshots folder 
change_screenshots_folder() {
  mkdir ~/Desktop/Screenshots
  defaults write com.apple.screencapture location ~/Desktop/Screenshots
  killall SystemUIServer
}
change_screenshots_folder


## Sym link the bash profile defined in this repo to yours
if [ ! -f  ~/.bash_profile ]; then
    # cp bash_profile.sh ~/.bash_profile
    ln -s $PWD/bash_profile.sh ~/.bash_profile
else
   echo "A bash profile already exists. Check if you want to copy anything from this bash_profile.sh"
fi
