-- Configure fzf-lua
local setup, fzflua = pcall(require, "fzf-lua")
if not setup then return end

-- Link FzfLuaBackdrop highlight to NvimTreeBackdrop
vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
  callback = function()
    vim.api.nvim_set_hl(0, "FzfLuaBackdrop", { link = "NvimTreeBackdrop" })
  end,
  desc = "Link FzfLuaBackdrop to NvimTreeBackdrop"
})

-- Initial setup of highlight
vim.api.nvim_set_hl(0, "FzfLuaBackdrop", { link = "NvimTreeBackdrop" })

fzflua.setup {
'telescope',
  winopts = {
    backdrop  = 60,
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