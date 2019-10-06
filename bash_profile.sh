## Alias to go to and edit the bash profile
alias prof='vi ~/.bash_profile'

## Update your current shell to use your new profile functions
alias update='source ~/.bash_profile'

## Does all the steps for a push, with an optional input for commit message, otherwise defaults to "editing"
git-run() {
  git add .
  if (( $# > 0 )); then
    git commit -m "$@"
  else 
    git commit -m "editing" # default message for no commit
  fi
  git push
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