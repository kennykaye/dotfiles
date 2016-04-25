" " Mode detection curtousy of
" " https://github.com/Greduan/dotfiles/blob/76e16dd8a04501db29989824af512c453550591d/vim/after/plugin/statusline.vim#L3-L42

" " Define all the different modes. The keys are mode() output
" let g:currentmode={
" 	\ 'n'  : 'Normal',
" 	\ 'no' : 'N·Operator Pending',
" 	\ 'v'  : 'Visual',
" 	\ 'V'  : 'V·Line',
" 	\ 'Vb' : 'V·Block',
" 	\ 's'  : 'Select',
" 	\ 'S'  : 'S·Line',
" 	\ 'Sb' : 'S·Block',
" 	\ 'i'  : 'Insert',
" 	\ 'R'  : 'Replace',
" 	\ 'Rv' : 'V·Replace',
" 	\ 'c'  : 'Command',
" 	\ 'cv' : 'Vim Ex',
" 	\ 'ce' : 'Ex',
" 	\ 'r'  : 'Prompt',
" 	\ 'rm' : 'More',
" 	\ 'r?' : 'Confirm',
" 	\ '!'  : 'Shell',
" 	\}

" " Automatically change the statusline color depending on mode
" " Changing cursor shape per mode
" " 1 or 0 -> blinking block
" " 2 -> solid block
" " 3 -> blinking underscore
" " 4 -> solid underscore
" function! s:change_cursor_by_mode()
"   if (mode() ==# 'i')
"     if exists('$TMUX')
"       silent !echo -ne '\033Ptmux;\033\033[4 q\033\\'
"     else
"       silent !echo -ne '\033[4 q'
"     endif
"   else
"     if exists('$TMUX')
"       silent !echo -ne '\033Ptmux;\033\033[2 q\033\\'
"     else
"       silent !echo -ne '\033[2 q'
"     endif
"   endif

" 	return ''
" endfunction


" if &term =~ '^screen'
"     " tmux will send xterm-style keys when its xterm-keys option is on
"     execute "set <xUp>=\e[1;*A"
"     execute "set <xDown>=\e[1;*B"
"     execute "set <xRight>=\e[1;*C"
"     execute "set <xLeft>=\e[1;*D"
" endif

" if exists('$TMUX')
"     " tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
"     let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
"     let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
"     " autocmd VimLeave * silent !echo -ne '\033Ptmux;\033\033[0 q\033\\'
"     autocmd FocusGained * call s:change_cursor_by_mode()
" else
"     let &t_SI .= "\<Esc>[4 q"
"     let &t_EI .= "\<Esc>[2 q"
"     " autocmd VimLeave * silent !echo -ne '\033[0 q'
"     autocmd FocusGained * call s:change_cursor_by_mode()

" endif
