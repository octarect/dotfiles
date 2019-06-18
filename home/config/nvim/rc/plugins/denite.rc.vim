autocmd FileType denite call s:configure_denite()

function! s:configure_denite() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

call denite#custom#var('file/rec', 'command',
\ [ 'rg', '--files', '--follow', '--hidden', '--glob', '!.git' ])
call denite#custom#var('grep', 'command', ['rg'])

let s:menus = {}

let s:menus.dein = { 'description': 'Plugin management' }
let s:menus.dein.command_candidates = [
  \   ['Dein: Update', 'call dein#update'],
  \   ['Dein: List', 'Denite dein'],
  \   ['Dein: Update log', 'echo dein#get_updates_log()'],
  \   ['Dein: Log', 'echo dein#get_log()'],
  \ ]

call denite#custom#var('menu', 'menus', s:menus)
