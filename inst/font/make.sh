#!/bin/sh

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

src_dir=${repo_dir}/fonts
dst_dir=~/.local/share/fonts

if [ "$1" = "install" ]; then
  mkdir -p ${dst_dir}
  log info "Installing fonts on ${dst_dir}"
  cp ${src_dir}/* ${dst_dir}/
  log info "Updating font cache"
  fc-cache -vf
elif [ "$1" = "clean" ]; then
  ls -1 ${src_dir} | while read line
  do
    log info "Removing ${dst_dir}/${line}"
    rm -f ${dst_dir}/${line}
  done
  log info "Updating font cache"
  fc-cache -vf
fi
