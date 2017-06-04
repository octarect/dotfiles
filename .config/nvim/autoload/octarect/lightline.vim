function! octarect#lightline#init() abort
  let g:gitgutter_sign_added = emoji#for('bomb')
  let g:gitgutter_sign_modified = emoji#for('gun')
  let g:gitgutter_sign_removed = emoji#for('boom')
  "let g:gitgutter_sign_added = '+'
  "let g:gitgutter_sign_modified = '*'
  "let g:gitgutter_sign_removed = '-'
  let g:lightline = {
    \ 'colorscheme': 'molokai',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['fugitive', 'gitgutter', 'filename', 'readonly', 'modified']],
    \   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']],
    \ },
    \ 'component': {
    \ },
    \ 'component_function': {
    \   'filename': 'octarect#lightline#filename',
    \   'filetype': 'octarect#lightline#_filetype',
    \   'fileformat': 'octarect#lightline#fileformat',
    \   'fugitive': 'octarect#lightline#fugitive',
    \   'gitgutter': 'octarect#lightline#gitgutter',
    \ },
    \ }
  let g:unite_force_overwrite_statusline = 0
  let g:vimfiler_force_overwrite_statusline = 0
  let g:vimshell_force_overwrite_statusline = 0
endfunction

function! octarect#lightline#filename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
    \ &filetype ==# 'unite' ? unite#get_status_string() :
    \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
    \ expand('%:t') !=# '' ? expand('%:p') : '[No Name]'
endfunction

function! octarect#lightline#_filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! octarect#lightline#fileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! octarect#lightline#fugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? '⭠ '._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! octarect#lightline#gitgutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction
