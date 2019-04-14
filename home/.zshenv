#!/usr/bin/env zsh

########################################
# system
########################################
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export FCEDIT=nvim
export PAGER=less
export SHELL=zsh
export TERM=xterm-256color

export LESS="-F -g -i -M -R -S -w -X -z-4"
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

########################################
# path
########################################
setopt no_global_rcs
if [ -L /sbin ]; then
    export path=(/bin /usr/bin)
fi
export path=(
    /usr/local/bin(N-/)
    ${path}
)

########################################
# configuration path
########################################
export XDG_CONFIG_HOME=${HOME}/.config
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

########################################
# development
########################################
export DEVPATH="${HOME}/code"
mkdir -p ${DEVPATH}/{bin,src,pkg}

# Go
export GOPATH="${DEVPATH}"
export GOROOT=`go env GOROOT`
