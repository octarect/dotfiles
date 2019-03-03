#!/usr/bin/env zsh

# [todo] configurations should be placed on .zshenv
declare -A ZPLGM
ZPLGM[HOME_DIR]="${HOME}/.local/etc/dotfiles/zplugin"
ZPLGM[BIN_DIR]="${ZPLGM[HOME_DIR]}/bin"
ZPLGM[PLUGINS_DIR]="${ZPLGM[HOME_DIR]}/plugins"
ZPLGM[COMPLETIONS_DIR]="${ZPLGM[HOME_DIR]}/root_completions"
ZPLGM[SNIPPETS_DIR]="${ZPLGM[HOME_DIR]}/snippets"
ZPLG_REPO="https://github.com/zdharma/zplugin.git"

if [ ! -s ${ZPLGM[HOME_DIR]} ]; then
  mkdir -p ${ZPLGM[HOME_DIR]}
  git clone ${ZPLG_REPO} ${ZPLGM[BIN_DIR]}
fi

autoload -Uz compinit

source "${ZPLGM[BIN_DIR]}/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin


# zplugin ice from'gh-r' as'command' mv'gotcha_* -> gotcha'
# zplugin light 'b4b4r07/gotcha'

zplugin ice from"gh-r" as"program" atload"git config --global ghq.root ${DEVPATH}"
zplugin load "motemen/ghq"

zplugin ice from"gh-r" as"program" mv"peco_*/peco -> peco"
zplugin load "peco/peco"

zplugin ice from"gh" as"program" ver"stable" atinit"make build" pick"build/trans"
zplugin load "soimort/translate-shell"

zplugin snippet 'OMZ::plugins/git/git.plugin.zsh'

zplugin light "zsh-users/zsh-completions"
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

compinit
zplugin cdreplay -q

zplugin ice wait'1' atload'_zsh_highlight'
zplugin light 'zdharma/fast-syntax-highlighting'

zplugin light 'zsh-users/zsh-history-substring-search'

zplugin ice wait'1' atload'_zsh_autosuggest_start'
zplugin light 'zsh-users/zsh-autosuggestions'

zplugin ice pick'spaceship.zsh' wait'!0'
zplugin light 'denysdovhan/spaceship-zsh-theme'

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D{%F %H:%M:%S}"
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_PREFIX=${SPACESHIP_PROMPT_DEFAULT_SUFFIX}
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_PREFIX="@"

SPACESHIP_PROMPT_ORDER=(
  dir           # Current directory section
  user          # Username section
  host          # Hostname section
  time          # Time stamps section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
