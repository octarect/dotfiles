#!/usr/bin/env zsh

source ${HOME}/.dotenv
source ${DOT_DIR}/src/dotlib/init.sh

# Create cache directory
mkdir -p "${DOT_CACHE_DIR}/zsh"

#################################
# zsh options
#################################
setopt extended_glob
