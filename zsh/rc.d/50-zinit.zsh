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
    git clone https://github.com/zdharma-continuum/zinit.git ${ZINIT[BIN_DIR]}
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
zinit ice wait lucid from"gh-r" as"program"
zinit load junegunn/fzf

# Translation
zinit ice wait lucid as"program" pick"build/trans" make"build"
zinit load "soimort/translate-shell"

# Image viewer
zinit ice wait lucid as"program" pick"pixterm" \
    atclone"go build ./cmd/pixterm" atpull"%atclone"
zinit load "eliukblau/pixterm"

# Improved cat
zinit ice wait lucid from"gh-r" as"program" mv"bat-*/bat -> bat" atload"alias cat=bat"
zinit load "sharkdp/bat"

# System monitor
zinit ice wait lucid from"gh-r" as"program" pick"btm" atload"alias top=btm"
zinit load "ClementTsang/bottom"

# Directory specific environment variable
zinit ice from"gh-r" as"program" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh"
zinit load "direnv/direnv"

# grep tool
zinit ice from"gh-r" as"program" pick"ripgrep*/rg"
zinit load "BurntSushi/ripgrep"

# S3 client
zinit ice wait lucid as"program" pick"mc" \
    atclone"make build" atpull"%atclone"
zinit load "minio/mc"

# Kubernetes
zinit wait lucid has"kubectl" for \
        johanhaleby/kubetail \
    from"gh-r" as"program" \
        derailed/k9s \
    from"gh-r" as"program" bpick"cfssl_*" mv"cfssl_* -> cfssl" id-as"cloudflare/cfssl@cfssl" \
        cloudflare/cfssl \
    from"gh-r" as"program" bpick"cfssljson_*" mv"cfssljson_* -> cfssljson" id-as"cloudflare/cfssl@cfssljson" \
        cloudflare/cfssl \
    from"gh-r" as"program" bpick"operator-sdk_*" mv"operator-sdk_* -> operator-sdk" \
        operator-framework/operator-sdk \
    light-mode atload"source <(kubectl completion zsh)" \
        zdharma-continuum/null

# GitHub CLI
zinit ice lucid wait"0" as"program" from:"gh-r" \
    bpick"*(linux|macos)*.(tar.gz|zip)" \
    mv"gh_*/bin/gh -> gh" bpick"*.tar.gz" \
    atload"source <(gh completion -s zsh)"
zinit light "cli/cli"

# Local runner of GitHub Actions
zinit ice lucid wait"0" as"program" from"gh-r"
zinit light "nektos/act"

# OpenCode
# `bpick` will ignore musl and baseline binaries.
zinit ice lucid wait"0" as"program" from"gh-r" bpick"opencode-(linux|darwin)-*.(tar.gz|zip)"
zinit light "anomalyco/opencode"

# GitHub Copilot
zinit ice lucid wait"0" as"program" from"gh-r" bpick"copilot-(linux|darwin)-*.tar.gz"
zinit light "github/copilot-cli"

# Tree-sitter CLI for Neovim
if [ "$(uname)" = "Darwin" ]; then
    zinit ice lucid wait"0" as"program" from"gh-r" bpick"tree-sitter-cli-macos-*"
else
    zinit ice lucid wait"0" as"program" from"gh-r" bpick"tree-sitter-cli-linux-*"
fi
zinit light "tree-sitter/tree-sitter"

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
    zinit ice from"gh-r" as"program" atload'eval "$(starship init zsh)"'
else
    zinit ice from"gh-r" as"program" mv"target/*/release/starship -> starship" \
        atload'eval "$(starship init zsh)"'
fi
zinit light starship/starship

zinit wait lucid light-mode for \
    atload"bindkey '^P' history-substring-search-up" \
    atload"bindkey '^N' history-substring-search-down" \
    zsh-users/zsh-history-substring-search \
    zdharma-continuum/history-search-multi-word \
    atload"_zsh_highlight" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"!_zsh_autosuggest_start" \
    atload"bindkey '^X' autosuggest-accept" \
        zsh-users/zsh-autosuggestions
