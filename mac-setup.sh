## install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Install command line tools
brew install hub
brew install wget

# Set git as an alias for hub
alias git='hub'


## Command that puts .bash_profile in
if [ ! -f  ~/.bash_profile ]; then
    # cp bash_profile.sh ~/.bash_profile
    echo "hello"
else
   echo "A bash profile already exists. Check if you want to copy anything from this bash_profile.sh"
fi
