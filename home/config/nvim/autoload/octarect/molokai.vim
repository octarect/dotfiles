function! octarect#molokai#init() abort
  colorscheme molokai
  set t_Co=256
  hi Comment ctermfg=102
  hi String ctermfg=228
  hi Character ctermfg=228
  hi Delimiter ctermfg=228
  hi Visual ctermbg=240
  hi Operator ctermfg=9

  hi Normal ctermfg=255 ctermbg=none
  hi LineNr ctermfg=white ctermbg=none
  hi NonText ctermbg=none
endfunction
