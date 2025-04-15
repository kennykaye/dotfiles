" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> :EasyAlign <CR>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga :EasyAlign <CR>

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
let g:easy_align_delimiters['/'] = {
\                                     'pattern': '//\+\|/\*\|\*/',
\                                     'delimiter_align': 'l',
\                                     'ignore_groups': ['!Comment'] }

let g:easy_align_delimiters['"'] = { 'pattern': '"', 'ignore_groups': ['String'] }

augroup MarkdownTables
  au!
  au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
augroup END
