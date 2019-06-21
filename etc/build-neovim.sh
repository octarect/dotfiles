#!/bin/bash

set -e

NEOVIM_BUILD_DIR="${DOT_LOCAL_DIR}/neovim-build"
CUR_DIR="$(pwd)"

git clone https://github.com/neovim/neovim ${NEOVIM_BUILD_DIR}
cd ${NEOVIM_BUILD_DIR}
make CMAKE_BUILD_TYPE=Release
make
mv ./build/bin/nvim ${DOT_LOCAL_DIR}/bin/nvim
cd ${CUR_DIR}
rm -rf ${NEOVIM_BUILD_DIR}

# Use anyenv
eval "$(${anyenv_bin} init -)"

########################################
# Provider: python
########################################
pylist="$(pyenv install --list | sed -e 's/[[:space:]]//g')"
py2latest=$(echo -n "${pylist}" | grep -E "^2(\.[0-9]+)+$" | tail -n1)
py3latest=$(echo -n "${pylist}" | grep -E "^3.7.[0-9]$" | tail -n1)

pyenv install ${py2latest}
pyenv virtualenv ${py2latest} neovim-python2
pyenv shell neovim-python2
pip install pynvim

pyenv install ${py3latest}
pyenv virtualenv ${py3latest} neovim-python3
pyenv shell neovim-python3
pip install pynvim

########################################
# Provider: ruby
########################################
NEOVIM_RUBY_VERSION=2.6.3
rbenv install ${NEOVIM_RUBY_VERSION}
rbenv shell ${NEOVIM_RUBY_VERSION}
rbenv rehash
gem install neovim
