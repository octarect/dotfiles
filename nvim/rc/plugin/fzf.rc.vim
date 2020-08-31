let g:fzf_layout = { 'window': { 'width': 0.75, 'height': 0.5 } }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

let g:fzf_emoji_separator = ' '
function! s:fzf_emoji()
  function! s:emoji_source()
    let l:source = []
    for k in emoji#list()
      call add(
      \ l:source,
      \ printf('%s%s%s', trim(emoji#for(k)), g:fzf_emoji_separator, k)
      \ )
    endfor
    return l:source
  endfunction

  function! s:insert_emoji(item)
    let l:sep_pos = stridx(a:item, g:fzf_emoji_separator)
    let l:key_pos = l:sep_pos + len(g:fzf_emoji_separator)
    let l:key = a:item[key_pos:-1]
    " execute 'silent normal i' . key
    execute 'silent normal a' . emoji#for(key)
  endfunction

  call fzf#run(fzf#wrap({
  \ 'source': <sid>emoji_source(),
  \ 'sink': function('s:insert_emoji'),
  \ }))
endfunction

command! -bang FzfEmoji call <sid>fzf_emoji()
