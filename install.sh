#!/bin/sh

function has() {
  builtin command -v $1 > /dev/null
  echo $?
}

DIR=$(cd $(dirname $0) && pwd)
if [ -n $XDG_CONFIG_HOME ]; then
  conf_dir=${HOME}/.config
else
  conf_dir=$XDG_CONFIG_HOME
fi

# dependencies
if [ ! `has zsh` ]; then
  echo "first of all, you need to install zsh. install zsh, now."
  exit
fi

# zsh
zshenv=${HOME}/.zshenv
if [ ! -e ${zshenv} ]; then
  ln -s ${DIR}/.zshenv ${zshenv}
fi

source $zshenv

prezto="${DIR}/cache/.zprezto"
if [ ! -s $prezto ]; then
  if [ `has git` ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git $prezto
  else
    echo "git is not installed. cannot use prezto."
  fi
else
  echo "${prezto} already exists"
fi

# vim
vimrc=${HOME}/.vimrc
if [ ! -e ${vimrc} ]; then
  ln -s ${DIR}/.vimrc ${vimrc}
else
  echo "${vimrc} already exists"
fi

# tmux
tmux_conf=${HOME}/.tmux.conf
if [ ! -e ${tmux_conf} ]; then
  ln -s ${DIR}/.tmux.conf ${tmux_conf}
else
  echo "${tmux_conf} already exists"
fi

# alacritty
alac_dir=${conf_dir}/alacritty
if [ ! -e ${alac_dir} ]; then
  ln -s ${DIR}/.config/alacritty ${alac_dir}
else
  echo "${alac_dir} already exists"
fi

# neovim
nvim_dir=${conf_dir}/nvim
if [ ! -e ${nvim_dir} ]; then
  ln -s ${DIR}/.config/nvim ${nvim_dir}
else
  echo "${nvim_dir} already exists"
fi
