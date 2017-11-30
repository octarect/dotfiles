#!/bin/sh

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

conf_src=${repo_dir}/config/elvish
conf_dst=${HOME}/.elvish

if [ "$1" = "install" ]; then
  log info "Creating link: ${conf_src} -> ${conf_dst}"
  if [ ! -L ${conf_dst} ]; then
    ln -s ${conf_src} ${conf_dst}
  else
    log warn "${conf_dst} already exists."
  fi
elif [ "$1" = "clean" ]; then
  log info "Removing link: ${conf_src} -> ${conf_dst}"
  rm -rf ${conf_dst}
fi
