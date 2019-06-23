"+--------------------------------------+
"| Edit                                 |
"+--------------------------------------+

set encoding=utf-8
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent

"+--------------------------------------+
"| Search                               |
"+--------------------------------------+

set ignorecase
set smartcase
set wrapscan
set incsearch

"+--------------------------------------+
"| Appearance                           |
"+--------------------------------------+

" Show number of line
set number
set numberwidth=3
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

" True color
if $COLORTERM == 'truecolor' || $COLORTERM == '24bit' || $TERM =~ '256color'
  " For Neovim 0.1.5 or later
  if has('neovim')
    set termguicolors

  " For Vim 7.4.1799 or later
  elseif has('termguicolors')
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

