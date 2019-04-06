#!/usr/bin/bash -e

DOT_PATH="${DOT_PATH:-${HOME}/dotfiles}"
DOT_BRANCH="${DOT_BRANCH:-master}"

if ! type git; then
    echo 'please install git'
    exit 1
fi

git clone https://github.com/nbitmage/dotfiles -b ${DOT_BRANCH} ${DOT_PATH}

current_path=$(pwd)
cd ${DOT_PATH}
make init
cd ${current_path}
