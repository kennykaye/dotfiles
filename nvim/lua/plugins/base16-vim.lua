return {
  "RRethy/base16-nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme base16-eighties')

    local C = require('utils.colors')

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.HINT] = '󰠠 ',
          [vim.diagnostic.severity.INFO] = ' ',
        },
      }
    })

    -- Window 
    vim.api.nvim_set_hl(0, 'VertSplit', { fg = C.mantle, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'WinSeparator', { fg = C.mantle, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'LineNr', { fg = C.overlay0, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = C.text, bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'ColorColumn', { fg = C.text, bg = C.base })
    vim.api.nvim_set_hl(0, 'CursorLine', { bg = C.surface0 })

    -- -- Tabs 
    vim.api.nvim_set_hl(0, 'TabLine', { fg = C.surface2, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineFill', { bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineIndex', { fg = C.surface2, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineSelected', { fg = C.eggshell, bg = C.base, bold = true })
    vim.api.nvim_set_hl(0, 'TabLineSelectedIndex', { fg = C.overlay1, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineSeparator', { fg = C.surface0, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumb', { fg = C.overlay0, bg = C.base })
    vim.api.nvim_set_hl(0, 'TabLineBreadcrumbSeparator', { fg = C.surface2, bg = C.base })

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
    vim.api.nvim_set_hl(0, 'SnacksPickerBorder', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerBoxBorder', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerListBorder', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerInputBorder', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'SnacksPickerPreviewBorder', { fg = C.overlay1 })

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
    vim.api.nvim_set_hl(0, 'NoiceVirtualText', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopup', { bg = C.base })
    vim.api.nvim_set_hl(0, 'NoiceCmdlineIcon', { fg = C.teal })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleCmdline', { fg = C.teal })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorder', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupBorderSearch', { fg = C.overlay1 })
    vim.api.nvim_set_hl(0, 'NoiceCmdlinePopupTitleSearch', { fg = C.yellow })

    -- Indent 
    vim.api.nvim_set_hl(0, 'SnacksIndent', { fg = C.surface0 })
    vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = C.surface1 })

    -- Diagnostics
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = C.yellow })
    vim.api.nvim_set_hl(0, 'DiagnosticFloatingHint', { fg = C.subtext0 })
    vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextHint', { fg = C.subtext0 })
    vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = C.subtext0 })

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

    -- LSP and autocomplete
    vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = C.surface0, fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { bg = C.surface0, fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEnum', { bg = 'NONE', fg = C.yellow })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFile', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindText', { bg = 'NONE', fg = C.sky })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindUnit', { bg = 'NONE', fg = C.eggshell })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindClass', { bg = 'NONE', fg = C.yellow })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindColor', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEvent', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindField', { bg = 'NONE', fg = C.green })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindValue', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFolder', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindMethod', { bg = 'NONE', fg = C.mauve })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindModule', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindStruct', { bg = 'NONE', fg = C.yellow })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindKeyword', { bg = 'NONE', fg = C.eggshell })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindSnippet', { bg = 'NONE', fg = C.subtext0 })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindConstant', { bg = 'NONE', fg = C.flamingo })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindFunction', { bg = 'NONE', fg = C.mauve })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindOperator', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindProperty', { bg = 'NONE', fg = C.eggshell })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindVariable', { bg = 'NONE', fg = C.sky })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindInterface', { bg = 'NONE', fg = C.sky })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindReference', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindEnumMember', { bg = 'NONE', fg = C.green })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindConstructor', { bg = 'NONE', fg = C.yellow })
    vim.api.nvim_set_hl(0, 'BlinkCmpKindTypeParameter', { bg = 'NONE', fg = C.teal })
    vim.api.nvim_set_hl(0, 'BlinkCmpSignatureHelpActiveParameter', { bg = 'NONE', fg = C.text })
    vim.api.nvim_set_hl(0, 'BlinkCmpLabelDeprecated', { bg = 'NONE', strikethrough=true, fg=C.overlay2 })

    -- Hop and search
    vim.api.nvim_set_hl(0, 'IncSearch', { bg = C.yellow, fg = C.base })
    vim.api.nvim_set_hl(0, 'HopUnmatched', { bg = 'NONE', fg = C.overlay0 })
    vim.api.nvim_set_hl(0, 'HopNextKey', { bg = 'NONE', fg = C.yellow, bold=true })
    vim.api.nvim_set_hl(0, 'HopNextKey1', { bg = 'NONE', fg = C.teal, bold=true })
    vim.api.nvim_set_hl(0, 'HopNextKey2', { bg = 'NONE', fg = C.marine })
    vim.api.nvim_set_hl(0, 'TSNodeKey', { bg = 'NONE', fg = C.yellow, bold=true })
  end
}
