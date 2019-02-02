#!/usr/bin/env zsh

# Check if zplug is installed
if [ ! -s $ZPLUG_HOME ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

zplug "mafredri/zsh-async", from:github
zplug 'plugins/git', from:oh-my-zsh
zplug 'nbitmage/clarity.zsh', from:github, as:theme, defer:2

zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "motemen/ghq", from:gh-r, as:command, rename-to:ghq, \
  hook-load:"git config --global ghq.root ${DEVPATH}/src"
zplug "peco/peco", from:gh-r, as:command
zplug "soimort/translate-shell", from:github, at:stable, \
  as:command, use:"build/*", \
  hook-build: "make build &> /dev/null"
zplug "cjbassi/gotop", from:gh-r, as:command

zplug "zsh-users/zsh-completions"
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

# Load plugins depending on OS
if [[ $OSTYPE == linux* ]]; then
  source "${ZDOTDIR}/lib/zplug/plugins_linux.zsh"
elif [[ $OSTYPE == darwin* ]]; then
  source "${ZDOTDIR}/lib/zplug/plugins_mac.zsh"
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  else
    echo
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

