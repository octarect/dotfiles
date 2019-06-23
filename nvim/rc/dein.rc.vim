" Dein variables
let g:dein#enable_notification = 1
let g:dein#install_progress_type = 'title'
let g:dein#auto_recache = 1

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

call dein#begin(s:dein_cache_dir, [ expand('<sfile>') ] + glob(g:conf_dir . 'rc/dein/*.toml', 1, 1))

" Load non-lazy plugins (dein/*.toml)
for toml in filter(glob(g:conf_dir . '/rc/dein/*.toml', 1, 1), 'v:val !~# ''lazy\.toml$''')
  call dein#load_toml(toml, { 'lazy': 0 })
endfor

" Load lazy plugins (dein/*.lazy.toml)
for toml in glob(g:conf_dir . '/rc/dein/*.lazy.toml', 1, 1)
  call dein#load_toml(toml, { 'lazy': 1 })
endfor

call dein#end()
call dein#save_state()

filetype plugin indent on
syntax enable

if dein#check_install()
  " Installation check
  call dein#install()
endif
