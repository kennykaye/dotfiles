set nocompatible              " be iMproved, required
filetype off                  " required

" Initialize vim-plug
call plug#begin('~/.vim/plugged')

" Immediately loaded
Plug 'junegunn/vim-plug'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'Yggdroot/indentLine'
Plug 'chriskempson/base16-vim'
Plug 'jiangmiao/auto-pairs'

" On-demand loading
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'Shougo/neocomplete.vim'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" File-type specific loading
Plug 'othree/html5.vim', { 'for': ['html', 'html.handlebars'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass'] }
Plug 'heavenshell/vim-jsdoc', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'tell-k/vim-browsereload-mac'
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'sass', 'scss', 'html.handlebars'] }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'html.handlebars' }

call plug#end()              " required
filetype plugin indent on    " required

set ignorecase
set smartcase
set timeoutlen=700 ttimeoutlen=0
set wildmenu            " visual autocomplete for command menu"
set laststatus=2

" tmux copy/paste
set clipboard=unnamed

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


" ================ Plugin-Specific Settings ========================
" Settings are stored in seperate files and then sourced 
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
