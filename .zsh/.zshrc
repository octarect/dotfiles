#################################
# zplug
#################################
# Check if zplug is installed
[[ -f $ZPLUG_HOME/init.zsh ]] || return

source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

zplug "mafredri/zsh-async", from:github
zplug 'plugins/git', from:oh-my-zsh
# zplug 'themes/sorin', from:oh-my-zsh, defer:2, if:"[[ $OSTYPE == *linux* ]]"
zplug 'octarect/thug.zsh', from:github, as:theme, defer:2, if:"[[ $OSTYPE == *linux* ]]"
zplug 'fribmendes/geometry', from:github, as:theme, defer:2, if:"[[ $OSTYPE == *darwin* ]]"
zplug 'mrowa44/emojify', from:github, as:command

zplug "stedolan/jq", from:gh-r, as:command, rename-to:jq
zplug "dzhou121/gonvim", from:gh-r, as:command, use:"*macos*"

zplug "zsh-users/zsh-completions"
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' group-name ''
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:descriptions' format '%d'
zstyle ':completion:*:options' verbose yes
zstyle ':completion:*:values' verbose yes
zstyle ':completion:*:options' prefix-needed yes

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

# alias
case ${OSTYPE} in
  darwin*)
    alias ls="gls --color=auto --show-control-chars"
    alias readlink="greadlink"
    ;;
  linux*)
    alias ls="ls --color=auto --show-control-chars"
    alias grep="grep -a"
    alias hisgre="history | grep"
    ;;
esac
alias nvimconfig="nvim -p ${XDG_CONFIG_HOME}/nvim/init.vim ${XDG_CONFIG_HOME}/nvim/dein.toml ${XDG_CONFIG_HOME}/nvim/dein.lazy.toml"

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

# history
export HISTFILE="${ZDOTDIR}/.zhistory"
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

screenfetch -E
