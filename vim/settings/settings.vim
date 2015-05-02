" ================ General Settings ========================

set nocompatible               " be iMproved, required
set ignorecase
set smartcase
set expandtab
set shiftwidth=2
set tabstop=2
set timeoutlen=700
set ttimeoutlen=0
set wildmenu                   " visual autocomplete for command menu
set laststatus=2
set backspace=indent,eol,start " backspace through lines
set clipboard=unnamed          " tmux and system copy/paste
set lazyredraw                 " only redraw when necessary
set ttyfast                    " smoother screen redraw
set relativenumber             " show line numbers relative to cursor
set number                     " show current line numbers
set cursorline                 " highlight current line
set noshowmode                 " lightline renders mode
set visualbell                 " disable error bell
set scrolloff=5                " set minimum number of lines above and below cursor
set autoread                   " automatically re-read changed files
set mouse=a                    " enable mouse scrolling

" ================ Appearance ========================

syntax on                " enable syntax highlighting
set background=dark      " set dark background
let base16colorspace=256 " Use 256 base16 colorscheme
colorscheme base16-eighties

hi! CursorLine ctermbg=237
hi! CursorLineNr ctermfg=248

" ================ Commands ========================

" General Commands
:command! Q q
:command! Qa qa
:command! W w
:command! Wa wa
:command! WQ wq
:command! Wq wq
:command! Vimrc :tabe ~/.vimrc
:command! Source so ~/.vimrc
:command! Path :echo expand('%:p')

" Create a new file in the same directory as the current file
:command! -nargs=+ -complete=file -bar OT :tabe %:p:h/<args>

" Delete single line, or a range of lines and jump back to previous position
:command! -range -nargs=0 D <line1>,<line2>d|norm ``


" ================ Mappings ========================

" disable Ex-only mapping
nnoremap Q <nop>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Set , to be the leader
let mapleader=","

" Provide easier tab navigation
:map <silent> <F6> :tabn<kEnter>
:map <silent> <F5> :tabp<kEnter>
:map <silent> <End> :tabn<kEnter>
:map <silent> <Home> :tabp<kEnter>

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif


" Show the hilighting informationennoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>for group under cursor
:map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Center text on screen
nmap <space> zz
nmap n nzz
nmap N Nzz

