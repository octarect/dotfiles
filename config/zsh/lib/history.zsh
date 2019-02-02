#!/usr/bin/env zsh

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
