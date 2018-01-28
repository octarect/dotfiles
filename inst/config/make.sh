#!/bin/sh

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh

mkdir -p $XDG_CONFIG_HOME
config_dir=${repo_dir}/config
configs=$(find ${config_dir}/* -maxdepth 0)

for src in $configs
do
  dst=${XDG_CONFIG_HOME}/$(basename $src)
  if [ "$1" = "install" ]; then
    # create symbolic links
    if [ ! -L $dst ]; then
      log info "Creating link: $src -> $dst"
      ln -s $src $dst
    else
      log warn "$dst already exists. Skipping..."
    fi
  elif [ "$1" = "clean" ]; then
    log info "Removing ${dst}..."
    rm -f $dst
  fi
done
