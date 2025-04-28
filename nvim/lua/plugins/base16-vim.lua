return {
  "RRethy/base16-nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme base16-eighties')

    local C = require('utils.colors')
    local hl = vim.api.nvim_set_hl

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
    hl(0, 'VertSplit',    { fg = C.mantle,   bg = 'NONE' })
    hl(0, 'WinSeparator', { fg = C.mantle,   bg = 'NONE' })
    hl(0, 'LineNr',       { fg = C.overlay0, bg = 'NONE' })
    hl(0, 'CursorLineNr', { fg = C.text,     bg = 'NONE' })
    hl(0, 'ColorColumn',  { fg = C.text,     bg = C.base })
    hl(0, 'CursorLine',   { bg = C.surface0 })

    -- Tabs 
    hl(0, 'TabLine',                    { fg = C.surface2, bg = C.base })
    hl(0, 'TabLineFill',                { bg = C.base })
    hl(0, 'TabLineIndex',               { fg = C.surface2, bg = C.base })
    hl(0, 'TabLineSelected',            { fg = C.eggshell, bg = C.base, bold = true })
    hl(0, 'TabLineSelectedIndex',       { fg = C.overlay1, bg = C.base })
    hl(0, 'TabLineSeparator',           { fg = C.surface0, bg = C.base })
    hl(0, 'TabLineBreadcrumb',          { fg = C.overlay0, bg = C.base })
    hl(0, 'TabLineBreadcrumbSeparator', { fg = C.surface2, bg = C.base })

    -- Float 
    hl(0, 'NormalFloat',               { bg = C.surface0 })
    hl(0, 'FloatTitle',                { fg = C.yellow })
    hl(0, 'FloatBorder',               { fg = C.gray, bg = C.base })
    --
    -- Picker 
    hl(0, 'SnacksNormal',              { bg = C.base })
    hl(0, 'SnacksPicker',              { bg = C.base })
    hl(0, 'SnacksNormalNC',            { bg = C.base })
    hl(0, 'SnacksPickerBox',           { bg = C.base })
    hl(0, 'SnacksPickerList',          { bg = C.base })
    hl(0, 'SnacksPickerInput',         { bg = C.base })
    hl(0, 'SnacksPickerPreview',       { bg = C.base })
    hl(0, 'SnacksPickerPrompt',        { fg = C.red })
    hl(0, 'SnacksPickerMatch',         { fg = C.yellow })
    hl(0, 'SnacksPickerTree',          { fg = C.surface0 })
    hl(0, 'SnacksPickerRow',           { fg = C.overlay1 })
    hl(0, 'SnacksPickerColumn',        { fg = C.overlay1 })
    hl(0, 'SnacksPickerDelim',         { fg = C.overlay1 })
    hl(0, 'SnacksPickerBorder',        { fg = C.overlay1 })
    hl(0, 'SnacksPickerBoxBorder',     { fg = C.overlay1 })
    hl(0, 'SnacksPickerListBorder',    { fg = C.overlay1 })
    hl(0, 'SnacksPickerInputBorder',   { fg = C.overlay1 })
    hl(0, 'SnacksPickerPreviewBorder', { fg = C.overlay1 })

    -- Notfiy 
    hl(0, 'SnacksNotifierIconInfo',    { fg = C.sky })
    hl(0, 'SnacksNotifierTitleInfo',   { fg = C.sky })
    hl(0, 'SnacksNotifierIconWarn',    { fg = C.yellow })
    hl(0, 'SnacksNotifierTitleWarn',   { fg = C.yellow })
    hl(0, 'SnacksNotifierBorderWarn',  { fg = C.overlay1 })
    hl(0, 'SnacksNotifierFooterWarn',  { fg = C.overlay1 })
    hl(0, 'SnacksNotifierBorderInfo',  { fg = C.overlay1 })
    hl(0, 'SnacksNotifierFooterInfo',  { fg = C.overlay1 })
    hl(0, 'SnacksNotifierBorderError', { fg = C.overlay1 })
    hl(0, 'SnacksNotifierFooterError', { fg = C.overlay1 })

    -- Noice
    hl(0, 'NoicePopup',                    { bg = C.surface0 })
    hl(0, 'NoiceSplit',                    { bg = C.surface0 })
    hl(0, 'DapUIFloatNormal',              { bg = C.surface0 })
    hl(0, 'NoiceVirtualText',              { fg = C.yellow })
    hl(0, 'NoiceCmdlinePopup',             { bg = C.base })
    hl(0, 'NoiceCmdlineIcon',              { fg = C.teal })
    hl(0, 'NoiceCmdlinePopupTitleCmdline', { fg = C.teal })
    hl(0, 'NoiceCmdlinePopupBorder',       { fg = C.overlay1 })
    hl(0, 'NoiceCmdlinePopupBorderSearch', { fg = C.overlay1 })
    hl(0, 'NoiceCmdlinePopupTitleSearch',  { fg = C.yellow })

    -- Indent 
    hl(0, 'SnacksIndent',      { fg = C.surface0 })
    hl(0, 'SnacksIndentScope', { fg = C.surface1 })

    -- Diagnostics
    hl(0, 'DiagnosticWarn',            { fg = C.yellow })
    hl(0, 'DiagnosticFloatinghlnt',    { fg = C.subtext0 })
    hl(0, 'DiagnosticVirtualTexthlnt', { fg = C.subtext0 })
    hl(0, 'DiagnosticSignhlnt',        { fg = C.subtext0 })

    -- Treesitter
    hl(0, 'TSVariable',    { fg = C.text })
    hl(0, 'TSFuncBuiltin', { fg = C.yellow })
    hl(0, 'TSTitle',       { fg = C.yellow })
    hl(0, 'TSURI',         { fg = C.blue, bg = 'NONE' })

    -- PMenu 
    hl(0, 'PMenu',         { fg = "NONE", bg = C.surface0 })
    hl(0, 'PMenuSel',      { fg = "NONE", bg = C.surface2, bold = true })
    hl(0, 'PmenuKind',     { fg = "NONE" })
    hl(0, 'PmenuKindSel',  { fg = "NONE", bg = C.surface2 })
    hl(0, 'PmenuExtraSel', { fg = "NONE", bg = C.surface2 })
    hl(0, 'PMenuThumb',    { fg = C.base, bg = C.surface1 })

    -- LSP and autocomplete
    hl(0, 'BlinkCmpDoc',                          { fg = 'NONE',     bg = C.surface0 })
    hl(0, 'BlinkCmpDocBorder',                    { fg = 'NONE',     bg = C.surface0 })
    hl(0, 'BlinkCmpKindEnum',                     { fg = C.yellow,   bg = 'NONE' })
    hl(0, 'BlinkCmpKindFile',                     { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindText',                     { fg = C.sky,      bg = 'NONE' })
    hl(0, 'BlinkCmpKindUnit',                     { fg = C.eggshell, bg = 'NONE' })
    hl(0, 'BlinkCmpKindClass',                    { fg = C.yellow,   bg = 'NONE' })
    hl(0, 'BlinkCmpKindColor',                    { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindEvent',                    { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindField',                    { fg = C.green,    bg = 'NONE' })
    hl(0, 'BlinkCmpKindValue',                    { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindFolder',                   { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindMethod',                   { fg = C.mauve,    bg = 'NONE' })
    hl(0, 'BlinkCmpKindModule',                   { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindStruct',                   { fg = C.yellow,   bg = 'NONE' })
    hl(0, 'BlinkCmpKindKeyword',                  { fg = C.eggshell, bg = 'NONE' })
    hl(0, 'BlinkCmpKindSnippet',                  { fg = C.subtext0, bg = 'NONE' })
    hl(0, 'BlinkCmpKindConstant',                 { fg = C.flamingo, bg = 'NONE' })
    hl(0, 'BlinkCmpKindFunction',                 { fg = C.mauve,    bg = 'NONE' })
    hl(0, 'BlinkCmpKindOperator',                 { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindProperty',                 { fg = C.eggshell, bg = 'NONE' })
    hl(0, 'BlinkCmpKindVariable',                 { fg = C.sky,      bg = 'NONE' })
    hl(0, 'BlinkCmpKindInterface',                { fg = C.sky,      bg = 'NONE' })
    hl(0, 'BlinkCmpKindReference',                { fg = C.teal,     bg = 'NONE' })
    hl(0, 'BlinkCmpKindEnumMember',               { fg = C.green,    bg = 'NONE' })
    hl(0, 'BlinkCmpKindConstructor',              { fg = C.yellow,   bg = 'NONE' })
    hl(0, 'BlinkCmpKindTypeParameter',            { fg = C.text,     bg = 'NONE' })
    hl(0, 'BlinkCmpSignatureHelpActiveParameter', { fg = C.text,     bg = 'NONE' })
    hl(0, 'BlinkCmpLabelDeprecated',              { fg=C.overlay2,   bg = 'NONE', strikethrough=true })

    -- Hop and search
    hl(0, 'IncSearch',    { bg = C.yellow, fg = C.base })
    hl(0, 'TSNodeKey',    { bg = 'NONE',   fg = C.yellow, bold=true })
    hl(0, 'HopNextKey',   { bg = 'NONE',   fg = C.yellow, bold=true })
    hl(0, 'HopNextKey1',  { bg = 'NONE',   fg = C.teal,   bold=true })
    hl(0, 'HopNextKey2',  { bg = 'NONE',   fg = C.marine })
    hl(0, 'HopUnmatched', { bg = 'NONE',   fg = C.overlay0 })

    -- Multi cursor
    hl(0, "MultiCursorCursor",         { link = "Visual" })
    hl(0, "MultiCursorVisual",         { link = "Visual" })
    hl(0, "MultiCursorSign",           { link = "SignColumn"})
    hl(0, "MultiCursorMatchPreview",   { link = "Search" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign",   { link = "SignColumn"})
    hl(0, "MultiCursorDisabledCursor", { reverse = true })

    -- Markdown
    hl(0, "@markup.quote.markdown",             { bg = C.base,     fg = C.overlay1 })
    hl(0, "@markup.raw.block.markdown",         { bg = C.surface0, fg = C.text })
    hl(0, "@label.markdown",                    { bg = C.surface0, fg = C.subtext0 })
    hl(0, "@markup.link.label.markdown_inline", { bg = C.surface0, fg = C.blue, underline = true })

  end
}
