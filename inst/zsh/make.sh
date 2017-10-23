#!/bin/sh

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

zshenv=${dir}/.zshenv
target=${HOME}/.zshenv

if [ "$1" = "install" ]; then
  log info "Creating link: ${zshenv} -> ${target}"
  if [ ! -L $target ]; then
    ln -s ${zshenv} ${target}
  else
    log warn "${target} already exists."
  fi
elif [ "$1" = "clean" ]; then
  rm -f $target
fi
