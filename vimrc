" Initialize vim-plug
call plug#begin('~/.vim/bundle')

" Immediately loaded
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
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
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'

" Lazy-load plugins
Plug 'majutsushi/tagbar',       { 'on': 'TagbarToggle' }
Plug 'ctrlpvim/ctrlp.vim',      { 'on': 'CtrlP' }
Plug 'FelikZ/ctrlp-py-matcher', { 'on': [] }
Plug 'tpope/vim-commentary',    { 'on': [
                                \   '<Plug>Commentary',
                                \   '<Plug>CommentaryLine'
                                \   ] }
Plug 'junegunn/goyo.vim',       { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'Valloric/YouCompleteMe',  { 'do': './install.sh', 'on': [] }
Plug 'scrooloose/nerdtree',     { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

" Language-specific plugins
Plug 'heavenshell/vim-jsdoc',                  { 'for': 'javascript' }
Plug 'marijnh/tern_for_vim',                   { 'for': 'javascript', 'do': 'npm install' }
Plug 'jelera/vim-javascript-syntax',           { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim',                       { 'for': ['html', 'html.handlebars'] }
Plug 'cakebaker/scss-syntax.vim',              { 'for': ['scss', 'sass'] }
Plug 'tell-k/vim-browsereload-mac'
Plug 'mattn/emmet-vim',                        { 'for': ['html', 'php', 'css', 'sass', 'scss', 'html.handlebars'] }
Plug 'mustache/vim-mustache-handlebars',       { 'for': 'html.handlebars' }

call plug#end()

" ================ Plugin-Specific Settings ========================
" Settings are stored in seperate files and then sourced
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
