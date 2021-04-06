" - - - - - - - - - - - - - - - - - - - -
" collapse
" The plugin provides smart folding function.
" - - - - - - - - - - - - - - - - - - - -
if exists('g:loaded_collapse')
  finish
endif
let g:loaded_collapse = 1

if has('folding')
  set foldtext=collapse#foldtext()
endif

function collapse#uncomment(str)
  if !exists('b:collapse_regexp')
    let l:comments = map(split(&commentstring, '%s'), 'trim(v:val)')
    let l:escaped = []
    for l:com in l:comments
      call add(l:escaped, escape(l:com, '^$.*?/\[]'))
    endfor
    let b:collapse_regexp = printf('^\s*\(%s\)\+\s*', join(l:escaped, '\|'))
  endif
  return substitute(a:str, b:collapse_regexp, '', 'g')
endfunction

function! collapse#foldtext()
  let l:first = v:foldstart
  while getline(l:first) =~ '^\s*$' | let l:first = nextnonblank(l:first + 1)
  endwhile
  if l:first > v:foldend
    let l:firstline = getline(v:foldstart)
  else
    let l:firstline = substitute(getline(l:first), '\t', repeat(' ', &tabstop), 'g')
  endif

  let l:last = v:foldend
  while getline(l:last) =~ '^\s*$' | let l:last = prevnonblank(l:last - 1)
  endwhile
  if l:last < v:foldstart
    let l:lastline = getline(v:foldend)
  else
    let l:lastline = substitute(getline(l:last), '\t', repeat(' ', &tabstop), 'g')
  end

  let l:firstline = collapse#uncomment(l:firstline)
  let l:lastline  = collapse#uncomment(l:lastline)

  let l:lead     = '+-- '
  let l:dots     = ' ... '
  let l:w        = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
  let l:foldlines = v:foldend - v:foldstart + 1
  let l:filelines = line('$')
  let l:foldratio = (l:foldlines * 1.0) / l:filelines * 100
  let l:foldinfo = printf('[%.f%% %d/%d]', l:foldratio, l:foldlines, l:filelines)
  let l:spacer   = repeat('･', l:w - strwidth(l:lead . l:firstline . l:dots . l:lastline . l:foldinfo))

  return l:lead . l:firstline . l:dots . l:lastline . l:spacer . l:foldinfo
endfunction
