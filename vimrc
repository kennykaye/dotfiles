set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where vundle should install plugins
"call vundle#begin('~/some/path/here')

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
Plugin 'Valloric/YouCompleteMe'
Plugin 'Yggdroot/indentLine'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'chriskempson/base16-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jiangmiao/auto-pairs'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'tell-k/vim-browsereload-mac'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set number
set ignorecase
set smartcase
set timeoutlen=1000 ttimeoutlen=0

let mapleader=","

" tmux copy/paste
set clipboard=unnamed

" Custom Mappings
:command! NT NERDTree
:command! Nt NERDTree
:command! Q q
:command! W w
:command! WQ wq
:command! Wq wq
:command! Vimrc :tabe ~/.vimrc
:command! Source so ~/.vimrc
:command! WR :w | :ChromeReload
:command! Path :echo expand('%:p')

" Create a new file in the same directory as the current file
:command! -nargs=+ -complete=file -bar NF :tabe %:p:h/<args>

" Delete single line, or a range of lines and jump back to previous position
:command! -range -nargs=0 D <line1>,<line2>d|norm ``

:map <F6> :tabn<kEnter>
:map <F5> :tabp<kEnter>
:map <C-x> :NERDTreeToggle<CR>
:map <C-l> :w <bar> :ChromeReload<CR>
:map <C-j> :JsDoc<CR>

nmap <space> zz
nmap n nzz
nmap N Nzz

" Easy Motion
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

hi! link SyntasticStyleErrorSign DiffDelete
hi! link SyntasticErrorSign DiffDelete

" jscs returns exit code when no config file is present.
" only load it when appropriate
function! JavascriptCheckers()
  if filereadable(getcwd() . '/.jscsrc')
    return ['jshint', 'jscs']
  else
    return ['jshint']
  endif
endfunction

let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '%E{E%e}%B{, }%W{W%w}'
let g:syntastic_style_error_symbol = "››"
let g:syntastic_error_symbol = "››"
let g:syntastic_warning_symbol = "››"
let g:syntastic_style_warning_symbol = "››"
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers=['phpcs']
let g:syntastic_javascript_checkers=JavascriptCheckers()
let g:syntastic_aggregate_errors = 1


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
let g:promptline_preset = {
        \'a' : [ promptline#slices#user() ],
        \'b' : [ promptline#slices#cwd({ 'dir_limit': 2 }) ],
        \'c' : [ promptline#slices#vcs_branch() ]}

" Tmuxline
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(~/.tmux/uptime.sh)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W', '#F'],
      \'y'    : ['%l:%M %p', '%a %d'],
      \'z'    : '#h'}

" Lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'base16_eighties',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], 
      \           [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'syntasticError', 'syntasticWarning', 'lineinfo' ], 
      \            ['percent'], 
      \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'mode': 'MyMode',
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',      
      \   'ctrlpmark': 'CtrlPMark',
      \ },  
      \ 'component_expand': {
      \   'syntasticError': 'SyntasticErrorCount',
      \   'syntasticWarning': 'SyntasticWarningCount',
      \ },
      \ 'component_type': {
      \   'syntasticError': 'error',
      \   'syntasticWarning': 'warning',
      \ },     
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyFileformat()
  return winwidth(0) > 100 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 100 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname =~ 'NERD_tree' ? '' :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! MyMode()
  let fname = expand('%:t')
  return  fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

function! SyntasticErrorCount()
  let flag = SyntasticStatuslineFlag()
  return matchstr(flag, '\(E\)\@<=\d*')
endfunction

function! SyntasticWarningCount()
  let flag = SyntasticStatuslineFlag()
  return matchstr(flag, '\(W\)\@<=\d*')
endfunction
  
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.js,*.php call s:syntastic()
augroup END

function! s:syntastic()
  call SyntasticCheck()
  call lightline#update()
endfunction

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
