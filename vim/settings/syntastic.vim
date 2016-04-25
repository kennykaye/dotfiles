" ================ Syntastic  ========================
" Configurations Syntastic and respective linters

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" Improve display of syntastic numberline flags
hi! link SyntasticStyleErrorSign ErrorMsg
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign Type
hi! link SyntasticStyleWarningSign Type

" jscs returns exit code when no config file is present.
" only load it when appropriate
function! JavascriptCheckers()
  if filereadable(getcwd() . '/.jscsrc')
    return ['jshint', 'jscs']
  else
    return ['jshint']
  endif
endfunction

function! PhpcsArgs()
  let fpath = getcwd() . '/.phpcs.xml'
  if filereadable(fpath)
    return '-s --report=csv --standard=' . fpath
  endif
endfunction

" Only enable scss linter if there is a config in root
function! ScssChecker()
  if filereadable(getcwd() . '/.scss-lint.yml')
    return ['scss_lint']
  else
    return []
  endif
endfunction
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '%E{E%e}%B{, }%W{W%w}'  "Parsed by lightline
let g:syntastic_style_error_symbol = "››"
let g:syntastic_error_symbol = "››"
let g:syntastic_warning_symbol = "››"
let g:syntastic_style_warning_symbol = "››"
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_scss_checkers = ScssChecker()
let g:syntastic_html_checkers = ['']
let g:syntastic_php_phpcs_args = PhpcsArgs()
let g:syntastic_javascript_checkers = JavascriptCheckers()
let g:syntastic_aggregate_errors = 1
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }

let g:syntastic_cpp_checkers = ['']

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.js,*.php call s:syntastic()
augroup END

" Update lightline
function! s:syntastic()
  call SyntasticCheck()
  call lightline#update()
endfunction
