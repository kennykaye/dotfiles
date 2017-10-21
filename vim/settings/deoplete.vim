" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'tern']
let g:deoplete#sources['css'] = []
let g:deoplete#max_abbr_width = 30

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
\ 'tern#Complete',
\ 'jspc#omni'
\ ]

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.css='\w\+'

let b:deoplete_ignore_sources = ['buffer']

"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
\ 'jsx',
\ 'javascript',
\ 'javascript.jsx',
\ ]

let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#include_keywords = 1

" Tab completion conflicts with hyperstyle, disable for now
augroup DeopleteFileMappings
  autocmd!
  autocmd FileType javascript inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
  autocmd FileType css,scss,sass inoremap <expr><tab> <Nop>
augroup END
