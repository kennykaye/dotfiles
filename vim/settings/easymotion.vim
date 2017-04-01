" ================ EasyMotion ========================

" Mappings
map  <C-_> <Plug>(easymotion-sn)
omap <C-_> <Plug>(easymotion-tn)

" Configuration
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Highlighting
if ($ITERM_PROFILE == "light")
  hi link EasyMotionTarget SpecialChar
  hi link EasyMotionShade  VertSplit

  hi link EasyMotionTarget2First String
  hi link EasyMotionTarget2Second String

  hi link EasyMotionIncSearch Directory
else
  hi link EasyMotionTarget ErrorMsg
  hi link EasyMotionShade  LineNr

  hi link EasyMotionTarget2First String
  hi link EasyMotionTarget2Second String

  hi link EasyMotionIncSearch Type
endif
