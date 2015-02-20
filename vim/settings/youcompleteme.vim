" ================ You Complete Me ========================

" Defer YouCompleteMe load until insert mode is entered
augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('YouCompleteMe')
                     \| call youcompleteme#Enable() | autocmd! load_us_ycm
augroup END

" Highlighting
hi! link Pmenu CursorLineNr
hi! link PmenuSel Visual

" Configuration
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

augroup set_omnifunc
  autocmd!
  autocmd FileType javascript setlocal omnifunc=tern#Complete
augroup END
