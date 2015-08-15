" Set Missing Filetypes
au BufRead,BufNewFile gitconfig set filetype=gitconfig
au BufRead,BufNewFile *.conf set filetype=conf
au BufRead,BufNewFile *.cfg set filetype=sh
au BufRead,BufNewFile *.webapp set filetype=json
au BufRead,BufNewFile pryrc set filetype=ruby
au BufRead,BufNewFile scratch-pad set filetype=ruby

" File type specific indentation
augroup indentationSettings
  autocmd!
  autocmd BufRead * :IndentLinesEnable
  autocmd Filetype php setlocal ts=4 sw=4 expandtab
  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
  autocmd Filetype json setlocal ts=4 sw=4 expandtab
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

" Highlight text past 80 characters
augroup vimrc_autocmds
  autocmd!
  autocmd BufEnter * match OverLength /\%80v.*/
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
