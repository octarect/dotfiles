SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D{%F %H:%M:%S}"
SPACESHIP_USER_SHOW=always
SPACESHIP_USER_PREFIX=${SPACESHIP_PROMPT_DEFAULT_SUFFIX}
SPACESHIP_USER_SUFFIX=""
SPACESHIP_HOST_SHOW=always
SPACESHIP_HOST_PREFIX="@"

SPACESHIP_PROMPT_ORDER=(
	dir           # Current directory section
	user          # Username section
	host          # Hostname section
	time          # Time stamps section
	git           # Git section (git_branch + git_status)
	# hg            # Mercurial section (hg_branch  + hg_status)
	package       # Package version
	node          # Node.js section
	ruby          # Ruby section
	elixir        # Elixir section
	# xcode         # Xcode section
	# swift         # Swift section
	# golang        # Go section
	php           # PHP section
	# rust          # Rust section
	# haskell       # Haskell Stack section
	# julia         # Julia section
	docker        # Docker section
	# aws           # Amazon Web Services section
	# venv          # virtualenv section
	# conda         # conda virtualenv section
	pyenv         # Pyenv section
	# dotnet        # .NET section
	# ember         # Ember.js section
	# kubecontext   # Kubectl context section
	terraform     # Terraform workspace section
	exec_time     # Execution time
	line_sep      # Line break
	# battery       # Battery level and status
	vi_mode       # Vi-mode indicator
	jobs          # Background jobs indicator
	exit_code     # Exit code section
	char          # Prompt character
)
