call denite#custom#option('default', {
    \ 'source_names': 'short',
    \ 'split': 'floating',
    \ 'matchers': 'matcher/fuzzy',
    \ 'prompt': '>',
    \ 'start_filter': v:true,
    \ 'statusline': v:false,
    \ })

if executable('rg')
    call denite#custom#var('_', 'command', ['rg', ''])
    call denite#custom#var('file/rec', 'command',
        \ ['rg', '--files', '--follow', '--hidden', '--glob', '!.git'])
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep', '--no-heading'])
endif

let s:menus = {}
call denite#custom#var('menu', 'menus', s:menus)

call denite#custom#source(
    \ 'file/rec,file_mru,file/old,buffer,directory/rec,directory_mru',
    \ 'converters',
    \ ['devicons_denite_converter'])

augroup rc-plugin-denite
    autocmd!
    autocmd FileType denite call s:configure()
    autocmd FileType denite-filter set nocursorline
augroup END

function! s:configure() abort
    hi! link CursorLine Visual
    nnoremap <silent><buffer><expr> <CR>    denite#do_map('do_action')
    nnoremap <silent><buffer><expr> t       denite#do_map('do_action', 'tabopen')
    nnoremap <silent><buffer><expr> v       denite#do_map('do_action', 'vsplit')
    nnoremap <silent><buffer><expr> s       denite#do_map('do_action', 'split')
    nnoremap <silent><buffer><expr> d       denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p       denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q       denite#do_map('quit')
    nnoremap <silent><buffer><expr> i       denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction
