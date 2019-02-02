#!/usr/bin/env zsh

if [ ! -e ${HOME}/.anyenv ]; then
  git clone https://github.com/riywo/anyenv ~/.anyenv
fi
path=(${HOME}/.anyenv/bin $path)
eval "$(anyenv init - --no-rehash)"

if has thefuck; then
  eval $(thefuck --alias)
fi

if [[ $OSTYPE == linux* ]]; then
  source "${ZDOTDIR}/lib/etc/linux.zsh"
elif [[ $OSTYPE == darwin* ]]; then
  source "${ZDOTDIR}/lib/etc/mac.zsh"
fi
