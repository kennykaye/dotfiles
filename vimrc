" ======================== Plugins ========================
" Initialize vim-plug
call plug#begin('~/.vim/bundle')

" Immediately loaded
Plug 'junegunn/vim-plug'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'gabesoft/vim-ags'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'kennykaye/vim-relativity', { 'branch': 'dev' }
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'honza/vim-snippets'

" Lazy-load plugins
Plug 'tpope/vim-commentary',    { 'on': [
                               \   '<Plug>Commentary',
                               \   '<Plug>CommentaryLine'
                               \   ] }

Plug 'mattn/emmet-vim',         { 'on': 'EmmetInstall' }
Plug 'rizzatti/dash.vim',       { 'on': 'Dash' }
Plug 'junegunn/goyo.vim',       { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'scrooloose/nerdtree',     { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

" Language-specific plugins
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails',                        { 'for': 'ruby' }
Plug 'ternjs/tern_for_vim',                    { 'for': 'javascript' }
Plug 'heavenshell/vim-jsdoc',                  { 'for': 'javascript' }
Plug 'othree/jspc.vim',                        { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/html5.vim',                       { 'for': ['html', 'html.handlebars'] }
Plug 'hail2u/vim-css3-syntax',                 { 'for': ['css', 'scss', 'sass'] }
Plug 'rstacruz/vim-hyperstyle',                { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim',              { 'for': ['scss', 'sass'] }
Plug 'mustache/vim-mustache-handlebars',       { 'for': 'html.handlebars' }
Plug 'fatih/vim-go',                           { 'for': 'go' }
Plug 'octol/vim-cpp-enhanced-highlight',       { 'for': 'cpp' }
Plug 'vim-scripts/a.vim',                      { 'for': ['cpp', 'hpp', 'c', 'h'] }
Plug 'dzeban/vim-log-syntax',                  { 'for' : 'log' }
Plug 'tpope/vim-markdown',                     { 'for': 'markdown' }
Plug 'aldafu/vim-widl',                        { 'for': ['widl', 'webidl'] }
Plug 'guns/vim-clojure-static',                { 'for': 'clojure' }
Plug 'tpope/vim-fireplace',                    { 'for': 'clojure' }
Plug 'luochen1990/rainbow',                    { 'for': 'clojure' }

" Neovim specific plugins
if has('nvim')
  Plug 'Shougo/deoplete.nvim',     { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
  Plug 'zchee/deoplete-go',        { 'do': 'make'}
  Plug 'critiqjo/lldb.nvim',       { 'for': ['c', 'cpp'] }
endif

call plug#end()

" ======================== Source Settings ========================
" Settings are stored in seperate files and then sourced

exe 'source' '~/.vim/settings/settings.vim'
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
 if (fpath != 'settings')
   exe 'source' fpath
 endif
endfor
