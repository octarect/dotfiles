"-----------------------------------------------------------
" Edit
"-----------------------------------------------------------

set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround
set smartindent
set smarttab

"-----------------------------------------------------------
" Search
"-----------------------------------------------------------

set ignorecase
set smartcase
set wrapscan
set incsearch

"-----------------------------------------------------------
" Appearance
"-----------------------------------------------------------

set number
set numberwidth=4
set relativenumber
set showtabline=2
set title
set titlelen=80

" Show signcolumns by default
set signcolumn=yes

" Disable tilde on blank line
set fcs+=eob:\ 

" Show cursorline only in current window
set cursorline
autocmd WinEnter * set cursorline
autocmd WinLeave * set nocursorline

"-----------------------------------------------------------
" Misc
"-----------------------------------------------------------

" Enable clipboard
set clipboard=unnamedplus

" Delete indent and newline by backspace
set backspace=indent,eol,start

" Keymapping timeout
set timeout
set timeoutlen=1000
set ttimeout " For keycode (ex: <ESC>)
set ttimeoutlen=50

" Refresh interval
set updatetime=250

" Split direction
set splitbelow
set splitright

" Auto-reload changed file
set autoread

set swapfile
set nobackup
set nowritebackup

" Persist undo
set undofile
let &g:undodir = g:rc#cache_path . '/undo'

set shortmess=aTIc

" Enable cycle-completion for filename in command
set wildmenu
set wildmode=full
set wildoptions+=pum

" Show <Tab> and <EOL>
set list
set listchars=tab:>·,nbsp:+,trail:·,extends:→,precedes:←

" Height of commnad-line window
set cmdheight=2

" Transparency
" set pumblend=10
augroup Transparent
  autocmd!
  autocmd FileType denite set winblend=5
  autocmd FileType denite-filter set winblend=5
  " autocmd FileType deol set winblend=5
augroup END
