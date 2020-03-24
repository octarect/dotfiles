#!/usr/bin/env zsh

source ${HOME}/.dotenv
source ${DOT_DIR}/lib/dotlib/init.sh

# Create cache directory
mkdir -p "${DOT_CACHE_DIR}/zsh"

#################################
# zsh options
#################################
setopt extended_glob

#################################
# path
#################################
typeset -gU path
path=(
    ${DOT_DIR}/bin(N-/)
    ${HOME}/.local/bin(N-/)
    ${path}
)
if which ruby >/dev/null && which gem >/dev/null; then
    path=($(ruby -r rubygems -e 'puts Gem.user_dir')/bin(N-/) ${path})
fi

#################################
# History
#################################
export HISTFILE="${DOT_CACHE_DIR}/zsh/.zhistory"
export HISTSIZE=5000
export SAVEHIST=20000

#################################
# Load additional config
#################################
for file in $(find ${ZDOTDIR}/rc.d/*.zsh -maxdepth 1 -type f | sort)
do
    source ${file}
done
