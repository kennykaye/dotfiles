" =============================================================================
" Filename: autoload/lightline/colorscheme/base16_eighties.vim
" Version: 0.0
" Author: Kenny Kaye
" License: MIT License
" Last Change: 2013/09/07 14:14:14.
" =============================================================================
let s:base3 = '#cccccc'
let s:base23 = '#bbbbbb'
let s:base2 = '#aaaaaa'
let s:base1 = '#999999'
let s:base0 = '#707070'
let s:base00 = '#666666'
let s:base01 = '#616161'
let s:base02 = '#444444'
let s:base023 = '#393939'
let s:base03 = '#242424'
let s:red = '#f2777a'
let s:orange = '#F99157'
let s:yellow = '#ffcc66'
let s:green = '#99cc99'
let s:cyan = '#74e4e4'
let s:blue = '#6699CC'
let s:magenta = '#cc99cc'

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base023, s:cyan ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
let s:p.inactive.left =  [ [ s:base02, s:base0 ], [ s:base00, s:base03 ] ]
let s:p.insert.left = [ [ s:base023, s:green ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base023, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base023, s:yellow ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base1, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base0, s:base02 ] ]
let s:p.tabline.left = [ [ s:base02, s:base03 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base023 ] ]
let s:p.tabline.middle = [ [ s:base02, s:base03 ] ]
let s:p.tabline.right = copy(s:p.tabline.tabsel)
let s:p.normal.error = [ [ s:base023, s:red ] ]
let s:p.normal.warning = [ [ s:base023, s:yellow ] ]

let g:lightline#colorscheme#base16_eighties#palette = lightline#colorscheme#fill(s:p)
