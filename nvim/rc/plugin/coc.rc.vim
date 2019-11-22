"-----------------------------------------------------------
" Coc.nvim
"-----------------------------------------------------------

let g:coc_status_error_sign = 'x'
let g:coc_status_warning_sign = '!'
let g:coc_global_extensions = [
    \ 'coc-marketplace',
    \ 'coc-vimlsp',
    \ 'coc-git',
    \ ]

" Use <TAB> for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction
