function! util#source_rc(path) abort
  let abspath = g:conf_dir . '/rc/' . a:path
  execute 'source' fnameescape(abspath)
  return
endfunction
