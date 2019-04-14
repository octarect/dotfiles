#!/usr/bin/env bash

ANYENV_GIT_REPO=https://github.com/riywo/anyenv

anyenv_path=${HOME}/.anyenv
anyenv_bin=${anyenv_path}/bin/anyenv

if [ ! -e ${anyenv_path} ]; then
    git clone ${ANYENV_GIT_REPO} ${anyenv_path}
fi

if [ ! -e ${HOME}/.config/anyenv/anyenv-install ]; then
    yes | ${anyenv_bin} install --init
fi

if ! ${anyenv_bin} versions | grep pyenv >/dev/null; then
  ${anyenv_bin} install pyenv
else
  __dotlib::log info "pyenv is already installed."
fi

if ! ${anyenv_bin} versions | grep rbenv >/dev/null; then
  ${anyenv_bin} install rbenv
else
  __dotlib::log info "rbenv is already installed."
fi

eval "$(${anyenv_bin} init -)"

py36latest=$(pyenv install --list | grep -E "^\s*3.6.[0-9]$" | tail -n1 | sed 's/\s\s*//')
pyenv install ${py36latest}
pyenv global ${py36latest}
