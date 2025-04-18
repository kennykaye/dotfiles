return {
  "RRethy/base16-nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme base16-eighties')

    local C = require('utils.colors')

    -- Window 
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = C.crust, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = C.crust, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = C.overlay0, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = C.text, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'ColorColumn', { fg = C.text, bg = C.base })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = C.surface0 })

    -- Tabs 
    vim.api.nvim_set_hl(0, 'TabLine', { fg = C.overlay1, bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineIndex', { fg = C.surface2, bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineSelected', { fg = C.text, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineSelectedIndex', { fg = C.overlay1, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineSeparator', { fg = C.base, bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineSeparatorHidden', { fg = C.surface0, bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumb', { fg = C.overlay0, bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumbSeparator', { fg = C.surface2, bg = C.surface0 })

    -- Float 
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'FloatTitle', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'FloatBorder', { fg = C.gray, bg = C.base })
    --
    -- Picker 
    vim.api.nvim_set_hl(0, 'SnacksNormal', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPicker', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksNormalNC', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPickerBox', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPickerList', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPickerInput', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPickerPreview', { bg = C.base })
    vim.api.nvim_set_hl(0, 'SnacksPickerPrompt', { fg = C.red })
    vim.api.nvim_set_hl(0, 'SnacksPickerMatch', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'SnacksPickerRow', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerColumn', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerDelim', { fg = C.overlay1 })

    -- Notfiy 
    vim.api.nvim_set_hl(0, 'SnacksNotifierIconInfo', { fg = C.sky })
    vim.api.nvim_set_hl(0, 'SnacksNotifierTitleInfo', { fg = C.sky })
    vim.api.nvim_set_hl(0, 'SnacksNotifierIconWarn', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'SnacksNotifierTitleWarn', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'SnacksNotifierBorderWarn', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksNotifierFooterWarn', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksNotifierBorderInfo', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksNotifierFooterInfo', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksNotifierBorderError', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksNotifierFooterError', { fg = C.overlay1 })

    -- Noice
    vim.api.nvim_set_hl(0, 'NoicePopup', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'NoiceSplit', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'DapUIFloatNormal', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = C.teal })

    -- Indent 
    vim.api.nvim_set_hl(0, 'SnacksIndent', { fg = C.surface1 })
    vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = C.overlay1 })

    -- Diagnostics
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = C.yellow })

    -- Treesitter
    vim.api.nvim_set_hl(0, 'TSVariable', { fg = C.text })
    vim.api.nvim_set_hl(0, 'TSFuncBuiltin', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'TSTitle', { fg = C.yellow })

    -- PMenu 
    vim.api.nvim_set_hl(0, 'PMenu', { fg = "NONE", bg = C.surface0 })
    vim.api.nvim_set_hl(0, 'PMenuSel', { fg = "NONE", bg = C.surface2, bold = true })
    vim.api.nvim_set_hl(0, 'PmenuKind', { fg = "NONE" })
    vim.api.nvim_set_hl(0, 'PmenuKindSel', { fg = "NONE", bg = C.surface2 })
    vim.api.nvim_set_hl(0, 'PmenuExtraSel', { fg = "NONE", bg = C.surface2 })
    vim.api.nvim_set_hl(0, 'PMenuThumb', { fg = C.base, bg = C.surface1 })

    -- LSP
    vim.api.nvim_set_hl(0, "CmpItemMenu", { bg= 'NONE', fg = C.text })
    vim.api.nvim_set_hl(0, "CmpItemAbbr", { bg = 'NONE', fg = C.text })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough=true, fg=C.overlay2 })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg=C.yellow })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { bg = 'NONE', fg=C.yellow })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg=C.sky })
    vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { bg = 'NONE', fg=C.sky })
    vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg=C.sky })
    vim.api.nvim_set_hl(0, 'CmpItemKindText', { bg = 'NONE', fg=C.sky })
    vim.api.nvim_set_hl(0, 'CmpItemKindField', { bg = 'NONE', fg = C.green })
    vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg=C.mauve })
    vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { bg = 'NONE', fg=C.mauve })
    vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg=C.eggshell })
    vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { bg = 'NONE', fg=C.eggshell })
    vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { bg = 'NONE', fg=C.eggshell })
    vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { fg = C.yellow })
  end
}
