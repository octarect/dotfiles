#!/usr/bin/bash -e

DOT_DIR="${DOT_DIR:-${HOME}/dotfiles}"
DOT_BRANCH="${DOT_BRANCH:-master}"

if ! type git; then
    echo 'please install git'
    exit 1
fi

git clone https://github.com/rkoder/dotfiles -b ${DOT_BRANCH} ${DOT_DIR}

current_path=$(pwd)
cd ${DOT_DIR}
make install
cd ${current_path}
