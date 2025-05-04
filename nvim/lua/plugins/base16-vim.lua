return {
  "RRethy/base16-nvim",
  priority = 1000,
  lazy = false,
  config = function()
    vim.cmd('colorscheme base16-eighties')

    local C = require('utils.colors')
    local hl = function (hlgroup, highlight)
      vim.api.nvim_set_hl(0, hlgroup, highlight)
    end

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
    hl('VertSplit',    { fg = C.mantle,   bg = 'NONE' })
    hl('WinSeparator', { fg = C.mantle,   bg = 'NONE' })
    hl('LineNr',       { fg = C.overlay0, bg = 'NONE' })
    hl('CursorLineNr', { fg = C.text,     bg = 'NONE' })
    hl('ColorColumn',  { fg = C.text,     bg = C.base })
    hl('CursorLine',   { bg = C.surface0 })

    -- Tabs
    hl('TabLine',                    { fg = C.surface2, bg = C.base })
    hl('TabLineFill',                { bg = C.base })
    hl('TabLineIndex',               { fg = C.surface2, bg = C.base })
    hl('TabLineSelected',            { fg = C.eggshell, bg = C.base, bold = true })
    hl('TabLineSelectedIndex',       { fg = C.overlay1, bg = C.base })
    hl('TabLineSeparator',           { fg = C.surface0, bg = C.base })
    hl('TabLineBreadcrumb',          { fg = C.overlay0, bg = C.base })
    hl('TabLineBreadcrumbSeparator', { fg = C.surface2, bg = C.base })

    -- Float
    hl('NormalFloat',               { bg = C.surface0 })
    hl('FloatTitle',                { fg = C.yellow })
    hl('FloatBorder',               { fg = C.gray, bg = C.base })
    --
    -- Picker
    hl('SnacksNormal',              { bg = C.base })
    hl('SnacksPicker',              { bg = C.base })
    hl('SnacksNormalNC',            { bg = C.base })
    hl('SnacksPickerBox',           { bg = C.base })
    hl('SnacksPickerList',          { bg = C.base })
    hl('SnacksPickerInput',         { bg = C.base })
    hl('SnacksPickerPreview',       { bg = C.base })
    hl('SnacksPickerPrompt',        { fg = C.red })
    hl('SnacksPickerMatch',         { fg = C.yellow })
    hl('SnacksPickerTree',          { fg = C.surface0 })
    hl('SnacksPickerRow',           { fg = C.overlay1 })
    hl('SnacksPickerColumn',        { fg = C.overlay1 })
    hl('SnacksPickerDelim',         { fg = C.overlay1 })
    hl('SnacksPickerBorder',        { fg = C.overlay1 })
    hl('SnacksPickerBoxBorder',     { fg = C.overlay1 })
    hl('SnacksPickerListBorder',    { fg = C.overlay1 })
    hl('SnacksPickerInputBorder',   { fg = C.overlay1 })
    hl('SnacksPickerPreviewBorder', { fg = C.overlay1 })

    -- Notfiy
    hl('SnacksNotifierIconInfo',    { fg = C.sky })
    hl('SnacksNotifierTitleInfo',   { fg = C.sky })
    hl('SnacksNotifierIconWarn',    { fg = C.yellow })
    hl('SnacksNotifierTitleWarn',   { fg = C.yellow })
    hl('SnacksNotifierBorderWarn',  { fg = C.overlay1 })
    hl('SnacksNotifierFooterWarn',  { fg = C.overlay1 })
    hl('SnacksNotifierBorderInfo',  { fg = C.overlay1 })
    hl('SnacksNotifierFooterInfo',  { fg = C.overlay1 })
    hl('SnacksNotifierBorderError', { fg = C.overlay1 })
    hl('SnacksNotifierFooterError', { fg = C.overlay1 })

    -- Noice
    hl('NoicePopup',                    { bg = C.surface0 })
    hl('NoiceSplit',                    { bg = C.surface0 })
    hl('DapUIFloatNormal',              { bg = C.surface0 })
    hl('NoiceVirtualText',              { fg = C.yellow })
    hl('NoiceCmdlinePopup',             { bg = C.base })
    hl('NoiceCmdlineIcon',              { fg = C.teal })
    hl('NoiceCmdlinePopupTitleCmdline', { fg = C.teal })
    hl('NoiceCmdlinePopupBorder',       { fg = C.overlay1 })
    hl('NoiceCmdlinePopupBorderSearch', { fg = C.overlay1 })
    hl('NoiceCmdlinePopupTitleSearch',  { fg = C.yellow })

    -- Indent
    hl('SnacksIndent',      { fg = C.surface0 })
    hl('SnacksIndentScope', { fg = C.surface1 })

    -- Diagnostics
    hl('DiagnosticWarn',            { fg = C.yellow })
    hl('DiagnosticFloatinghlnt',    { fg = C.subtext0 })
    hl('DiagnosticVirtualTexthlnt', { fg = C.subtext0 })
    hl('DiagnosticSignhlnt',        { fg = C.subtext0 })

    -- Treesitter
    hl('TSVariable',    { fg = C.text })
    hl('TSFuncBuiltin', { fg = C.yellow })
    hl('TSTitle',       { fg = C.yellow })
    hl('TSURI',         { fg = C.blue, bg = 'NONE' })

    -- PMenu
    hl('PMenu',         { fg = "NONE", bg = C.surface0 })
    hl('PMenuSel',      { fg = "NONE", bg = C.surface2, bold = true })
    hl('PmenuKind',     { fg = "NONE" })
    hl('PmenuKindSel',  { fg = "NONE", bg = C.surface2 })
    hl('PmenuExtraSel', { fg = "NONE", bg = C.surface2 })
    hl('PMenuThumb',    { fg = C.base, bg = C.surface1 })

    -- LSP and autocomplete
    hl('BlinkCmpDoc',                          { fg = 'NONE',     bg = C.surface0 })
    hl('BlinkCmpDocBorder',                    { fg = 'NONE',     bg = C.surface0 })
    hl('BlinkCmpKindEnum',                     { fg = C.yellow,   bg = 'NONE' })
    hl('BlinkCmpKindFile',                     { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindText',                     { fg = C.sky,      bg = 'NONE' })
    hl('BlinkCmpKindUnit',                     { fg = C.eggshell, bg = 'NONE' })
    hl('BlinkCmpKindClass',                    { fg = C.yellow,   bg = 'NONE' })
    hl('BlinkCmpKindColor',                    { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindEvent',                    { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindField',                    { fg = C.green,    bg = 'NONE' })
    hl('BlinkCmpKindValue',                    { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindFolder',                   { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindMethod',                   { fg = C.mauve,    bg = 'NONE' })
    hl('BlinkCmpKindModule',                   { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindStruct',                   { fg = C.yellow,   bg = 'NONE' })
    hl('BlinkCmpKindKeyword',                  { fg = C.eggshell, bg = 'NONE' })
    hl('BlinkCmpKindSnippet',                  { fg = C.subtext0, bg = 'NONE' })
    hl('BlinkCmpKindCopilot',                  { fg = C.teal,      bg = 'NONE' })
    hl('BlinkCmpKindConstant',                 { fg = C.flamingo, bg = 'NONE' })
    hl('BlinkCmpKindFunction',                 { fg = C.mauve,    bg = 'NONE' })
    hl('BlinkCmpKindOperator',                 { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindProperty',                 { fg = C.eggshell, bg = 'NONE' })
    hl('BlinkCmpKindVariable',                 { fg = C.sky,      bg = 'NONE' })
    hl('BlinkCmpKindInterface',                { fg = C.sky,      bg = 'NONE' })
    hl('BlinkCmpKindReference',                { fg = C.teal,     bg = 'NONE' })
    hl('BlinkCmpKindEnumMember',               { fg = C.green,    bg = 'NONE' })
    hl('BlinkCmpKindConstructor',              { fg = C.yellow,   bg = 'NONE' })
    hl('BlinkCmpKindTypeParameter',            { fg = C.text,     bg = 'NONE' })
    hl('BlinkCmpSignatureHelpActiveParameter', { fg = C.text,     bg = 'NONE' })
    hl('BlinkCmpLabelDeprecated',              { fg=C.overlay2,   bg = 'NONE', strikethrough=true })

    -- Hop and search
    hl('IncSearch',    { bg = C.yellow, fg = C.base })
    hl('TSNodeKey',    { bg = 'NONE',   fg = C.yellow, bold=true })
    hl('HopNextKey',   { bg = 'NONE',   fg = C.yellow, bold=true })
    hl('HopNextKey1',  { bg = 'NONE',   fg = C.teal,   bold=true })
    hl('HopNextKey2',  { bg = 'NONE',   fg = C.marine })
    hl('HopUnmatched', { bg = 'NONE',   fg = C.overlay0 })

    -- Multi cursor
    hl("MultiCursorCursor",         { link = "Visual" })
    hl("MultiCursorVisual",         { link = "Visual" })
    hl("MultiCursorSign",           { link = "SignColumn"})
    hl("MultiCursorMatchPreview",   { link = "Search" })
    hl("MultiCursorDisabledVisual", { link = "Visual" })
    hl("MultiCursorDisabledSign",   { link = "SignColumn"})
    hl("MultiCursorDisabledCursor", { reverse = true })

    -- Markdown
    hl("@markup.quote.markdown",             { bg = C.base,     fg = C.overlay1 })
    hl("@markup.raw.block.markdown",         { bg = C.surface0, fg = C.text })
    hl("@label.markdown",                    { bg = C.surface0, fg = C.subtext0 })
    hl("@markup.link.label.markdown_inline", { bg = C.surface0, fg = C.blue, underline = true })

    -- Which Key
    hl("WhichKey", { bg = 'NONE', fg = C.yellow })
    hl("WhichKeyDesc", { bg = 'NONE', fg = C.subtext0 })
    hl("WhichKeyGroup", { bg = 'NONE', fg = C.overlay1 })

  end
}
