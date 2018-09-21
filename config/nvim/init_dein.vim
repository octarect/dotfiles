"set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

let s:dein_dir = g:cache_dir . '/dein.vim'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim.git ' . s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

let s:state_dir = g:cache_dir . '/dein.vim'
if !dein#load_state(s:state_dir)
  finish
  exit
end

call dein#begin(s:state_dir)
call dein#load_toml(g:conf_dir . '/dein.toml', {'lazy': 0})
call dein#load_toml(g:conf_dir . '/dein.lazy.toml', {'lazy': 1})
call dein#load_toml(g:conf_dir . '/dein.ctags.toml', {'lazy': 1})
call dein#load_toml(g:conf_dir . '/dein.ft.toml')
call dein#end()
call dein#save_state()

function! s:check_install()
  if dein#check_install()
    " Installation check.
    call dein#install()
    echo 'Plugin installation finished. Please restart your vim!!'
    exit
  endif
endfunction

"autocmd VimEnter * call s:check_install()
call s:check_install()
