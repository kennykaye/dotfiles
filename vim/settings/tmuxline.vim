" ================ Tmuxline ========================

" Configuration
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'c'    : ['#(~/.tmux/uptime.sh)'],
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : ['%l:%M %p#(~/.tmux/battery.sh)'],
      \'y'    : ['%a %d'],}
