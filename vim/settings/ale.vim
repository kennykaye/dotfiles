let g:ale_sign_error = '››'
let g:ale_sign_warning = '››'

hi! link ALEError Error
hi! link ALEWarning Todo
hi! link ALEErrorSign ErrorMsg
hi! link ALEWarningSign Type

let g:ale_lint_on_insert_leave = 1

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'go': ['gofmt -e', 'go vet', 'golint', 'go build', 'gosimple', 'staticcheck']
\}

augroup AleLintUpdate
  autocmd!
    autocmd BufEnter * call ShowAleSignBar()
    if exists('g:loaded_ale')
      autocmd User ALELint call lightline#update()
    endif
augroup END

" Always show signbar when ale has a linter set
function! ShowAleSignBar()
  let s:filetype = (&ft =~ "." ? split(&ft, "\\.")[0] : &ft)
  if (has_key(g:ale_linters, s:filetype))
    sign define dummy
    execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')
  endif
endfunction
