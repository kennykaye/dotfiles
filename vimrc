" ======================== Plugins ========================
" Initialize vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" Immediately loaded
Plug 'junegunn/vim-plug'
Plug 'RRethy/base16-nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'dense-analysis/ale'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'kennykaye/vim-relativity', { 'branch': 'dev' }
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }

" Lazy-load plugins
Plug 'tpope/vim-commentary',    { 'on': [
                               \   '<Plug>Commentary',
                               \   '<Plug>CommentaryLine'
                               \   ] }

Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }
Plug 'nvim-tree/nvim-tree.lua', { 'on': [ 'NvimTreeToggle', 'NvimTreeFindFile' ] }

" Language-specific plugins
Plug 'pangloss/vim-javascript',                  { 'for': ['javascript', 'javascript.jsx'] }
Plug 'heavenshell/vim-jsdoc',                  { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/html5.vim',                       { 'for': ['html', 'html.handlebars'] }
Plug 'hail2u/vim-css3-syntax',                 { 'for': ['css', 'scss', 'sass'] }
Plug 'ap/vim-css-color'
Plug 'mustache/vim-mustache-handlebars',       { 'for': 'html.handlebars' }
Plug 'fatih/vim-go',                           { 'for': 'go' }
Plug 'dzeban/vim-log-syntax',                  { 'for' : 'log' }
Plug 'tpope/vim-markdown',                     { 'for': 'markdown' }
Plug 'guns/vim-clojure-static',                { 'for': 'clojure' }
Plug 'tpope/vim-fireplace',                    { 'for': 'clojure' }
Plug 'luochen1990/rainbow',                    { 'for': 'clojure' }
Plug 'udalov/kotlin-vim',                      { 'for': 'kotlin' }

" Neovim specific plugins
if has('nvim')
  Plug 'ibhagwan/fzf-lua'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

call plug#end()

" ======================== Source Settings ========================
" Settings are stored in seperate files and then sourced

exe 'source' '~/.vim/settings/settings.vim'
for fpath in split(globpath('~/.vim/settings', '*.{vim,lua}'), '\n')
  if (fpath != 'settings')
    if fpath =~ '\.lua$'
      exe 'luafile' fpath
    else
      exe 'source' fpath
    endif
  endif
endfor
