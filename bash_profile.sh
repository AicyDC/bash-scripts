alias prof='vi ~/.bash_profile'

git-run() {
  git add .
  if (( $# > 0 )); then
    git commit -m "$@"
  else 
    git commit -m "commit" # default message for no commit
  fi
  git push
}

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