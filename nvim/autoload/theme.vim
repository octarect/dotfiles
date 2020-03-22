function! theme#init() abort
  if ! exists('g:colors_name')
    let l:colorscheme = rc#kv_read('colorscheme', 'desert')
    set background=dark
    execute 'colorscheme' l:colorscheme
  endif
endfunction

function! theme#cache() abort
  if ! has('vim_starting') && exists('g:colors_name')
    call rc#kv_write('colorscheme', g:colors_name)
  endif
endfunction

augroup ThemeAutoCmd
  autocmd!
  autocmd ColorSchemePre * hi clear
  autocmd ColorScheme * call rc#source_rc('color.rc.vim')
  autocmd ColorScheme * call theme#cache()
augroup END
