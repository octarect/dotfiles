#!/usr/bin/env bash -e

ANYENV_GIT_REPO=https://github.com/riywo/anyenv
ANYENV_PATH=${DOT_TMP_PATH}/.anyenv

if [ ! -e ${ANYENV_PATH} ]; then
    git clone ${ANYENV_GIT_REPO} ${ANYENV_PATH}
fi
