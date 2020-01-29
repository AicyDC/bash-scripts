#!/usr/local/bin/bash

git_branch() {
  git branch 2> /dev/null | grep '*' | awk '{print $2}' | sed 's/.*/(&)/'
}

get_aws_profile() {
  cat ~/.awsp
}

prompt() {
  # echo '$(get_aws_profile) \w\[\033[32m\] $(git_branch)\[\033[00m\] '
  echo '\w\[\033[32m\] $(git_branch)\[\033[00m\] '
}


set_aliases() {
  ## Alias to go to and edit the bash profile
  alias prof='vi ~/.bash_profile'
  alias loadprof='source ~/.bash_profile'

  alias minictl='minikube kubectl'

  alias drm='docker rm $(docker ps -aq)'
  alias drmi='docker rmi `docker images -q`'

  # Docker exec to the one container running
  alias dexec='docker exec -it $(docker ps -q) sh'

  # restart docker
  alias drestart='killall Docker && open /Applications/Docker.app'

  alias tf='terraform'

  alias gr='git-run'
}

# aws profile
awsp() {
  AWS_PROFILE=$1

  # Set the cluster name
  case "$AWS_PROFILE" in
    stage)  EKS_CLUSTER=dzing-dev-use1
        ;;
    stageoh)  EKS_CLUSTER=dzing-kpdt7zx-use2
        ;;
    prod)  EKS_CLUSTER=dzing-prod-euw1
        ;;
    *) echo "Invalid aws profile. Options are: stage stageoh prod"
       return 0
      ;;
  esac
  export EKS_CLUSTER

  echo $AWS_PROFILE > ~/.awsp

  for tool in aws kubectl helm terraform; do
    alias $tool="aws-profile -p $AWS_PROFILE $tool"
  done

  if [ -z $2 ]; then
    aws-profile -p $AWS_PROFILE aws eks update-kubeconfig --name $EKS_CLUSTER
  fi
  export PS1=$(prompt)
}

mcd () {
  mkdir $1
  cd $1
}

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

git-set-config() {
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

wifirestart() {
  sudo ifconfig en0 down
  sudo ifconfig en0 up
}

main() {
  # bash-completion
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

  set_aliases

  GATLING_HOME=/Users/tommycouzens/dzing/dz_infrastructure/gatling

  awsp $(cat ~/.awsp) no_eks_config
}
main

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
# export PATH
