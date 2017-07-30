" My filetype file.

if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  autocmd BufRead,BufNewFile *.zsh-theme setf zsh
augroup END
