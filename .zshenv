# ----- edit the following values depending on your environment -----
export DOTDIR="$HOME/dotfiles"

# ----- environment variables -----
export LANG=en_US.UTF-8
export EDITOR=nvim
export FCEDIT=nvim
export PAGER=less
export SHELL=zsh
export GOPATH="$HOME/code/go"
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$HOME/.pyenv/bin:$PATH"
export TERM=xterm-256color

# ----- configuration store -----
export XDG_CONFIG_HOME=$HOME/.config
export ZDOTDIR="$DOTDIR/.zsh"

# ----- cache -----
export DOTCACHE="$DOTDIR/cache"

# ----- prezto -----
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
 source "${ZDOTDIR:-$HOME}/.zprofile"
fi
