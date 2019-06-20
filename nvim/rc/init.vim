if &compatible
  set nocompatible
endif

let g:cache_dir = expand('~/.cache/dotfiles')
if !isdirectory(g:cache_dir)
  call mkdir(g:cache_dir, 'p')
endif

let g:conf_dir = expand('<sfile>:p:h:h')

execute 'set runtimepath^=' . fnameescape(g:conf_dir)

call util#source_rc('mappings.rc.vim')

call util#source_rc('options.rc.vim')

call util#source_rc('dein.rc.vim')

" For security. The below code must be put at last.
set exrc secure
