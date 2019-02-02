# ----- edit the following values depending on your environment -----
export DOTDIR="$HOME/dotfiles"

# ----- environment variables -----
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export FCEDIT=nvim
export PAGER=less
export SHELL=zsh
export TERM=xterm-256color

# ----- additional path -----
export PATH="/usr/local/bin:${PATH}"

# ----- development -----
export DEVPATH="${HOME}/code"
export GOPATH="${DEVPATH}"
export GOROOT=`go env GOROOT`
export GO15VENDOREXPERIMENT=1
mkdir -p ${DEVPATH}/{bin,src,pkg,zplug_repos}

# ----- erlang -----
export ERL_AFLAGS="-kernel shell_history enabled"

# ----- cache -----
export DOTCACHE="${DOTDIR}/cache"

# ----- configuration store -----
export XDG_CONFIG_HOME=${HOME}/.config
export ZDOTDIR="${DOTDIR}/config/zsh/"
export ZPLUG_HOME="${DEVPATH}/src/github.com/zplug/zplug"
export ZPLUG_REPOS="${DEVPATH}/zplug_repos"
export ZPLUG_BIN="${DEVPATH}/bin"

# ----- default option -----
export LESS='-F -g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

