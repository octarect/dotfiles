if &compatible
  set nocompatible
endif

if isdirectory($PYENV_ROOT.'/versions/nvim-python2')
  let g:python_host_prog=$PYENV_ROOT.'/versions/nvim-python2/bin/python'
endif
if isdirectory($PYENV_ROOT.'/versions/nvim-python3')
  let g:python3_host_prog=$PYENV_ROOT.'/versions/nvim-python3/bin/python'
endif

let g:cache_dir = expand('~/.cache/dotfiles')
if !isdirectory(g:cache_dir)
  call mkdir(g:cache_dir, 'p')
endif

let g:conf_dir = expand('<sfile>:p:h:h')

execute 'set runtimepath^=' . fnameescape(g:conf_dir)

call util#source_rc('dein.rc.vim')

call util#source_rc('mappings.rc.vim')

call util#source_rc('options.rc.vim')

" For security. The below code must be put at last.
set exrc secure
