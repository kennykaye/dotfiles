" ================ Fugitive  ========================

" Commands
:command! Gb :Gblame
:command! Gd :Gdiff
:command! -nargs=+ Gs :Gsplit <args>

" Mappings
:map <silent> <C-b> :Gblame<CR>

" Every time you open a git object using fugitive it creates a new buffer. 
" This means that your buffer listing can quickly become swamped with 
" fugitive buffers. This prevents this from becomming an issue:
autocmd BufReadPost fugitive://* set bufhidden=delete
