#!/bin/bash

if [ "$(for git in $(sudo apt-cache madison git | cut -d '|' -f 2); do sudo dpkg -l | grep git | grep $git; done | head -n 1 | awk '{print $1}')" != "ii" ]
then
  #apt-get -y update && sudo apt-get -y upgrade
  apt-get -y install git
fi

os='ubuntu'
os_version='18.04'
chef_workstation_version='20.10.168'
chef_client_version='16.6.14'
chef_version=$chef_client_version
download_file='/tmp/chef_install.deb'
project_name=$1
shift
for chef_environment in $@
do
  if [ "$chef_environment_json" == "" ]
  then
    chef_environment_json="\"$chef_environment\""
  else
    chef_environment_json="$chef_environment_json, \"$chef_environment\""
  fi
done

# Chef workstation
if [ ! -f chef_workstation_installed ]
then
  wget -O $download_file https://packages.chef.io/files/stable/chef-workstation/$chef_workstation_version/$os/$os_version/chef-workstation_$chef_workstation_version-1_amd64.deb && touch chef_workstation_installed
  dpkg -i $download_file
fi

mkdir cookbooks
cd cookbooks
git clone git@github.com:jimbodragon/chef_workstation_initialize.git
cd ..
cat << EOS > solo.rb
cookbook_path ['cookbooks']
EOS
cat<<EOS > node.json
{
  "chef_workstation": {
    "project_name": "project_name",
    "environment": [$chef_environment_json]
  }
}
EOS

chef-solo --chef-license 'accept' --json-attributes node.json --config solo.rb --override-runlist "recipe[chef_workstation_initialize]"