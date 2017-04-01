" ================ Emmet ========================

" Configuration
let g:user_emmet_leader_key='<C-l>'
let g:user_emmet_install_global = 0

let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}

" Only enable emmet for filetypes that load it
autocmd FileType html,php,css,sass,scss,html.handlebars,ruby,javascript,javascript.jsx EmmetInstall
