" ================ Multiple Cursors ========================

" Highlighting
hi! link multiple_cursors_cursor LightLineLeft_visual_0
hi! link multiple_cursors_visual LightLineLeft_visual_0

" Disable YouCompleteMe when using vim-multiple-cursors
function! Multiple_cursors_before()
  if exists('*youcompleteme#EnableCursorMovedAutocommands')
    " call youcompleteme#DisableCursorMovedAutocommands()
    let s:old_ycm_whitelist = g:ycm_filetype_whitelist
    let g:ycm_filetype_whitelist = {}
  endif
endfunction

function! Multiple_cursors_after()
  if exists('*youcompleteme#EnableCursorMovedAutocommands')
    " call youcompleteme#EnableCursorMovedAutocommands()
    let g:ycm_filetype_whitelist = s:old_ycm_whitelist
  endif
endfunction
