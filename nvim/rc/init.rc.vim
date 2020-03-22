if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
  autocmd VimResized * wincmd =
  autocmd BufWritePost,FileWritePost, *.vim,*.toml
    \ source $MYVIMRC | redraw
augroup END

" Use <Leader> in global plugin
let g:mapleader = "\<Space>"
" Use <LocalLeader> in filetype plugin
let g:maplocalleader = 'm'
" Release default keymappings for plugin leader.
nnoremap <Space> <Nop>
nnoremap m <Nop>

"-----------------------------------------------------------
" Disable default plugins
"-----------------------------------------------------------

let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_2html_plugin      = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_rrhelper          = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_logiPat           = 1
" let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1

"-----------------------------------------------------------
" Load core features
"-----------------------------------------------------------

call rc#source_rc('dein.rc.vim')

filetype plugin indent on
if has('vim_starting')
  syntax enable
endif

call rc#source_rc('options.rc.vim')
call rc#source_rc('mappings.rc.vim')

if has('nvim')
  set termguicolors
endif

if ! exists('g:colors_name')
  call rc#init_color()
endif

set secure
