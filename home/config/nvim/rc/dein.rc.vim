" Dein variables
let g:dein#enable_notification = 1
let g:dein#install_progress_type = 'tabline'

" Directory for dein.vim
let s:dein_cache_dir = g:cache_dir . '/dein'

" Download dein.vim
let s:dein_repo_dir  = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim.git ' . s:dein_repo_dir
endif

" Load dein.vim
execute 'set runtimepath^=' . s:dein_repo_dir

" Load dein's state from the cache script
if !dein#load_state(s:dein_cache_dir)
  finish
endif

let s:dein_toml = g:conf_dir . '/rc/dein/dein.toml'
let s:dein_lazy_toml = g:conf_dir . '/rc/dein/dein.lazy.toml'
let s:dein_ft_toml = g:conf_dir . '/rc/dein/dein.ft.toml'

call dein#begin(s:dein_cache_dir, [
      \ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml, s:dein_ft_toml
      \ ])
call dein#load_toml(s:dein_toml,      {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
call dein#load_toml(s:dein_ft_toml)
call dein#end()
call dein#save_state()

if dein#check_install()
  " Installation check
  call dein#install()
endif
