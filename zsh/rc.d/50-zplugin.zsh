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

# translate-shell
zplugin ice from"gh" as"program" ver"stable" make"build" pick"build/trans"
zplugin load "soimort/translate-shell"

# ghq
zplugin ice from"gh-r" as"program" pick"ghq_*/ghq" atinit"git config --global ghq.root ${DEVPATH}/src >/dev/null"
zplugin load "motemen/ghq"

# peco
zplugin ice from"gh-r" as"program" mv"peco_*/peco -> peco"
zplugin load "peco/peco"

# rancher
zplugin ice from"gh-r" as"program" mv"rancher-*/rancher -> rancher"
zplugin load "rancher/cli"

# pixterm
zplugin ice from"gh" as"program" atinit"go get -d && go build -o pixterm" pick"pixterm"
zplugin load "eliukblau/pixterm"

# bat
zplugin ice from"gh-r" as"program" mv"bat-*/bat -> bat"
zplugin load "sharkdp/bat"

# gotop
zplugin ice from"gh-r" as"program" mv"gotop-*/gotop -> gotop"
zplugin load "cjbassi/gotop"

# jq
if [ "$(uname)" = "Darwin" ]; then
  zplugin ice from"gh-r" as"program" mv"jq-* -> jq" bpick:"*osx*"
else
  zplugin ice from"gh-r" as"program" mv"jq-* -> jq"
fi
zplugin load "stedolan/jq"

zplugin ice from"gh" as"program"
zplugin load "johanhaleby/kubetail"

zplugin ice from"gh-r" as"program" mv"direnv* -> direnv" atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src"zhook.zsh"
zplugin light direnv/direnv

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
compinit -d ${ZPLGM[HOME_DIR]}/.zcompdump
zplugin cdreplay -q

if __dotlib::util::has_cmd kubectl; then
  source <(kubectl completion zsh)
fi

# Syntax highlight feature
zplugin ice wait'0' atload'_zsh_highlight'
zplugin light zdharma/fast-syntax-highlighting

# Auto-suggestion of command, based on history.
zplugin ice wait'0' atload'_zsh_autosuggest_start'
zplugin light zsh-users/zsh-autosuggestions

# History search feature
# It must be loaded after `zsh-syntax-highlighting`.
# See README.md on its Github repo for details.
zplugin light zsh-users/zsh-history-substring-search

zplugin ice wait'0' as"program" from"gh" mv"gdown.pl -> gdown"
zplugin load circulosmeos/gdown.pl

# Load prompt.
zplugin ice as'program' from'gh-r' atload'eval $(starship init zsh)' ver'v0.25.0'
zplugin light starship/starship
