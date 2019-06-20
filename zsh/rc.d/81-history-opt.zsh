# Path of history file
export HISTFILE="${DOT_CACHE_DIR}/zsh/.zhistory"
# History size on RAM
export HISTSIZE=10000
# Number of history in $HISTFILE
export SAVEHIST=50000

# Options
# Remove blanks when command-line being added to history
setopt hist_reduce_blanks
# Remove command-line starting from space in history
# No duplications in history
setopt hist_ignore_all_dups
# Append history incrementally
setopt inc_append_history
# Do not record `history` command
setopt hist_no_store
# Record start time and end time
setopt extended_history
# Compatible with bash
setopt hist_expand
# Share history between all windows
setopt share_history
