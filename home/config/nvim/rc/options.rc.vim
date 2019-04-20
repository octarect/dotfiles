"+--------------------------------------+
"| Edit                                 |
"+--------------------------------------+

set tabstop=2
set shiftwidth=2
set expandtab
set smartindent

"+--------------------------------------+
"| Search                               |
"+--------------------------------------+

set ignorecase
set smartcase
set wrapscan

"+--------------------------------------+
"| Appearance                           |
"+--------------------------------------+

" Show number of line
set number
" Show cursor line
set cursorline
" Always show tabline
set showtabline=2
" Show title
set title
" Title length
set titlelen=80

"+--------------------------------------+
"| Misc                                 |
"+--------------------------------------+

" Enable clipboard
set clipboard=unnamedplus

" Keymapping timeout
set timeout
set timeoutlen=1000
" Keycode timeout (ex: <ESC>)
set ttimeout
set ttimeoutlen=10

" Refresh interval (for vim-gitgutter or etc.)
set updatetime=100

" Disale backup and swap
set nobackup
set nowritebackup
set noswapfile

" Auto-reload changed files
set autoread

" Enable cycle-completion for filename in command
set wildmenu
set wildmode=full
