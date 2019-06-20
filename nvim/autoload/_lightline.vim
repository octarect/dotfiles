function! _lightline#init() abort
  let g:lightline = {
        \ 'colorscheme': 'deus',
        \ 'active': {
        \   'left':   [ [ 'mode', 'paste' ],
        \               [ 'readonly', 'relativepath', 'modified' ],
        \               [ 'gitbranch', 'gitstat' ] ],
        \   'right':  [ [ 'lineinfo' ],
        \               [ 'percent' ],
        \               [ 'fileformat', 'fileencoding', 'filetype' ] ],
        \ },
        \ 'inactive': {
        \   'left':   [ [ 'readonly', 'filename', 'modified' ],
        \               [ 'gitbranch', 'gitstat' ] ],
        \   'right':  [ [ 'lineinfo' ],
        \               [ 'percent' ],
        \               [ 'fileformat', 'fileencoding', 'filetype' ] ],
        \ },
        \ 'component': {
        \   'filetype': '%{WebDevIconsGetFileTypeSymbol()}  %{&ft!=#""?&ft:"no ft"}',
        \ },
        \ 'component_function': {
        \   'gitstat': '_lightline#gitstat',
        \   'gitbranch': 'fugitive#head',
        \ },
        \ 'tab': {
        \   'active':   [ 'num', 'icon', 'filename', 'modified', 'readonly' ],
        \   'inactive': [ 'num', 'icon', 'filename', 'modified', 'readonly' ],
        \ },
        \ 'tab_component_function': {
        \   'num':      'lightline#tab#tabnum',
        \   'icon':     '_lightline#tab_icon',
        \   'filename': '_lightline#tab_filename',
        \   'modified': 'lightline#tab#modified',
        \   'readonly': 'lightline#tab#readonly',
        \ },
        \ }
endfunction

function! _lightline#tab_icon(n) abort
  let buflist  = tabpagebuflist(a:n)
  let winnr    = tabpagewinnr(a:n)
  let filename = expand('#' . buflist[winnr - 1] . ':f')
  return WebDevIconsGetFileTypeSymbol(filename)
endfunction

function! _lightline#tab_filename(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr   = tabpagewinnr(a:n)
  let _       = pathshorten(expand('#' . buflist[winnr - 1] . ':f'))
  return _ !=# '' ? _ : '[No Name]'
endfunction

function! _lightline#gitstat()
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
