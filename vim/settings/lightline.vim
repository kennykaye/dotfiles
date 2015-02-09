" ================ Lightline ========================
" Configurations for lightline and related components

" Lightline configuration
let g:lightline = {
      \ 'colorscheme': 'base16_eighties',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], 
      \           [ 'filename' ],
      \           [ 'fugitive' ] ], 
      \   'right': [ [ 'syntasticError', 'syntasticWarning', 'lineinfo' ], 
      \            ['percent'], 
      \            [ 'fileformat', 'fileencoding', 'filetype', 'filesize' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'MyMode',
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
		  \   'modified': 'MyModified',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'filesize': 'MyFilesize',
      \   'fileencoding': 'MyFileencoding',      
      \   'lineinfo': 'MyLineInfo',
		  \   'percent': 'MyPercent',
      \   'ctrlpmark': 'CtrlPMark',
      \ },  
      \ 'component_expand': {
      \   'syntasticError': 'SyntasticErrorCount',
      \   'syntasticWarning': 'SyntasticWarningCount',
      \ },
      \ 'component_type': {
      \   'syntasticError': 'error',
      \   'syntasticWarning': 'warning',
      \ },     
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
			\ 'tabline_separator': { 'left': " ", 'right': "" },
			\ 'tabline_subseparator': { 'left': " ", 'right': "" }
      \ }

" Change highlighting on tabline to add more space around tabs
augroup TabHighlightGroup
  :autocmd!
  :autocmd VimEnter * hi! link LightLineLeft_tabline_tabsel_0 LightLineLeft_normal_tabsel_tabsel 
  :autocmd VimEnter * hi! link LightlineLeft_tabline_tabsel_1 LightLineLeft_normal_tabsel_tabsel 
augroup END

" Displays modified flag
function! MyModified()
  if &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

" Displays line and column 
function! MyLineInfo()
  if expand('%:t') !~? 'ControlP\|NERD\|fugitive\|Tagbar'
    return ' '. line(".") .":". col(".")
  endif
    return ''
endfunction

" Displays filesize
function! MyFilesize()
  let kb = 1024
  let mb = 1048576
  let gb = 1073741824
  let bytes = getfsize(expand('%%:p'))
  let fsize = bytes >= gb ? bytes / gb . " gb" :
        \     bytes >= mb ? bytes / mb . " mb" :
        \     bytes >= kb ? bytes / kb . " kb" :
        \     bytes . ' bytes'
  return winwidth(0) > 100 ? fsize : ''
 
endfunction

" Displays file format
function! MyFileformat()
  if expand('%:t') !~? 'ControlP\|NERD\|fugitive\|Tagbar'
    return winwidth(0) > 100 ? &fileformat : ''
  endif
  return ''
endfunction

" Displays file type
function! MyFiletype()
  if expand('%:t') !~? 'ControlP\|NERD\|fugitive\|Tagbar'
    return winwidth(0) > 100 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endif
  return ''
endfunction

" Displays file encoding
function! MyFileencoding()
  if expand('%:t') !~? 'ControlP\|NERD\|fugitive\|Tagbar'
    return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endif
  return ''
endfunction

" Displays current position in percent  
function! MyPercent()
  if expand('%:t') !~? 'ControlP\|NERD\|fugitive\|Tagbar'
    let byte = line2byte( line( "." ) ) + col( "." ) - 1
    let size = (line2byte( line( "$" ) + 1 ) - 1)
    let percent = (byte * 100) / size
    " return byte . " " . size . " " . (byte * 100) / size
    return winwidth(0) > 100 ?  percent . '%' : ''
  endif
  return ''
endfunction


" Displays read-only flag
function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

" Displays file name
function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname =~ 'NERD' ? '' :
        \ fname =~ 'Tagbar' ? 'Tagbar' :
        \ fname =~ 'fugitive' ? matchstr(fname, '\(fugitive\)\@<=[A-Za-z]*') :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" Displays current git branch
function! MyFugitive()
  if expand('%:t') !~? 'Tagbar\|ControlP\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

" Displays current vim mode
function! MyMode()
  let fname = expand('%:t')
  return  fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ strpart(lightline#mode(), 0, 1)
endfunction

" Displays title for CtrlP
function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

" Gets number of syntastic errors
function! SyntasticErrorCount()
  let flag = SyntasticStatuslineFlag()
  return matchstr(flag, '\(E\)\@<=\d*')
endfunction

" Gets number of syntastic warnings
function! SyntasticWarningCount()
  let flag = SyntasticStatuslineFlag()
  return matchstr(flag, '\(W\)\@<=\d*')
endfunction
