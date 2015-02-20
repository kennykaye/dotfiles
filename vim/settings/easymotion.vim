" ================ EasyMotion ========================

" Mappings
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" Configuration
let g:EasyMotion_use_upper = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

" Highlighting
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First String
hi link EasyMotionTarget2Second String

hi link EasyMotionIncSearch Type

