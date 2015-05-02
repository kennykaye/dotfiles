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

    let g:ctrlp_prompt_mappings = {
    \ 'PrtHistory(-1)':       [],
    \ 'PrtCurEnd()':          [],
    \ 'CreateNewFile()':      [],
    \ 'OpenMulti()':          [],
    \ 'PrtCurRight()':        ['<c-o>'],
    \ 'PrtSelectMove("j")':   ['<c-n>'],
    \ 'PrtSelectMove("k")':   ['<c-e>'],
    \ 'PrtCurLeft()':         ['<c-y>'],
    \ }
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
  nnoremap <silent> <C-H> <C-W><C-H>

  let g:ctrlp_prompt_mappings = {
    \ 'OpenMulti()':          ['<c-o>'],
    \ 'CreateNewFile()':      ['<c-y>'],
    \ 'PrtCurStart()':        ['<c-a>'],
    \ 'PrtCurEnd()':          ['<c-e>'],
    \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
    \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
    \ 'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
    \ 'PrtCurRight()':        ['<c-l>', '<right>'],
    \ }
endfunction

function! LoadKeyboard()
  let keys = $keyboard
  if (keys == "qwerty")
    call Keyboard("qwerty")
  else
    call Keyboard("workman")
  endif
endfunction

augroup keyboardGroup
  autocmd!
  autocmd VimEnter * call LoadKeyboard()
augroup END

:command! Qwerty call Keyboard("qwerty") | echom "Switched to Qwerty Keyboard Layout"
:command! Workman call Keyboard("workman") | echom "Switched to Workman Keyboard Layout"
