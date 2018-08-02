function! s:detecth2o() abort
  if getline(1) =~# '^#!.*/bin/env\s\+h2o\>'
    setf yaml
  endif
endfunction

autocmd BufRead,BufNewFile *.conf call s:detecth2o()
