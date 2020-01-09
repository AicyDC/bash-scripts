### Set path

# Add python for aws
export PATH="/Users/tommycouzens/Library/Python/3.8/bin:$PATH"

## Alias to go to and edit the bash profile
alias prof='vi ~/.bash_profile'
alias loadprof='source ~/.bash_profile'

## Update your current shell to use your new profile functions
alias update='source ~/.bash_profile'

mcd () {
  mkdir $1
  cd $1
}

alias la='ls -a'
alias ll='ls -l'

## Does all the steps for a push, with an optional input for commit message, otherwise defaults to "editing"
git-run() {
  git add .
  if (( $# > 0 )); then
    git commit -m "$1"
  else 
    git commit -m "editing" # default message for no commit
  fi
  git push
}

alias gr='git-run'

branch() { 
  git branch | grep '*' | awk '{print $2}' 
}

git-config() {
  git config user.name "tommy-couzens"
  git config user.email "tom.czns@gmail.com"
}

# Deletes a branch locally and remotely
git-delete() {
  git branch -D "$1"
  git push -d origin "$1"
}

## Does a git pull for all repos below your current directory
git-pull-all () {
  for dir in $(ls -d */); do
    cd $dir
    if [ -d .git ]; then
      echo "$dir is a git respository:"
      git pull
    fi
    cd ..
  done
}

## Terraform
terraform_variable() {
    echo "$1 = \"\${var.$1}\""
}

alias tf='terraform'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/a8201290/.sdkman"
[[ -s "/Users/a8201290/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/a8201290/.sdkman/bin/sdkman-init.sh"

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH
