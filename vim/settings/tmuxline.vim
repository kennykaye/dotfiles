" ================ Tmuxline ========================

" Configuration
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '#W',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : ['#(~/.tmux/uptime.sh)'],
      \'y'    : ['%l:%M %p', '%a %d'],}
