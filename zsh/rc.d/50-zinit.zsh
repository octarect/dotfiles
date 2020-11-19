declare -A ZINIT
ZINIT[HOME_DIR]=${DOT_CACHE_DIR}/zinit
ZINIT[BIN_DIR]=${ZINIT[HOME_DIR]}/bin
ZINIT[PLUGINS_DIR]=${ZINIT[HOME_DIR]}/plugins
ZINIT[COMPLETIONS_DIR]=${ZINIT[HOME_DIR]}/completions
ZINIT[SNIPPETS_DIR]=${ZINIT[HOME_DIR]}/snippets
ZINIT[ZCOMPDUMP_PATH]=${ZINIT[HOME_DIR]}/.zcompdump
ZINIT[COMPINIT_OPTS]="-C"
ZINIT[MUTE_WARNINGS]=0
ZPFX=${ZINIT[HOME_DIR]}/polaris

if [[ ! -e ${ZINIT[BIN_DIR]} ]]; then
    git clone https://github.com/zdharma/zinit.git ${ZINIT[BIN_DIR]}
fi

source ${ZINIT[BIN_DIR]}/zinit.zsh

autoload -Uz compinit
(( ${+_comps} )) && _comps[zinit]=_zinit
compinit -d ${ZINIT[HOME_DIR]}/.zcompdump

# Repository management
zinit ice wait lucid from"gh-r" as"program" pick"ghq_*/ghq" \
    atclone"git config --global ghq.root ${DEVPATH}/src >/dev/null"
zinit load "x-motemen/ghq"

# Filter UI
zinit ice wait lucid from"gh-r" as"program" mv"peco_*/peco -> peco"
zinit load "peco/peco"

# Translation
zinit ice wait lucid as"program" pick"build/trans" ver"stable" make"build"
zinit load "soimort/translate-shell"

# Image viewer
zinit ice wait lucid as"program" pick"pixterm" \
    atclone"go build ./cmd/pixterm" atpull"%atclone"
zinit load "eliukblau/pixterm"

# Improved cat
zinit ice wait lucid from"gh-r" as"program" mv"bat-*/bat -> bat"
zinit load "sharkdp/bat"

# System monitor
zinit ice wait lucid from"gh-r" as"program" pick"btm"
zinit load "ClementTsang/bottom"

# Data interchange
[ "$(uname)" = "Darwin" ] && jq_branch="*osx*" || jq_branch="*linux64*"
zinit ice wait lucid from"gh-r" ver"latest" as"program" mv"jq-* -> jq" bpick"$jq_branch"
zinit load "stedolan/jq"

zinit ice from"gh-r" as"program" mv"yq_* -> yq"
zinit load "mikefarah/yq"

# Directory specific environment variable
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh"
zinit load "direnv/direnv"

# grep tool
zinit ice from"gh-r" as"program" pick"ripgrep*/rg"
zinit load "BurntSushi/ripgrep"

# VPS
zinit wait lucid for \
    from"gh-r" as"program" mv"scw-* -> scw" atload"source <(scw autocomplete script shell=zsh)" \
        scaleway/scaleway-cli \
    from"gh-r" as"program" atload"source <(doctl completion zsh)" \
        digitalocean/doctl

# Kubernetes
zinit wait lucid has"kubectl" for \
        johanhaleby/kubetail \
    from"gh-r" as"program" mv"k9s-* -> k9s" \
        derailed/k9s \
    from"gh-r" as"program" mv"faas-cli-* -> faas" \
        openfaas/faas-cli \
    from"gh-r" as"program" mv"rio-* -> rio" \
        rancher/rio \
    from"gh-r" as"program" mv"kubebuilder_*/bin/kubebuilder -> kubebuilder" \
        kubernetes-sigs/kubebuilder \
    from"gh-r" bpick"operator-sdk-*" as"program" mv"operator-sdk-* -> operator-sdk" \
        operator-framework/operator-sdk \
    light-mode atload"source <(kubectl completion zsh)" \
        zdharma/null

zinit ice blockf
zinit light zsh-users/zsh-completions
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

if [ "$(uname)" = "Darwin" ]; then
    zinit ice as"program" pick"target/release/starship" \
        atclone"cargo build --release" atpull"%atclone" \
        atload'eval $(starship init zsh)'
else
    zinit ice from"gh-r" as"program" mv"target/*/release/starship -> starship" \
        atload'eval $(starship init zsh)'
fi
zinit light starship/starship

zinit wait lucid light-mode for \
    zsh-users/zsh-history-substring-search \
    zdharma/history-search-multi-word \
    atload"_zsh_highlight" \
        zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions
