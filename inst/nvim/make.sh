#!/bin/sh

RM="rm -rf"
EXE="/bin/sh -cx"

dir=$(cd $(dirname $0) && pwd)
repo_dir=${dir}/../..
. ${repo_dir}/sh/util.sh
. ${repo_dir}/env.sh

if has anyenv; then
  if [ "$1" = "install" ]; then
    anyenv install pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv

    eval "$(anyenv init - --no-rehash)"

    py2latest=$(pyenv install --list | grep -E "^\s*2(\.[0-9]+)+$" | tail -n1)
    py3latest=$(pyenv install --list | grep -E "^\s*3(\.[0-9]+)+$" | tail -n1)
    pyenv install ${py2latest}
    pyenv install ${py3latest}
    pyenv virtualenv ${py2latest} neovim-2
    pyenv virtualenv ${py3latest} neovim-3
    pyenv shell neovim-2
    pip install neovim
    pyenv shell neovim-3
    pip install neovim
  elif [ "$1" = "clean" ]; then
    anyenv uninstall pyenv
  fi
else
  log warn "anyenv is required by make script for nvim"
fi
