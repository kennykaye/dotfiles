" ================ goyo.vim (고요) ========================
" Distraction free writing

function! s:goyo_enter()
  let g:lightline_enabled = 0
  if exists('$TMUX')
    silent !tmux set status off
  endif
  set noshowcmd
  set scrolloff=999
  Relativity!
  set nonumber norelativenumber
  Limelight
endfunction

function! s:goyo_leave()
  let g:lightline_enabled = 1
  if exists('$TMUX')
    silent !tmux set status on
  endif
  set showcmd
  set scrolloff=5
  Relativity
  Limelight!
endfunction

autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
