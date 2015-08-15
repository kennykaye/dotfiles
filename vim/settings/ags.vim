" ================ Ag ========================

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " bind \ (backward slash) to grep shortcut
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

  " Mappings
  nnoremap \ :Ags<SPACE>

  " Settings
  let g:ags_agcontext = 2
  let g:ags_agargs = {
              \ '--break'             : [ '', '' ],
              \ '--color'             : [ '', '' ],
              \ '--color-line-number' : [ '"1;30"', '' ],
              \ '--color-match'       : [ '"32;40"', '' ],
              \ '--color-path'        : [ '"1;31"', '' ],
              \ '--column'            : [ '', '' ],
              \ '--context'           : [ 'g:ags_agcontext', '-C', '3' ],
              \ '--filename'          : [ '', '' ],
              \ '--group'             : [ '', '' ],
              \ '--heading'           : [ '', '-H' ],
              \ '--max-count'         : [ 'g:ags_agmaxcount', '-m', '2000' ],
              \ '--numbers'           : [ '', '' ]
              \ }

  " Syntax Highlighting
  hi! link agsvFilePath ErrorMsg
  hi! link agsvLineNum LineNr
  hi! link agsvLineNumMatch Type
  hi! link agsvResultPattern Type

  " File type specific settings
  augroup ags_settings
    autocmd!
    autocmd Filetype agsv setlocal nonumber norelativenumber
  augroup END

endif
