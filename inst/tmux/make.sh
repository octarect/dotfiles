#!/bin/sh

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

conf=${dir}/.tmux.conf

target_conf=${HOME}/.tmux.conf
target_tpm=${HOME}/.tmux/plugins/tpm

if [ "$1" = "install" ]; then

  log info "Creating link: ${conf} -> ${target_conf}"
  if [ ! -L ${target_conf} ]; then
    ln -s ${conf} ${target_conf}
  else
    log warn "${target_conf} already exists."
  fi

  log info "Installing tpm..."
  mkdir -p ${HOME}/.tmux/plugins
  if [ ! -e ${target_tpm} ]; then
    git clone https://github.com/tmux-plugins/tpm ${target_tpm}
  else
    log warn "${target_tpm} already exists."
  fi
elif [ "$1" = "clean" ]; then
  rm -rf $target_conf 
  rm -rf $target_tpm
fi
