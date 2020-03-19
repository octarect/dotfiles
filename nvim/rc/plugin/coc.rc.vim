"-----------------------------------------------------------
" Coc.nvim
"-----------------------------------------------------------

let g:coc_status_error_sign = 'x'
let g:coc_status_warning_sign = '!'
let g:coc_global_extensions = [
    \ 'coc-marketplace',
    \ 'coc-snippets',
    \ 'coc-word',
    \ 'coc-git',
    \ 'coc-tabnine',
    \ 'coc-vimlsp',
    \ 'coc-go',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ ]

" Use <TAB> for trigger completion with characters ahead and navigate.
" Instead of "/<C-n>" coc#_select_confirm is also OK if you want to select
" first item immediately.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<CR>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

augroup MyCocAutoCmd
  autocmd!
  autocmd FileType go call <SID>coc_go_settings()
augroup END

function! s:coc_go_settings() abort
  nmap ms :<C-u>CocCommand go.test.toggle<CR>
endfunction
