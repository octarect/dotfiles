#################################
# zsh options
#################################
setopt extended_glob

#################################
# path
#################################
typeset -gU path
path=(
  $GOPATH/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.bin(N-/)
  $path 
)

#################################
# history
#################################
source "${ZDOTDIR}/lib/history.zsh"

#################################
# zplug
#################################
# source "${ZDOTDIR}/lib/zplug/plugins.zsh"
source "${ZDOTDIR}/lib/zplugin/plugins.zsh"

#################################
# functions
#################################
source "${ZDOTDIR}/lib/util/aliases.zsh"
source "${ZDOTDIR}/lib/util/functions.zsh"
if [[ $OSTYPE == linux* ]]; then
  source ${ZDOTDIR}/lib/util/linux.zsh
elif [[ $OSTYPE == darwin* ]]; then
  source ${ZDOTDIR}/lib/util/mac.zsh
fi

#################################
# etc
#################################
source ${ZDOTDIR}/lib/etc/common.zsh

#################################
# screenfetch
#################################

if has neofetch; then
  if [ ! -e ${HOME}/.neofetch ]; then
    neofetch -E
  else
    source ${HOME}/.neofetch
  fi
else
  if has screenfetch; then
    if [ ! -e ${HOME}/.screenfetch ]; then
      screenfetch -E
    else
      source ${HOME}/.screenfetch
    fi
  fi
fi
