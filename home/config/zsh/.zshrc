#!/usr/bin/env zsh

source ${HOME}/.dotenv
source ${DOT_DIR}/src/dotlib/init.sh

# Create cache directory
mkdir -p "${DOT_CACHE_DIR}/zsh"

#################################
# zsh options
#################################
setopt extended_glob

#################################
# Enable Nix package manager
#################################
__dotlib::load_nix

#################################
# Load additional config
#################################
for file in $(find ${ZDOTDIR}/rc.d -maxdepth 1 -type f | sort)
do
    source ${file}
done
