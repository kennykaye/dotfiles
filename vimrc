set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'tell-k/vim-browsereload-mac'
Plugin 'mattn/emmet-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
set ignorecase
set smartcase
set timeoutlen=400 ttimeoutlen=0
set lazyredraw          " redraw only when we need to.
set wildmenu            " visual autocomplete for command menu"
set cursorline          " highlight current line"
set laststatus=2
set noshowmode

let mapleader=","

" tmux copy/paste
set clipboard=unnamed

" Custom Mappings
:command! NT NERDTree
:command! Nt NERDTree
:command! Q q
:command! Qa qa
:command! W w
:command! Wa wa
:command! WQ wq
:command! Wq wq
:command! Gb :Gblame
:command! Gd :Gdiff
:command! -nargs=+ Gs :Gsplit <args>
:command! Vimrc :tabe ~/.vimrc
:command! Source so ~/.vimrc
:command! WR :w | :ChromeReload
:command! Path :echo expand('%:p')

" Create a new file in the same directory as the current file
:command! -nargs=+ -complete=file -bar OT :tabe %:p:h/<args>
:command! -nargs=+ -complete=file -bar OV :vsplit %:p:h/<args>

" Delete single line, or a range of lines and jump back to previous position
:command! -range -nargs=0 D <line1>,<line2>d|norm ``

:map <silent> <C-b> :Gblame<CR>
:map <silent> <F6> :tabn<kEnter>
:map <silent> <F5> :tabp<kEnter>
:map <silent> <End> :tabn<kEnter>
:map <silent> <Home> :tabp<kEnter>
:map <silent> <C-x> :NERDTreeToggle<CR>
:map <C-j> :JsDoc<CR>
:map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nmap <space> zz
nmap n nzz
nmap N Nzz

" Easy Motion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

hi link EasyMotionTarget Constant
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First String
hi link EasyMotionTarget2Second String

hi link EasyMotionIncSearch Type

" Emmet
let g:user_emmet_leader_key='<C-l>'

" Multiple Cursors
hi! link multiple_cursors_cursor LightLineLeft_visual_0
hi! link multiple_cursors_visual LightLineLeft_visual_0

" JsDoc
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_default_mapping = 0

" Browser reload
let g:returnApp = "iTerm"

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" Syntax highlighting
syntax on
let base16colorspace=256
let g:used_javascript_libs = 'underscore,jquery,react,flux,chai'
colorscheme base16-eighties 
set background=dark

" Indent Line
let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree.*', '.*\.txt']
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '¦'
set expandtab
set shiftwidth=2
set tabstop=2

augroup fileSettings
  autocmd!
  autocmd Filetype php setlocal ts=4 sw=4 expandtab 
  autocmd Filetype html setlocal ts=4 sw=4 expandtab
  autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
  autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
augroup END

" Promptline
let g:promptline_theme = 'lightline'
let g:promptline_preset = {
        \'a' : [ '$USER' ],
        \'b' : [ promptline#slices#cwd({ 'dir_limit': 2 }) ],
        \'c' : [ promptline#slices#vcs_branch() ],
        \'warn': [ promptline#slices#battery({ 'threshold': 25  }) ],
        \'options': {
        \  'left_sections' : [ 'warn', 'a', 'b', 'c'],
        \  'right_sections' : []}}


" Tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : ['#(~/.tmux/uptime.sh)'],
      \'y'    : ['%l:%M %p', '%a %d'],}


" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

if executable('matcher')
	let g:ctrlp_match_func = { 'match': 'GoodMatch' }

	function! GoodMatch(items, str, limit, mmode, ispath, crfile, regex)

	  " Create a cache file if not yet exists
	  let cachefile = ctrlp#utils#cachedir().'/matcher.cache'
	  if !( filereadable(cachefile) && a:items == readfile(cachefile) )
      call writefile(a:items, cachefile)
	  endif
	  if !filereadable(cachefile)
      return []
	  endif

	  " a:mmode is currently ignored. In the future, we should probably do
	  " something about that. the matcher behaves like "full-line".
	  let cmd = 'matcher --limit '.a:limit.' --manifest '.cachefile.' '
    if !( exists('g:ctrlp_show_hidden') && g:ctrlp_show_hidden == 0 )
		  let cmd = cmd.'--no-dotfiles '
	  endif
	  let cmd = cmd.a:str

	  return split(system(cmd), "\n")

	endfunction
end


" ================ Custom Settings ========================
" Settings are stored in seperate files and then sourced 
for fpath in split(globpath('~/.vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
