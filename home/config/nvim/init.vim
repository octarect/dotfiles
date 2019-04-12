let g:cache_dir = expand('~/.cache/nvim')
if !isdirectory(g:cache_dir)
  execute '!mkdir -p ' . g:cache_dir
endif
let g:conf_dir = expand('~/.config/nvim')

"execute 'set runtimepath^=' . g:conf_dir

let s:init_dein_path = g:conf_dir . '/init_dein.vim'
if filereadable(s:init_dein_path)
  execute 'source ' . s:init_dein_path
endif

let s:init_tab_path = g:conf_dir . '/init_tab.vim'
if filereadable(s:init_tab_path)
  execute 'source ' . s:init_tab_path
endif

"# Feature
set clipboard=unnamedplus
set ttimeout
set timeoutlen=500
set nobackup
set noswapfile
"## for vim-gitgutter
set updatetime=100

"# Edit
set number
set cursorline
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

"# Search
set ignorecase
set smartcase
set wrapscan
