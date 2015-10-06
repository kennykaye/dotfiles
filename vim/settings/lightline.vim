" ================ Lightline ========================
" Configurations for lightline and related components

" Lightline configuration
let g:lightline = {
      \ 'colorscheme': 'base16_kaye',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \           [ 'filename' ],
      \           [ 'fugitive' ] ],
      \   'right': [ [ 'syntasticError', 'syntasticWarning', 'lineinfo' ],
      \            ['percent'],
      \            [ 'fileencoding', 'filetype', 'filesize' ] ]
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
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|Gundo'
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
        \     bytes > 1 ? bytes . ' bytes' : ''
  if &filetype =~? 'javascript\|html\|scss\|css\|html.handlebars'
    return winwidth(0) > 100 ? fsize : ''
  endif
  return ''
endfunction

" Displays file format
function! MyFileformat()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags'
    return winwidth(0) > 100 ? &fileformat : ''
  endif
  return ''
endfunction

" Displays file type
function! MyFiletype()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags\|Gundo'
    return winwidth(0) > 100 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endif
  return ''
endfunction

" Displays file encoding
function! MyFileencoding()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags'
    return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endif
  return ''
endfunction

" Displays current position in percent
function! MyPercent()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|Gundo'
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
  return fname =~ 'NERD' ? '' :
        \ fname =~ 'Gundo' ? '' :
        \ fname =~ 'ags' ? '' :
        \ fname =~ 'Tagbar' ? 'Tagbar' :
        \ fname =~ 'fugitive' ? matchstr(fname, '\(fugitive\)\@<=[A-Za-z]*') :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" Displays current git branch
function! MyFugitive()
  if expand('%:t') !~? 'Gundo\|Tagbar\|NERD\|ags' && &ft !~? 'vimfiler' && exists('*fugitive#head')
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

" Displays current vim mode
function! MyMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ fname =~ 'Gundo' ? 'Gundo' :
        \ fname =~ 'agsv' ? 'Search' :
        \ fname =~ 'agse' ? 'Replace' :
        \ strpart(lightline#mode(), 0, 1)
endfunction

" Gets number of syntastic errors
function! SyntasticErrorCount()
  if exists("*SyntasticStatuslineFlag")
    let flag = SyntasticStatuslineFlag()
    return matchstr(flag, '\(E\)\@<=\d*')
  endif
  return ''
endfunction

" Gets number of syntastic warnings
function! SyntasticWarningCount()
  if exists("*SyntasticStatuslineFlag")
    let flag = SyntasticStatuslineFlag()
    return matchstr(flag, '\(W\)\@<=\d*')
  endif
  return ''
endfunction
