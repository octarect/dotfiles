#!/usr/bin/env bash

anyenv_path=${HOME}/.anyenv
anyenv_bin=${anyenv_path}/bin/anyenv

eval "$(${anyenv_bin} init - --no-rehash)"

virtualenv_path="$(pyenv root)/plugins/pyenv-virtualenv"
if [ ! -e ${virtualenv_path} ]; then
    git clone https://github.com/yyuu/pyenv-virtualenv ${virtualenv_path}
fi

py2latest=$(pyenv install --list | grep -E "^\s*2(\.[0-9]+)+$" | tail -n1 | sed 's/\s\s*//')
# py3latest=$(pyenv install --list | grep -E "^\s*3(\.[0-9]+)+$" | tail -n1 | sed 's/\s\s*//')
py3latest="3.6.0"

pyenv versions | grep neovim-2 && :
if [ $? -ne 0 ]; then
    pyenv install ${py2latest}
    pyenv virtualenv ${py2latest} neovim-2
    pyenv shell neovim-2
    pip install -U pip
    pip install neovim
fi

pyenv versions | grep neovim-3 && :
if [ $? -ne 0 ]; then
    pyenv install ${py3latest}
    pyenv virtualenv ${py3latest} neovim-3
    pyenv shell neovim-3
    pip install -U pip
    pip install neovim
fi
