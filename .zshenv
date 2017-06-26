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

# ----- development -----
export DEVPATH="${HOME}/code"
export GOPATH="${DEVPATH}"
export GOROOT=`go env GOROOT`
mkdir -p $DEVPATH/{bin,src,pkg}

# ----- cache -----
export DOTCACHE="$DOTDIR/cache"

# ----- configuration store -----
export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR="$DOTDIR/.zsh"
export ZPLUG_HOME="${DOTCACHE}/.zplug"
export ZPLUG_REPOS="${DEVPATH}/src"
export ZPLUG_BIN="${DEVPATH}/bin"

# ----- default option -----
export LESS='-F -g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

