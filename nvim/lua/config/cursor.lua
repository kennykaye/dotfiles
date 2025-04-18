-- Configure cursorline to only appear in active windows
-- This enhances visual distinction between active and inactive windows

local cursorline_group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })

-- Enable cursorline in active windows, disable in inactive ones
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = cursorline_group,
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

return {} 