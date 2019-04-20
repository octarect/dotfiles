function! _lightline#init() abort
  let g:lightline = {
        \ 'colorscheme': 'deus',
        \ 'active': {
        \   'left':   [ [ 'mode', 'paste' ],
        \               [ 'readonly', 'filename', 'modified' ] ],
        \   'right':  [ [ 'lineinfo' ],
        \               [ 'percent' ],
        \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'inactive': {
        \   'left':   [ [ 'readonly', 'filename', 'modified' ] ],
        \   'right':  [ [ 'lineinfo' ],
        \               [ 'percent' ],
        \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ }
endfunction
