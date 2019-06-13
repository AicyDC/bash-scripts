#!/bin/bash

# Terraform versions: https://releases.hashicorp.com/terraform/

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  OS="darwin_amd64"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  OS="linux_amd64"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  OS="freebsd_amd64"
fi

# Input examples 0.11.8 or 0.12.0
if [ $# -ne 1 ]
then
  echo """
  Enter a version number as an argument
  Versions can be found at: https://releases.hashicorp.com/terraform/
  """
  exit 1
fi
version=$1

# Download the terraform binary
if [ ! -f terraform_${version} ]
then
echo "Downloading terraform version ${version}"
wget https://releases.hashicorp.com/terraform/${version}/terraform_${version}_${OS}.zip
unzip terraform_${version}_${OS}.zip
mv terraform terraform_${version} # always unzips as to the name terraform
rm terraform_${version}_darwin_amd64.zip
fi

# check if terraform is already installed, set that path as a variable so we can replace it
if [ ! -z $(which terraform) ] 
then
terraform_path=$(which terraform)
else
terraform_path="/usr/local/bin/terraform"
fi

cp terraform_${version} $terraform_path
echo "Set terraform version to ${version}"