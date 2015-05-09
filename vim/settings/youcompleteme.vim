" ================ You Complete Me ========================

" Defer YouCompleteMe load until insert mode is entered
augroup load_us_ycm
  autocmd!
  autocmd InsertEnter * call plug#load('vim-snippets', 'YouCompleteMe')
                     \| call youcompleteme#Enable()
                     \| autocmd! load_us_ycm
augroup END

" Configuration
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

augroup set_omnifunc
  autocmd!
  autocmd FileType javascript setlocal omnifunc=tern#Complete
augroup END
