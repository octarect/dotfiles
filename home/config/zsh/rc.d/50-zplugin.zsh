#
#                 888                d8b
#                 888                Y8P
#                 888
# 8888888888888b. 888888  888 .d88b. 88888888b.
#    d88P 888 "88b888888  888d88P"88b888888 "88b
#   d88P  888  888888888  888888  888888888  888
#  d88P   888 d88P888Y88b 888Y88b 888888888  888
# 8888888888888P" 888 "Y88888 "Y88888888888  888
#         888                     888
#         888                Y8b d88P
#         888                 "Y88P"
#

declare -A ZPLGM
ZPLGM[HOME_DIR]=${DOT_CACHE_DIR}/zplugin
ZPLGM[BIN_DIR]=${ZPLGM[HOME_DIR]}/bin
ZPLGM[PLUGINS_DIR]=${ZPLGM[HOME_DIR]}/plugins
ZPLGM[COMPLETIONS_DIR]=${ZPLGM[HOME_DIR]}/completions
ZPLGM[SNIPPETS_DIR]=${ZPLGM[HOME_DIR]}/snippets
ZPLGM[ZCOMPDUMP_PATH]=${ZPLGM[HOME_DIR]}/.zcompdump
ZPLGM[COMPINIT_OPTS]="-C"
ZPLGM[MUTE_WARNINGS]=0
ZPFX=${ZPLGM[HOME_DIR]}/polaris

if [[ ! -e ${ZPLGM[BIN_DIR]} ]]; then
    git clone https://github.com/zdharma/zplugin.git ${ZPLGM[BIN_DIR]}
fi

# Load zplugin.
source ${ZPLGM[BIN_DIR]}/zplugin.zsh

# ghq
zplugin ice from"gh-r" as"program" atload"git config --global ghq.root ${DEVPATH}"
zplugin load "motemen/ghq"

# peco
zplugin ice from"gh-r" as"program" mv"peco_*/peco -> peco"
zplugin load "peco/peco"

# Zsh completions
zplugin light zsh-users/zsh-completions
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

# Enable completion
autoload -Uz compinit
compinit -d ${DOT_CACHE_DIR}/zsh/.zcompdump
zplugin cdreplay -q

# Syntax highlight future
zplugin ice wait'1' atload'_zsh_highlight'
zplugin light zdharma/fast-syntax-highlighting

# Auto-suggestion of command, based on history.
zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

# History search future
# It must be loaded after `zsh-syntax-highlighting`.
# See README.md on its Github repo for details.
zplugin light zsh-users/zsh-history-substring-search

# Load prompt.
zplugin ice pick'spaceship.zsh' wait'!0'
zplugin light denysdovhan/spaceship-zsh-theme
