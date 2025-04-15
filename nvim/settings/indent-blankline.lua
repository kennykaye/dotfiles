-- ================ Indent Blankline ========================

local setup, ibl = pcall(require, "ibl")
if not setup then return end

-- Get hooks module
local hooks = require("ibl.hooks")

-- Register highlight setup hook to ensure highlights are applied correctly
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#4e4e4e", ctermfg = 239 })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#6c6c6c", ctermfg = 242 })
  vim.api.nvim_set_hl(0, "IblWhitespace", { fg = "#4e4e4e", ctermfg = 239 })
end)

ibl.setup {
  indent = {
    char = '│', -- Similar to the old indentLine char
  },
  scope = {
    enabled = true,
    show_start = false,
    show_end = false,
  },
  exclude = {
    buftypes = { "terminal", "nofile" },
    filetypes = { "help", "startify", "dashboard", "neogitstatus", "NvimTree", "Trouble", "text" },
  },
}
