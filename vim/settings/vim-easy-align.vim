" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> :EasyAlign <CR>

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga :EasyAlign <CR>

if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
let g:easy_align_delimiters['"'] = { 'pattern': '"', 'ignore_groups': ['String'] }
