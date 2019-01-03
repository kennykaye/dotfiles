" ======================== General Settings ========================

set ignorecase
set smartcase
set expandtab
set shiftwidth=2
set tabstop=2
set timeoutlen=700
set ttimeoutlen=0
set wildmenu                   " visual autocomplete for command menu
set exrc                       " load project-specific vimrc's
set secure                     " limit the capability of those vimrc's
set laststatus=2
set noswapfile
set termguicolors              " set gui colors for vim and nvim
set backspace=indent,eol,start " backspace through lines
set clipboard=unnamed          " tmux and system copy/paste
set lazyredraw                 " only redraw when necessary
set number                     " show current line numbers
set cursorline                 " highlight current line
set noshowmode                 " lightline renders mode
set visualbell                 " disable error bell
set scrolloff=5                " set minimum number of lines above/below cursor
set sidescroll=1               " enable horizontal scrolling
set sidescrolloff=1            " horizontal scrolling is offset by '>'
set nowrap                     " disable autowrapping
set autoread                   " automatically re-read changed files
set mouse=a                    " enable mouse scrolling
set completeopt-=preview       " disable preview scratch buffer
set splitbelow                 " open new split below current split
set splitright                 " open new split to the right
set nrformats+=alpha           " Allow integers to be incremented/decremented
set nohlsearch                 " Prevent search results from being highlighted
set colorcolumn=101            " Highlight column
set backupcopy=yes
set listchars+=extends:…
set listchars+=precedes:…
set undodir=~/.config/nvim/undodir
set undofile

" ======================== Appearance ========================

syntax on                       " enable syntax highlighting
syntax sync minlines=200
set fillchars+=vert:│
hi! link VertSplit Conceal

" Vim background and colorscheme set based on terminal profile
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  set background=dark            " set dark background
  colorscheme base16-kaye
  let g:lightlineTheme=base16-kaye
endif

if !has('nvim')
  set nocompatible               " be iMproved, required
  set ttyfast                    " smoother screen redraw
endif

" ======================== Commands ========================

" General Commands
:command! Q q
:command! Qa qa
:command! W w
:command! Wa wa
:command! WQ wq
:command! Wq wq
:command! Wqa wqa
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
:command! FormatJSON set ft=json | %!python -m json.tool

" Format XML Documents
:command! FormatXML set ft=xml | %!xmllint --format %


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
map <silent> <F6> :tabn<kEnter>
map <silent> <F5> :tabp<kEnter>
map <silent> <End> :tabn<kEnter>
map <silent> <Home> :tabp<kEnter>

" Increment / Decrement numbers
nnoremap <silent> - <C-x>
nnoremap <silent> + <C-a>

:map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Center text on screen
nmap <space> zz
nmap n nzz
nmap N Nzz

" nvim specific config
if has('nvim')
  let g:python2_host_prog = '/usr/local/bin/python'
  let g:python3_host_prog = '/usr/local/bin/python3'
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
