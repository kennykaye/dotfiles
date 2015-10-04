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
set number                     " show current line numbers
set cursorline                 " highlight current line
set noshowmode                 " lightline renders mode
set visualbell                 " disable error bell
set scrolloff=5                " set minimum number of lines above and below cursor
set autoread                   " automatically re-read changed files
set mouse=a                    " enable mouse scrolling
set completeopt-=preview       " disable preview scratch buffer
set splitbelow                 " open new split below current split
set splitright                 " open new split to the right

" ================ Appearance ========================

syntax on                      " enable syntax highlighting
set background=dark            " set dark background
let base16colorspace=256       " Use 256 base16 colorscheme
colorscheme base16-kaye
set fillchars+=vert:│
hi! link VertSplit Conceal

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
" new tab
:command! -nargs=+ -complete=file -bar OT :tabe %:p:h/<args>
" vertical split
:command! -nargs=+ -complete=file -bar OV :vnew %:p:h/<args>
" horizontal split
:command! -nargs=+ -complete=file -bar OS :new %:p:h/<args>

" Delete single line, or a range of lines and jump back to previous position
:command! -range -nargs=0 D <line1>,<line2>d|norm ``


" Format JSON Documents
:command! FormatJSON %!python -m json.tool

" Format XML Documents
:command! FormatXML %!xmlling --format %


" Replace the current buffer with a new buffer
function! ReplaceBuffer(bang, newfile)
  let curbuf = bufnr('%')
  exec "e %:p:h/" . a:newfile
  exec "bd" . a:bang . " " . curbuf
endfunction
:command! -nargs=1 -complete=file -bang -bar BDE call ReplaceBuffer('<bang>', <f-args>)

" ================ Mappings ========================

" disable Ex-only mapping
nnoremap Q <nop>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Set , to be the leader
let mapleader = ","
let maplocalleader = ","

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

" Changing cursor shape per mode
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
if exists('$TMUX')
    " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
    silent !echo -ne "\033Ptmux;\033\033[2 q\033\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[0 q\033\\"
else
    let &t_SI .= "\<Esc>[4 q"
    let &t_EI .= "\<Esc>[2 q"
    autocmd VimLeave * silent !echo -ne "\033[2 q"
    autocmd VimLeave * silent !echo -ne "\033[0 q"
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

