#!/usr/local/bin/bash

# bash-completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

greenStart='\[\033[32m\]'
greenEnd='\[\033[00m\]'

#git_branch() {
#  git branch 2> /dev/null | grep '*' | awk '{print $2}'
#}

# use git-prompt.sh instead https://web.archive.org/web/20160704140739/http://ithaca.arpinum.org/2013/01/02/git-prompt.html
# this answer seems good https://stackoverflow.com/a/29020276/11017224
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

prompt() {
  echo '\w\[\033[32m\]$(git_branch) \[\033[00m\] '
}

export PS1=$(prompt 🔨 )

# Add python for aws
export PATH="/Users/tommycouzens/Library/Python/3.8/bin:$PATH"

# Gatling
GATLING_HOME=/Users/tommycouzens/dzing/dz_infrastructure/gatling

## Alias to go to and edit the bash profile
alias prof='vi ~/.bash_profile'
alias loadprof='source ~/.bash_profile'

## Update your current shell to use your new profile functions
alias update='source ~/.bash_profile'


# aws profile
awsp() {
  AWS_PROFILE=$1
  echo $aws
  # Set the cluster name
  case "$AWS_PROFILE" in
    stage)  EKS_CLUSTER=dzing-dev-use1
        ;;
    stageoh)  EKS_CLUSTER=dzing-kpdt7zx-use2
        ;;
    prod)  EKS_CLUSTER=dzing-prod-euw1
        ;;
    *) echo "Invalid aws profile. Options are: "
      ;;
  esac
  export EKS_CLUSTER

  alias aws="aws-profile -p $AWS_PROFILE aws"
  alias kubectl="aws-profile -p $AWS_PROFILE kubectl"
  alias helm="aws-profile -p $AWS_PROFILE helm"
  alias terraform="aws-profile -p $AWS_PROFILE terraform"
  aws-profile -p $AWS_PROFILE aws eks update-kubeconfig --name $EKS_CLUSTER
  export PS1=$(prompt 🔨 )
}


# set stage as default
alias aws='aws-profile -p stage aws'
alias kubectl='aws-profile -p stage kubectl'
alias helm="aws-profile -p stage helm"
alias terraform="aws-profile -p stage terraform"

mcd () {
  mkdir $1
  cd $1
}

alias la='ls -a'
alias ll='ls -l'


# minikube
alias minictl='minikube kubectl'

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

# Docker
drm() {
  containers=$(docker ps -aq)
  docker rm $containers
}

alias drmi='docker rmi $(docker images |  grep -v "IMAGE ID" | grep -v "openjdk" | awk '"'"'{print $3}'"'"')'

# Docker exec to the one container running
alias dexec='docker exec -it $(docker ps -q) sh'

# restart docker
alias drestart='killall Docker && open /Applications/Docker.app'

## Terraform
terraform_variable() {
    echo "$1 = \"\${var.$1}\""
}

alias tf='terraform'

wifirestart() {
  sudo ifconfig en0 down
  sudo ifconfig en0 up
}

# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH
