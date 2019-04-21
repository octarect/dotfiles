if &compatible
  set nocompatible
endif

let g:cache_dir = expand('~/.cache/dotfiles')
if !isdirectory(g:cache_dir)
  call mkdir(g:cache_dir, 'p')
endif

let g:conf_dir = expand('<sfile>:p:h:h')
function! s:source_rc(path) abort
  let abspath = g:conf_dir . '/rc/' . a:path
  execute 'source' fnameescape(abspath)
  return
endfunction

execute 'set runtimepath^=' . fnameescape(g:conf_dir)

call s:source_rc('mappings.rc.vim')

call s:source_rc('dein.rc.vim')

call s:source_rc('options.rc.vim')

filetype plugin on

" For security. The below code must be put at last.
set exrc secure
