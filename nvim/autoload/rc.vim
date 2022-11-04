let g:rc#cache_path =
    \ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache') . '/nvim')

let g:rc#runtime_path = get(g:, 'rc#runtime_path', expand('<sfile>:p:h:h'))

let s:kv_cache_path = g:rc#cache_path . '/kv'

function! rc#source_rc(name) abort
  let l:path = g:rc#runtime_path . '/rc/' . a:name
  execute 'source' fnameescape(l:path)
endfunction

function! rc#ensure_path(path, ...) abort
  let l:type = get(a:, 1, 'directory') " or 'file'
  if l:type == 'file'
    let l:dir = fnamemodify(a:path, ':p:h')
    if ! isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
    if glob(a:path) ==# ''
      call writefile([], a:path)
    endif
  elseif l:type == 'directory'
    if ! isdirectory(a:path)
      call mkdir(a:path, 'p')
    endif
  end
endfunction

function! rc#kv_write(name, value) abort
  let l:cache_file = rc#get_kv_cache_path(a:name)
  call rc#ensure_path(l:cache_file, 'file')
  call writefile([a:value], l:cache_file)
endfunction

function! rc#kv_read(name, ...) abort
  let l:default = get(a:, 1, '')
  let l:cache_file = rc#get_kv_cache_path(a:name)
  return glob(l:cache_file) !=# '' ? get(readfile(l:cache_file), 0, l:default) : l:default
endfunction

function! rc#kv_clear(name) abort
  let l:cache_file = rc#get_kv_cache_path(a:name)
  let l:result = delete(l:cache_file)
  if l:result == -1
    throw 'rc#kv: Failed to delete' . l:cache_file
  endif
endfunction

function! rc#get_kv_cache_path(name) abort
  return g:rc#cache_path . '/kv/' . a:name
endfunction

function! rc#init() abort
  call rc#ensure_path(g:rc#cache_path)
endfunction

let s:regex_hi_linked_group = '.\+ links to \(\S\+\)'
function! rc#get_highlight(group, key)
  try
    let l:output = execute('hi ' . a:group)
  catch
    return ''
  endtry
  if match(l:output, s:regex_hi_linked_group) == 0
    let l:linked_group = substitute(l:output, s:regex_hi_linked_group, '\1', 'g')
    return rc#get_highlight(l:linked_group, a:key)
  endif
  return matchstr(l:output, a:key . '=\zs\S*')
endfunction

let s:local_config_path = expand('$HOME/.local/share/nvim/local')
function! rc#local_config_path(name)
  return s:local_config_path . '/' . a:name
endfunction
