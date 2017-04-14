" ================ Lightline ========================
" Configurations for lightline and related components

" Lightline configuration
" \            [ 'fileencoding', 'filetype', 'filesize' ] ]

" Used for Goyo and Ale
let g:lightline_enabled = 1
let g:lightline = {
      \ 'colorscheme': g:lightlineTheme,
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \           [ 'filename' ],
      \           [ 'fugitive' ] ],
      \   'right': [ [ 'error', 'warning', 'lineinfo' ],
      \            ['percent'],
      \            [ 'filetype' ] ]
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
      \   'error': 'ErrorCount',
      \   'warning': 'WarningCount',
      \ },
      \ 'component_type': {
      \   'error': 'error',
      \   'warning': 'warning',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'tabline': {
      \     'left': [ [ 'tabs' ] ],
      \     'right': [ [ '' ] ]
      \   },
			\ 'tabline_separator': { 'left': " ", 'right': "" },
			\ 'tabline_subseparator': { 'left': " ", 'right': "" }
      \ }
      " \ 'separator': { 'left': '', 'right': '' },
      " \ 'subseparator': { 'left': '|', 'right': '|' },

      " \ 'separator': { 'left': '', 'right': '' },
      " \ 'subseparator': { 'left': '', 'right': '' },

      " \ 'separator': { 'left': '', 'right': '' },
      " \ 'subseparator': { 'left': '', 'right': '' },


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
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|Gundo' && &filetype !~? 'fzf'
    " return ' '. line(".") .":". col(".")
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
  if &filetype =~? 'html\|css\|html.handlebars'
    return winwidth(0) > 100 ? fsize : ''
  endif
  return ''
endfunction


" Displays file format
function! MyFileformat()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags' && &filetype !~? 'fzf'
    return winwidth(0) > 100 ? &fileformat : ''
  endif
  return ''
endfunction


" Displays file type
function! MyFiletype()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags\|Gundo' && &filetype !~? 'fzf'
    return winwidth(0) > 100 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endif
  return ''
endfunction


" Displays file encoding
function! MyFileencoding()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|ags' && &filetype !~? 'fzf'
    return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endif
  return ''
endfunction


" Displays current position in percent
function! MyPercent()
  if expand('%:t') !~? 'NERD\|fugitive\|Tagbar\|Gundo' && &filetype !~? 'fzf'
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
        \ fname =~ 'lldb' ? matchstr(fname, '\(\[lldb\]\)\@<=[A-Za-z]*') :
        \ fname =~ 'fugitive' ? matchstr(fname, '\(fugitive\)\@<=[A-Za-z]*') :
        \ &ft =~ 'fzf' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction


" Displays current git branch
function! MyFugitive()
  if expand('%:t') !~? 'Gundo\|Tagbar\|NERD\|ags' && &ft !~? 'vimfiler' && exists('*fugitive#head')
    if winwidth(0) > 100
      let _ = fugitive#head()
      return strlen(_) ? ' '._ : ''
    else
      return ''
    endif
  endif
  return ''
endfunction


" Displays current vim mode
function! MyMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'Files' :
        \ fname =~ 'Gundo' ? 'Gundo' :
        \ fname =~ 'agsv' ? 'Search' :
        \ fname =~ 'agse' ? 'Replace' :
        \ &ft =~ 'fzf' ? '' :
        \ strpart(lightline#mode(), 0, 1)
endfunction

" Get the ale error/warning count
function! g:AleCount(index)
  let l:count = ale#statusline#Count(bufnr('%'))
  if type(l:count) ==# type(0)
    let l:count = 0
  else
    let l:count = l:count[a:index]
  endif
  return l:count
endfunction

" Gets number of errors
function! ErrorCount()
  let errors = ''

  if exists('g:loaded_ale')
    let l:count = g:AleCount(0)
    let errors = l:count ? l:count : ''
  endif

  if exists("*SyntasticStatuslineFlag")
    let flag = SyntasticStatuslineFlag()
    let errors = matchstr(flag, '\(E\)\@<=\d*')
  endif

  if exists("*youcompleteme#GetErrorCount")
    let ycmErrors = youcompleteme#GetErrorCount()
    let errors = ycmErrors ? errors + ycmErrors : errors
  endif

  return errors
endfunction


" Gets number of warnings
function! WarningCount()
  let warnings = ''

  if exists('g:loaded_ale')
    let l:count = g:AleCount(1)
    let warnings = l:count ? l:count : ''
  endif

  if exists("*SyntasticStatuslineFlag")
    let flag = SyntasticStatuslineFlag()
    let warnings = matchstr(flag, '\(W\)\@<=\d*')
  endif

  if exists("*youcompleteme#GetWarningCount")
    let ycmWarnings = youcompleteme#GetWarningCount()
    let warnings = ycmWarnings ? warnings + ycmWarnings : warnings
  endif

  return warnings
endfunction


