" ================ Promptline ========================

" Configuration
let g:promptline_theme = 'lightline'
let g:promptline_preset = {
        \'a' : [ '$USER' ],
        \'b' : [ promptline#slices#cwd({ 'dir_limit': 2 }) ],
        \'c' : [ promptline#slices#vcs_branch() ],
        \'warn': [ promptline#slices#battery({ 'threshold': 25  }) ],
        \'options': {
        \  'left_sections' : [ 'warn', 'a', 'b', 'c'],
        \  'right_sections' : []}}

