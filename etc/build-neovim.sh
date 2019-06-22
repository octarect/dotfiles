#!/bin/bash

set -e

NVIM_PREFIX="${HOME}/.local"
NVIM_BUILD_TMP="/tmp/nvim-build-$(date "+%Y%m%d%H%M%S")"

cur_dir="$(pwd)"
git clone https://github.com/neovim/neovim ${NVIM_BUILD_TMP}
cd ${NVIM_BUILD_TMP}
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${NVIM_PREFIX}"
make install
cd ${cur_dir}
rm -rf ${NVIM_BUILD_TMP}

########################################
# Provider: python
########################################

PY2_VENV_NAME=nvim-python2
PY3_VENV_NAME=nvim-python3

# Use anyenv
eval "$(${HOME}/.anyenv/bin/anyenv init -)"

pylist="$(pyenv install --list | sed -e 's/[[:space:]]//g')"

if ! pyenv versions | grep ${PY2_VENV_NAME} 2>&1 1>/dev/null; then
  py2latest=$(echo -n "${pylist}" | grep -E "^2(\.[0-9]+)+$" | tail -n1)
  pyenv install ${py2latest}
  pyenv virtualenv ${py2latest} ${PY2_VENV_NAME}
  pyenv shell ${PY2_VENV_NAME}
  pip install pynvim
fi

if ! pyenv versions | grep ${PY3_VENV_NAME} 2>&1 1>/dev/null; then
  py3latest=$(echo -n "${pylist}" | grep -E "^3.7.[0-9]$" | tail -n1)
  pyenv install ${py3latest}
  pyenv virtualenv ${py3latest} ${PY3_VENV_NAME}
  pyenv shell ${PY3_VENV_NAME}
  pip install pynvim
fi
