#!/usr/bin/env bash

TMUX_PLUGINS_DIR="${HOME}/.tmux/plugins"
TPM_REPO_URL="https://github.com/tmux-plugins/tpm"

mkdir -p ${TMUX_PLUGINS_DIR}

git clone ${TPM_REPO_URL} ${TMUX_PLUGINS_DIR}/tpm
