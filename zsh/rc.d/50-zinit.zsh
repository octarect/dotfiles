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
zinit ice from"gh-r" as"program" pick"ghq_*/ghq" \
    atclone"git config --global ghq.root ${DEVPATH}/src >/dev/null"
zinit load "x-motemen/ghq"

# Filter UI
zinit ice from"gh-r" as"program" mv"peco_*/peco -> peco"
zinit load "peco/peco"

# Translation
zinit ice as"program" pick"build/trans" ver"stable" make"build"
zinit load "soimort/translate-shell"

# Image viewer
zinit ice as"program" pick"pixterm" \
    atclone"go build ./cmd/pixterm" atpull"%atclone"
zinit load "eliukblau/pixterm"

zinit ice from"gh-r" as"program" mv"bat-*/bat -> bat"
zinit load "sharkdp/bat"

# System monitor
zinit ice from"gh-r" as"program"
zinit load "cjbassi/ytop"

# Data interchange
if [ "$(uname)" = "Darwin" ]; then
    zinit ice from"gh-r" ver"latest" as"program" mv"jq-* -> jq" bpick:"*osx*"
else
    zinit ice from"gh-r" ver"latest" as"program" mv"jq-* -> jq" bpick:"*linux64*"
fi
zinit load "stedolan/jq"

zinit ice from"gh-r" as"program" mv"yq_* -> yq"
zinit load "mikefarah/yq"

# Directory specific environment variable
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh"
zinit light "direnv/direnv"

# grep tool
zinit ice from"gh-r" as"program" pick"ripgrep*/rg"
zinit light "BurntSushi/ripgrep"

zinit ice from"gh-r" as"program" mv"scw-* -> scw" \
    atload'source <(scw autocomplete script shell=zsh)'
zinit load "scaleway/scaleway-cli"

if __dotlib::util::has_cmd kubectl; then
    zinit ice from"gh" as"program"
    zinit load "johanhaleby/kubetail"

    zinit ice from"gh-r" as"program" mv"k9s-* -> k9s"
    zinit load "derailed/k9s"

    # OpenFaaS
    zinit ice from"gh-r" as"program" mv"faas-cli-* -> faas"
    zinit load "openfaas/faas-cli"

    # Rancher rio
    zinit ice from"gh-r" as"program" mv"rio-* -> rio"
    zinit load "rancher/rio"
    source <(kubectl completion zsh)

    # kubebuilder
    zinit ice from"gh-r" as"program" mv"kubebuilder_*/bin/kubebuilder -> kubebuilder"
    zinit load "kubernetes-sigs/kubebuilder"
fi

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

zinit wait lucid for \
        light-mode zsh-users/zsh-history-substring-search \
        light-mode zdharma/history-search-multi-word \
    atload"_zsh_highlight" \
        light-mode zdharma/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
        light-mode zsh-users/zsh-autosuggestions
