# ----- edit the following values depending on your environment -----
export DOTDIR="$HOME/dotfiles"

# ----- environment variables -----
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export FCEDIT=nvim
export PAGER=less
export SHELL=zsh
export GOPATH="$HOME/code/go"
export TERM=xterm-256color

# ----- configuration store -----
export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR="$DOTDIR/.zsh"

# ----- cache -----
export DOTCACHE="$DOTDIR/cache"

# ----- default option -----
export LESS='-F -g -i -M -R -S -w -X -z-4'
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# ----- zsh temp -----
if [[ -z "$TMPDIR" ]]; then
  export TMPDIR="/tmp/zsh-$UID"
fi

if [[ ! -d "$TMPDIR" ]]; then
  mkdir "$TMPDIR"
  chmod 700 "$TMPDIR"
fi

