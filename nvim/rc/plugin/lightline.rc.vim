let g:lightline = {
    \ 'colorscheme': 'material',
    \ 'active': {
    \   'left':  [['mode', 'paste'],
    \             ['readonly', 'relativepath', 'modified'],
    \             ['progress']],
    \   'right': [['lineinfo'],
    \             ['percent'],
    \             ['gitstatus', 'fileformat', 'fileencoding', 'filetype']],
    \ },
    \ 'inactive': {
    \   'left':  [['readonly', 'relativepath', 'modified']],
    \   'right': [['lineinfo'],
    \             ['percent'],
    \             ['gitstatus', 'fileformat', 'fileencoding', 'filetype']],
    \ },
    \ 'component': {
    \   'filetype': '%{WebDevIconsGetFileTypeSymbol()} %{&ft !=# "" ? &ft : "no ft"}',
    \   'progress': '%{dein#get_progress()}',
    \ },
    \ 'component_function': {
    \   'gitstatus': 'LightlineGitStatus',
    \ },
    \ 'tab': {
    \   'active':   ['num', 'icon', 'filename', 'modified', 'readonly'],
    \   'inactive': ['num', 'icon', 'filename', 'modified', 'readonly'],
    \ },
    \ 'tab_component_function': {
    \   'num':      'lightline#tab#tabnum',
    \   'icon':     'LightlineTabIcon',
    \   'filename': 'LightlineFileName',
    \   'modified': 'lightline#tab#modified',
    \   'readonly': 'lightline#tab#readonly',
    \ },
    \}

function! LightlineTabIcon(n) abort
  let buflist  = tabpagebuflist(a:n)
  let winnr    = tabpagewinnr(a:n)
  let filename = expand('#' . buflist[winnr - 1] . ':f')
  return WebDevIconsGetFileTypeSymbol(filename)
endfunction

function! LightlineFileName(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr   = tabpagewinnr(a:n)
  let _       = pathshorten(expand('#' . buflist[winnr - 1] . ':f'))
  return _ !=# '' ? _ : '[No Name]'
endfunction

function! LightlineGitStatus() abort
  let [added,modified,deleted] = GitGutterGetHunkSummary()
  return printf('git:+%d ~%d -%d', added, modified, deleted)
endfunction
