#!/bin/bash

export http_git="https://raw.githubusercontent.com/JimboDragonGit"
export git_branch="master"

export project_name="$1"
export functions_dir_name="functions"
export initialize_dir_name="initialize"
export build_dir_name="build"
export data_dir_name="data"
export log_dir_name="logs"
export extension=".sh"

export source_file="${BASH_SOURCE[0]}"
export file_name="$(basename $source_file)"

export scripts_dir="$current_dir/$project_name"
export initialize_dir="$scripts_dir/$initialize_dir_name"
export functions_dir="$scripts_dir/$functions_dir_name"
export build_dir="$scripts_dir/$build_dir_name"
export data_dir="$scripts_dir/$data_dir_name"
export log_dir="$scripts_dir/$log_dir_name"

export build_file="$build_dir/$project_name$extension"

export file_list=(
  "$initialize_dir/initializing_chef_repo.sh"
  "$initialize_dir/install_chef_infra.sh"
  "$initialize_dir/git_clone_project.sh"
  "$functions_dir/initialize.sh"
  "$functions_dir/generals.sh"
  "$functions_dir/git.sh"
  "$functions_dir/chef.sh"
  "$data_dir/generals.sh"
  "$data_dir/git.sh"
  "$data_dir/chef.sh"
  "$data_dir/initialize.sh"
  "$build_dir/$project_name$extension"
  "$scripts_dir/$file_name"
)
