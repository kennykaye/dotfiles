" ================ Multiple Cursors ========================

" Highlighting
hi! link multiple_cursors_cursor Visual
hi! link multiple_cursors_visual Visual

" Disable YouCompleteMe and syntastic when using vim-multiple-cursors
function! Multiple_cursors_before()
  if exists('g:ycm_filetype_whitelist')
    let s:old_ycm_whitelist = g:ycm_filetype_whitelist
    let g:ycm_filetype_whitelist = {}
  endif
  if exists(':SyntasticToggleMode')
    silent! call SyntasticToggleMode()
  endif
endfunction

function! Multiple_cursors_after()
  if exists('g:ycm_filetype_whitelist') && exists('s:old_ycm_whitelist')
    let g:ycm_filetype_whitelist = s:old_ycm_whitelist
  endif
  if exists(':SyntasticToggleMode')
    silent! call SyntasticToggleMode()
  endif
endfunction
