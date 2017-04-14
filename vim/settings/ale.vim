let g:ale_sign_error = '››'
let g:ale_sign_warning = '››'

hi! link ALEError Error
hi! link ALEWarning Todo
hi! link ALEErrorSign ErrorMsg
hi! link ALEWarningSign Label

let g:ale_lint_on_insert_leave = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['gofmt -e', 'go vet', 'golint', 'go build', 'gosimple', 'staticcheck']
\}

augroup AleLintUpdate
  autocmd!
    autocmd BufEnter * call ShowAleSignBar()
    autocmd User ALELint call UpdateLightLine()
augroup END

function! UpdateLightLine()
  if (g:lightline_enabled != 0)
    call lightline#update()
  endif
endfunction

" Always show signbar when ale has a linter set
function! ShowAleSignBar()
  let s:filetype = (&ft =~ "." ? split(&ft, "\\.")[0] : &ft)
  if (has_key(g:ale_linters, s:filetype))
    sign define dummy
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  endif
endfunction
