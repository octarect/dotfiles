"-----------------------------------------------------------
" Keymappings
"-----------------------------------------------------------

" Tab
let s:maximum_tab_number = 9
for i in range(1, s:maximum_tab_number)
  execute 'nnoremap <silent> t' . i . ' :<C-u>tabnext' . i . '<CR>'
endfor
nnoremap <silent> tc :tabnew<CR>
nnoremap <silent> tq :tabclose<CR>
nnoremap <silent> [t :tabprev<CR>
nnoremap <silent> ]t :tabnext<CR>

" Buffer switching
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>

execute 'nnoremap <Leader>rc :source $MYVIMRC<CR>'

" Color Debugging
nnoremap <F10> :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" Remap default keys
nnoremap M m

" Toggle relativenumber
nnoremap <Leader>or :set relativenumber!<CR>

" I HATE pair-programming or stuff like that.
" Silent mode makes my great vim environment readable
" by co-workers. (especially non-vim users)
if !exists("g:silent_mode")
  let g:silent_mode = 0
endif
function! s:toggle_silent_mode() abort
  if g:silent_mode == 0
    " Turn on silent mode
    let g:silent_mode = 1
    set listchars=tab:\ \ ,nbsp:+,trail:·,extends:→,precedes:←
    set norelativenumber
  else
    " Turn off silent mode
    let g:silent_mode = 0
    set listchars=tab:>·,nbsp:+,trail:·,extends:→,precedes:←
    set relativenumber
  endif
endfunction
nnoremap <Leader>os :call <SID>toggle_silent_mode()<CR>

" Terminal mode
" if exists(':tnoremap')
"   " Open terminal
"   nnoremap <Leader>t :terminal<CR>
"   " Normal mode (I cannot do VIM in VIM anymore)
"   tnoremap <C-j><C-j> <C-\><C-n>
" endif
