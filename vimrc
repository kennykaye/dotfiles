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
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'gabesoft/vim-ags'
Plug 'Yggdroot/indentLine'
Plug 'kennykaye/vim-relativity', { 'branch': 'dev' }
Plug 'Lokaltog/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'tell-k/vim-browsereload-mac'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'sjl/gundo.vim'

" Lazy-load plugins
Plug 'majutsushi/tagbar',       { 'on': 'TagbarToggle' }
Plug 'tpope/vim-commentary',    { 'on': [
                                \   '<Plug>Commentary',
                                \   '<Plug>CommentaryLine'
                                \   ] }

Plug 'mattn/emmet-vim',         { 'on': 'EmmetInstall' }
Plug 'rizzatti/dash.vim',       { 'on': 'Dash' }
Plug 'Raimondi/delimitMate',    { 'on': [] }
Plug 'junegunn/goyo.vim',       { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim',  { 'on': 'Limelight' }
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'honza/vim-snippets',      { 'on': [] }
Plug 'Valloric/YouCompleteMe',  { 'do': './install.py --clang-completer', 'on': [] }
Plug 'scrooloose/nerdtree',     { 'on': [ 'NERDTreeToggle', 'NERDTreeFind' ] }

" Language-specific plugins
Plug 'tpope/vim-rails',                        { 'for': 'ruby' }
Plug 'tpope/vim-endwise',                      { 'for': 'ruby' }
Plug 'heavenshell/vim-jsdoc',                  { 'for': 'javascript' }
Plug 'marijnh/tern_for_vim',                   { 'for': 'javascript', 'do': 'npm install' }
Plug 'jelera/vim-javascript-syntax',           { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
Plug 'othree/html5.vim',                       { 'for': ['html', 'html.handlebars'] }
Plug 'hail2u/vim-css3-syntax',                 { 'for': ['css', 'scss', 'sass'] }
Plug 'cakebaker/scss-syntax.vim',              { 'for': ['scss', 'sass'] }
Plug 'mustache/vim-mustache-handlebars',       { 'for': 'html.handlebars' }
Plug 'octol/vim-cpp-enhanced-highlight',       { 'for': 'cpp' }
Plug 'aldafu/vim-widl',                        { 'for': ['widl', 'webidl'] }

call plug#end()

" ================ Plugin-Specific Settings ========================
" Settings are stored in seperate files and then sourced
exe 'source' '~/.vim/settings/settings.vim'
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  if (fpath != 'settings')
    exe 'source' fpath
  endif
endfor
