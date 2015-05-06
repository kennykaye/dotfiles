" Set Missing Filetypes
au BufRead,BufNewFile gitconfig set filetype=gitconfig
au BufRead,BufNewFile *.conf set filetype=conf
au BufRead,BufNewFile *.cfg set filetype=sh
au BufRead,BufNewFile pryrc set filetype=ruby
au BufRead,BufNewFile scratch-pad set filetype=ruby

" File type specific indentation
augroup indentationSettings
  autocmd!
  autocmd BufRead * :IndentLinesEnable
  autocmd Filetype php setlocal ts=4 sw=4 expandtab
  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
  autocmd Filetype html,html.handlebars setlocal ts=4 sw=4 expandtab
augroup END

" File type specific settings
augroup fileSettings
  autocmd!
  autocmd Filetype vim-plug setlocal nonumber
augroup END

" Only highlight current cursor on active buffers
augroup BgHighlight
    autocmd!
    autocmd WinEnter * :setlocal cursorline
    autocmd WinLeave * :setlocal nocursorline
augroup END


" =======================================
" Relative Line Numbers
" =======================================

function! NumberBlackList()
  let s:bufferBlackList = 'nofile'
  let s:relativeNumberBlackList = 'ControlP\|NERD\|fugitive\|Tagbar\|agsv'
  if &ft =~ s:relativeNumberBlackList || &buftype =~ s:bufferBlackList
    return 1
  else
    return 0
  endif
endfunction

function! EnableRelativeNumber()
  if NumberBlackList()
    return
  endif
  :setlocal relativenumber
endfunction

function! DisableRelativeNumber()
  if NumberBlackList()
    return
  endif
  :setlocal number norelativenumber
endfunction

augroup LineNumbers
autocmd!
  autocmd BufEnter *    call EnableRelativeNumber()
  autocmd BufLeave *    call DisableRelativeNumber()
  autocmd WinEnter *    call EnableRelativeNumber()
  autocmd WinLeave *    call DisableRelativeNumber()
  autocmd InsertEnter * call DisableRelativeNumber()
  autocmd InsertLeave * call EnableRelativeNumber()
  autocmd FocusLost *   call DisableRelativeNumber()
  autocmd FocusGained * call EnableRelativeNumber()
augroup END

" trim all whitespace on save
autocmd BufWritePre * call TrimWhitespace()
function! TrimWhitespace()
  let line = line('.')
  let col = col('.')
  execute('%s/\s\+$//e')
  call cursor(line, col)
endfunction

" automatically redraw screen after save
autocmd BufWritePost * :redraw!
