# alias
alias ls="ls --color=auto --show-control-chars"
alias grep="grep -a"
alias hisgre="history | grep"
alias gdrive_m='google-drive-ocamlfuse ~/googledrive'
alias gdrive_u='fusermount -u ~/googledrive'

function transfer() {
  curl --upload-file ./$1 https://transfer.sh/$1
}

function checkout() {
  mkdir $1
  cd $1
}

function has() {
  builtin command -v $1 > /dev/null
  echo $?
}

# misc
function hexdig() { echo "obase=10; ibase=16; $1" | bc }
function dighex() { echo "obase=16; ibase=10; $1" | bc }
function bindig() { echo "obase=10; ibase=2; $1" | bc }
function digbin() { echo "obase=2; ibase=10; $1" | bc }
function hexbin() { echo "obase=2; ibase=16; $1" | bc }
function binhex() { echo "obase=16; ibase=2; $1" | bc }

# history
export HISTSIZE=5000
export SAVEHIST=10000
# 履歴を共有
setopt share_history
function history-all { history -E 1 }
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt extended_history
# スペースで始まるコマンド行はヒストリリストから削除
setopt hist_ignore_space
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# 古いコマンドと同じものは無視
setopt hist_save_no_dups
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 履歴をインクリメンタルに追加
setopt inc_append_history
# インクリメンタルからの検索
# bindkey "^R" history-incremental-search-backward
# bindkey "^S" history-incremental-search-forward
# # コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

typeset -gU path
path=(
  $GOPATH/bin(N-/)
  $HOME/.cargo/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.bin(N-/)
  $path 
)
if [ `has rbenv` ]; then
  rbenv_root=($HOME/.rbenv)
  eval "$(rbenv init -)"
  GEM_HOME=$(ruby -e 'print Gem.user_dir')
fi

if [ `has pyenv` ]; then
  pyenv_root=($HOME/.pyenv)
  eval "$(pyenv init -)"
fi

if [ `has thefuck` ]; then
  eval $(thefuck --alias)
fi

if [ `has ghq` -a `has peco` ]; then
  function peco-src() {
    local src=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
      cd "$src"
    fi
  }
  alias pcd='peco-src'
fi

# Source Prezto.
if [[ -s "${DOTCACHE:-$HOME}/.zprezto/init.zsh" ]]; then
 source "${DOTCACHE:-$HOME}/.zprezto/init.zsh"
fi

screenfetch
