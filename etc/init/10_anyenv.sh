#!/usr/bin/env bash -e

ANYENV_GIT_REPO=https://github.com/riywo/anyenv

anyenv_path=${HOME}/.anyenv
anyenv_bin=${anyenv_path}/bin/anyenv

if [ ! -e ${anyenv_path} ]; then
    git clone ${ANYENV_GIT_REPO} ${anyenv_path}
fi

if [ ! -e ${HOME}/.config/anyenv/anyenv-install ]; then
    ${anyenv_bin} install --init
fi

eval "$(${anyenv_bin} init - --no-rehash)"

${anyenv_bin} install pyenv
${anyenv_bin} install rbenv
