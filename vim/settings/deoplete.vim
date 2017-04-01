" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smartcase.
let g:deoplete#enable_smart_case = 1

"Add extra filetypes
let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'javascript',
                \ ]

let g:deoplete#sources = {}
" let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:deoplete#sources['javascript.jsx'] = ['ternjs']
let g:deoplete#sources['css'] = []

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.css='\w\+'

let b:deoplete_ignore_sources = ['buffer']

" call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])


augroup DeopleteFileMappings
  autocmd!
  autocmd FileType css,scss,sass inoremap <expr><tab> <Nop>
  autocmd FileType * inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
augroup END
