" ================ EasyMotion ========================

" Mappings
map  <C-s> <Plug>(easymotion-sn)
omap <C-s> <Plug>(easymotion-tn)
map  <C-/> <Plug>(easymotion-sn)
omap <C-/> <Plug>(easymotion-tn)
map  <C-_> <Plug>(easymotion-sn) " tmux C-/
omap <C-_> <Plug>(easymotion-tn) " tmux C-/
map  <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
map  <leader>s <Plug>(easymotion-sn)
omap <leader>s <Plug>(easymotion-tn)


" Configuration
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Highlighting
if ($ITERM_PROFILE == "light")
  hi link EasyMotionTarget SpecialChar
  hi link EasyMotionShade  VertSplit

  hi EasyMotionTarget2First  ctermfg=yellow guifg=#ffcc66
  hi EasyMotionTarget2Second ctermfg=cyan guifg=#66cccc

  hi link EasyMotionIncSearch Directory
else
  hi EasyMotionTarget ctermfg=yellow guifg=#ffcc66
  hi link EasyMotionShade  LineNr

  hi EasyMotionTarget2First  ctermfg=yellow guifg=#ffcc66
  hi EasyMotionTarget2Second ctermfg=cyan guifg=#66cccc

  hi link EasyMotionIncSearch Type
endif
