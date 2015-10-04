highlight link VenderPrefix Special
syntax match VendorPrefix /-\(moz\|webkit\|o\|ms\)-[a-zA-Z-]\+/

augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END
