" ================ Keyboard Layouts ========================
" Methods to toggle between QWERTY and Workman
" keyboard layouts

function! Keyboard(type)
  if a:type == "workman"
    "(O)pen line -> (L)ine
    noremap l o
    noremap o l
    noremap L O
    noremap O L
    "Search (N)ext -> (J)ump
    noremap j n
    noremap n j
    noremap J N
    noremap N J
    "(E)nd of word -> brea(K) of word
    noremap k e
    noremap e k
    noremap K E
    noremap E <nop>
    noremap h y
    "(Y)ank -> (H)aul
    noremap y h
    noremap H Y
    noremap Y H

    " Provide easier split navigation
    nnoremap <silent> <S-Down> <C-W><C-J>
    nnoremap <silent> <S-Up> <C-W><C-K>
    nnoremap <silent> <S-Right> <C-W><C-L>
    nnoremap <silent> <S-Left> <C-W><C-H>

    let g:NERDTreeMapOpenExpl = "t"

  else " qwerty
    call UnmapWorkman()
  endif
endfunction

function! UnmapWorkman()
  "Unmaps Workman keys
  silent! unmap h
  silent! unmap j
  silent! unmap k
  silent! unmap l
  silent! unmap y
  silent! unmap n
  silent! unmap e
  silent! unmap o
  silent! unmap H
  silent! unmap J
  silent! unmap K
  silent! unmap L
  silent! unmap Y
  silent! unmap N
  silent! unmap E
  silent! unmap O

  " Better split navigation
  nnoremap <silent> <C-J> <C-W><C-J>
  nnoremap <silent> <C-K> <C-W><C-K>
  nnoremap <silent> <C-L> <C-W><C-L>
  nnoremap <silent> <BS> <C-W><C-H> " Fixes a bug where H was being interpreted as backspace

  nnoremap <silent> <S-L> 20l
  nnoremap <silent> <S-H> 20h

  let g:NERDTreeMapOpenExpl = "e"
endfunction

function! LoadKeyboard()
  let keys = $KEYBOARD_LAYOUT
  if (keys == "enthium")
    call Keyboard("enthium")
  else
    call Keyboard("qwerty")
  endif
endfunction

augroup keyboardGroup
  autocmd!
  autocmd VimEnter * call LoadKeyboard()
augroup END

:command! Qwerty call Keyboard("qwerty")
:command! Workman call Keyboard("workman")
