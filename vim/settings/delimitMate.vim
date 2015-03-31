augroup load_delimitMate
  autocmd!
  autocmd InsertEnter * call plug#load('delimitMate')
                     \| silent DelimitMateOn | autocmd! load_delimitMate
augroup END

let delimitMate_expand_cr = 2
