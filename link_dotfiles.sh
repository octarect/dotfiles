#! /bin/bash

function log() {
  echo "[$1] $2"
}

DIR=`dirname $0`
if [ -n $XDG_CONFIG_HOME ]; then
  conf_dir=${HOME}/.config
fi

# vim
vimrc=${HOME}/.vimrc
if [ ! -e ${vimrc} ]; then
  ln -s ${DIR}/.vimrc ${vimrc}
else
  log 'WARN' "the file ${vimrc} already exists, and not linked."
fi

# tmux
tmux_conf=${HOME}/.tmux.conf
if [ ! -e ${tmux_conf} ]; then
  ln -s ${DIR}/.tmux.conf ${tmux_conf}
else
  log 'WARN' "the file ${tmux_conf} already exists, and not linked."
fi

# neovim
nvim_dir=${conf_dir}/nvim
if [ ! -e ${nvim_dir} ]; then
  ln -s ${DIR}/.config/nvim ${nvim_dir}
else
  log 'WARN' "the directory ${nvim_dir} already exists, and not linked."
fi
