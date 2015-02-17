" ================ CtrlP ========================

" Defer ctrlp loading until map is pressed
:command! CtrlPLoad call plug#load('ctrlp.vim', 'ctrlp-py-matcher')
:map <silent> <C-p> :CtrlPLoad <CR> :CtrlP<CR>

" Configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_max_files = 0

" Custom Highlighting
hi! link CtrlPNoEntries ErrorMsg
hi! link CtrlPMatch     Type
hi! link CtrlPPrtText   Type
hi! link CtrlPPrtCursor Type


" The Silver Searcher
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" ========================================

" Custom C Matcher, doesn't have colorgroups, disabled in favor of pymatcher
if executable('matcher')
 " let g:ctrlp_match_func = { 'match': 'GoodMatch' }

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
	  let cmd = cmd.a:str

	  return split(system(cmd), "\n")

	endfunction
end

