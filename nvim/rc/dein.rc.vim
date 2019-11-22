"-----------------------------------------------------------
" Dark powered plugin management
"-----------------------------------------------------------

let g:dein#install_max_processes = 16
let g:dein#enable_notification = 1
let g:dein#install_progress_type = 'none'
let g:dein#install_log_filename = g:rc#cache_path . '/dein.log'

let s:dein_path = g:rc#cache_path . '/dein'

if !executable('git')
    throw 'Could not install dein.vim. Please install git first!!'
    finish
endif

" Download dein.vim
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_path
endif
 
execute 'set runtimepath^=' . s:dein_repo_path

if !dein#load_state(s:dein_path)
    finish
endif

let s:dein_toml_paths = glob(g:rc#runtime_path . '/dein/*.toml', 1, 1)

call dein#begin(s:dein_path,
    \ extend([expand('<sfile>')], s:dein_toml_paths))

for toml_path in s:dein_toml_paths
    if toml_path =~# 'lazy'
        call dein#load_toml(toml_path, { 'lazy': 1 })
    else
        call dein#load_toml(toml_path, { 'lazy': 0 })
    endif
endfor

call dein#end()
call dein#save_state()

if has('vim_starting')
    if dein#check_install()
        call dein#install()
    end
else
    call dein#call_hook('source')
    call dein#call_hook('post_source')
endif
