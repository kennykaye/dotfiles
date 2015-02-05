" ================ Commands ========================
" Custom generic key mappings are defined in this file

" Set , to be the leader
let mapleader=","

" Provide easier tab navigation
:map <silent> <F6> :tabn<kEnter>
:map <silent> <F5> :tabp<kEnter>
:map <silent> <End> :tabn<kEnter>
:map <silent> <Home> :tabp<kEnter>

" Show the hilighting information for group under cursor
:map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Center text on screen
nmap <space> zz
nmap n nzz
nmap N Nzz

