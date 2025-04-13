-- Configure fzf-lua
require('fzf-lua').setup {
'telescope',
  winopts = {
    preview = {
      default = 'bat',
      border = 'rounded',
      layout = 'flex',
      vertical = 'down:50%',
      horizontal = 'right:50%',
    },
  },
  fzf_opts = {
    ['--layout'] = 'reverse'
  }
} 