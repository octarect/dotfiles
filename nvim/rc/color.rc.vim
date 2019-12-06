"-----------------------------------------------------------
" Color fix
" NOTE: This script will be loaded after loading colorscheme
"-----------------------------------------------------------

function! s:get_highlight(group, key)
  let l:output = execute('hi ' . a:group)
  return matchstr(output, a:key . '=\zs\S*')
endfunction

hi LineNr ctermbg=NONE ctermfg=252 guibg=NONE guifg=252
hi Whitespace ctermfg=96 ctermbg=NONE
hi VertSplit ctermfg=Black guifg=Black guibg=NONE ctermbg=NONE
hi SignColumn ctermfg=187 ctermbg=NONE guifg=#ebdbb2 guibg=NONE guisp=NONE cterm=NONE gui=NONE

if s:get_highlight('Pmenu', 'guibg') ==# 'Magenta'
  hi Pmenu ctermfg=103 ctermbg=236 guifg=#9a9aba guibg=#34323e guisp=NONE cterm=NONE gui=NONE
  hi link NormalFloat Pmenu
endif

if has('nvim') || has('patch-7.4.237')
  hi EndOfBuffer gui=NONE guifg=#2c2c2c
endif

" Highlight groups for gitgutter
hi GitGutterAdd          ctermfg=2 guifg=#00e676 ctermbg=NONE guibg=NONE
hi GitGutterChange       ctermfg=3 guifg=#ffc400 ctermbg=NONE guibg=NONE
hi GitGutterChangeDelete ctermfg=3 guifg=#ffc400 ctermbg=NONE guibg=NONE
hi GitGutterDelete       ctermfg=1 guifg=#ff3d00 ctermbg=NONE guibg=NONE
