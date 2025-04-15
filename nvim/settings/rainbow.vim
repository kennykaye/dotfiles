" let g:rainbow_operators=2

let g:rainbow_conf = {
    \   'guifgs': ['#cc99cc', '#6699cc', '#66cccc', '#99cc99', '#ffcc66', '#f99157', '#f2777a'],
    \}

if &filetype !~? 'clojure'
  let g:rainbow_active = 1
endif
