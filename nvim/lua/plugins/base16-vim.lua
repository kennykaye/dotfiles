return {
  "RRethy/base16-nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme base16-eighties')

    local colors = require('utils.colors')

    -- Window 
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.crust, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.crust, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.overlay0, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.text, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'ColorColumn', { fg = colors.base, bg = colors.base })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = colors.surface0 })

    -- Tabs 
    vim.api.nvim_set_hl(0, 'TabLine', { fg = colors.overlay1, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineIndex', { fg = colors.surface2, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineSelected', { fg = colors.text, bg = colors.base })
    vim.api.nvim_set_hl(0, 'TabLineSelectedIndex', { fg = colors.overlay1, bg = colors.base })
    vim.api.nvim_set_hl(0, 'TabLineSeparator', { fg = colors.base, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineSeparatorHidden', { fg = colors.surface0, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumb', { fg = colors.overlay0, bg = colors.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumbSeparator', { fg = colors.surface2, bg = colors.surface0 })

    -- Float 
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.gray, bg = colors.base })

    -- Picker 
    vim.api.nvim_set_hl(0, 'SnacksPickerPrompt', { fg = colors.red })
    vim.api.nvim_set_hl(0, 'SnacksPickerMatch', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'SnacksPickerRow', { fg = colors.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerColumn', { fg = colors.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerDelim', { fg = colors.overlay1 })

    -- Notfiy 
    vim.api.nvim_set_hl(0, 'SnacksNotifierTitleWarn', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'SnacksNotifierBorderWarn', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'SnacksNotifierFooterWarn', { fg = colors.yellow })
    vim.api.nvim_set_hl(0, 'SnacksNotifierIconWarn', { fg = colors.yellow })

    -- Indent 
    vim.api.nvim_set_hl(0, 'SnacksIndent', { fg = colors.surface1 })
    vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = colors.overlay1 })
  end
}
