" ================ Commands ========================
" Custom commands are defined in this file

" Custom Mappings
:command! NT NERDTree
:command! Nt NERDTree
:command! Q q
:command! Qa qa
:command! W w
:command! Wa wa
:command! WQ wq
:command! Wq wq
:command! Vimrc :tabe ~/.vimrc
:command! Source so ~/.vimrc
:command! WR :w | :ChromeReload
:command! Path :echo expand('%:p')

" Create a new file in the same directory as the current file
:command! -nargs=+ -complete=file -bar OT :tabe %:p:h/<args>
:command! -nargs=+ -complete=file -bar OV :vsplit %:p:h/<args>

" Delete single line, or a range of lines and jump back to previous position
:command! -range -nargs=0 D <line1>,<line2>d|norm ``

