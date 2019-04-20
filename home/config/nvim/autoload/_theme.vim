function! _theme#init(csname) abort
  execute 'colorscheme ' . a:csname


  " True Color
  if $COLORTERM == 'truecolor' || $COLORTERM == '24bit'
    " For Neovim 0.1.5 or later
    if has('nvim')
      set termguicolors

    " For Vim 7.4.1799 or later
    elseif has('termguicolors')
      set termguicolors
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
  endif

endfunction
