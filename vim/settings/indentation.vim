" ================ Indentation ========================

" Default settings
set expandtab
set shiftwidth=2
set tabstop=2

" File type specific configuration
augroup fileSettings
  autocmd!
  autocmd Filetype php setlocal ts=4 sw=4 expandtab 
  autocmd Filetype html setlocal ts=4 sw=4 expandtab
  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
augroup END
