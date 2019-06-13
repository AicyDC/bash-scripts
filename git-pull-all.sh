#!/bin/bash

# This script does a git pull in all the repositories in the directory you are in
# Does not work for directories which have spaces in the name; which is a sacrifice I'm willing to make. If you want to add that functionally feel free to do a PR.

pullall () {
  for dir in $(ls -d */); do
    cd $dir
    if [ -d .git ]; then
      echo "$dir is a git respository:"
      git pull
    fi
    cd ..
  done
}

pullall
