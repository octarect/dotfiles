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
    \ 'coc-clangd',
    \ 'coc-go',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-elixir',
    \ 'coc-docker',
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
nmap <silent> [c <Plug>(coc-git-prevchunk)
nmap <silent> ]c <Plug>(coc-git-nextchunk)
" Show chunk diff at current position
nmap <silent> <Leader>ggd <Plug>(coc-git-chunkinfo)
" Show commit contains current position
nmap <silent> <Leader>ggc <Plug>(coc-git-commit)

" coc-go
augroup MyCocAutoCmd
  autocmd!
  autocmd BufWritePre *.go silent call CocAction('organizeImport')
  autocmd BufWritePre *.go silent call CocAction('format')
  autocmd FileType go call <SID>coc_go_settings()
augroup END

function! s:coc_go_settings() abort
  nmap mt :<C-u>CocCommand go.test.toggle<CR>
  nmap mT :<C-u>CocCommand go.test.generate.file<CR>
endfunction

"-----------------------------------------------------------
" From https://github.com/neoclide/coc.nvim
"-----------------------------------------------------------

" Navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gt <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)

" Show documentation in preview window.
nnoremap <silent> <Leader>gs :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Apply AutoFix to problem on the current line.
nmap <Leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
