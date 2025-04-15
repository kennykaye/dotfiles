" ================ Fugitive  ========================

" Commands
:command! Gb :Gblame
:command! Gd :Gdiff
:command! -nargs=+ Gs :Gsplit <args>

" Mappings
:noremap <silent><leader>b :Gblame<CR>
:noremap <silent><leader>d :Gdiff<CR>

" Every time you open a git object using fugitive it creates a new buffer.
" This means that your buffer listing can quickly become swamped with
" fugitive buffers. This prevents this from becomming an issue:
autocmd BufReadPost fugitive://* set bufhidden=delete
