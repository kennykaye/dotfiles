return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "saghen/blink.cmp"
    },
    config = function ()
        -- Markdown
        local C = require('utils.colors')
        local hl = vim.api.nvim_set_hl

        hl(0, 'MarkviewCode',         { fg='NONE',   bg=C.surface0 })
        hl(0, 'MarkviewInlineCode',   { fg='NONE',   bg=C.surface0 })
        hl(0, 'MarkviewPalette0',     { fg=C.blue,  bg=C.base })
        hl(0, 'MarkviewPalette0Fg',   { fg=C.blue,  bg='NONE', })
        hl(0, 'MarkviewPalette0Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette0Sign', { fg=C.blue,  bg='NONE', })
        hl(0, 'MarkviewPalette1',     { fg=C.red,    bg=C.base })
        hl(0, 'MarkviewPalette1Fg',   { fg=C.red,    bg='NONE', })
        hl(0, 'MarkviewPalette1Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette1Sign', { fg=C.red,    bg='NONE', })
        hl(0, 'MarkviewPalette2',     { fg=C.orange, bg=C.base })
        hl(0, 'MarkviewPalette2Fg',   { fg=C.orange, bg='NONE', })
        hl(0, 'MarkviewPalette2Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette2Sign', { fg=C.orange, bg='NONE', })
        hl(0, 'MarkviewPalette3',     { fg=C.yellow, bg=C.base })
        hl(0, 'MarkviewPalette3Fg',   { fg=C.yellow, bg='NONE', })
        hl(0, 'MarkviewPalette3Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette3Sign', { fg=C.yellow, bg='NONE', })
        hl(0, 'MarkviewPalette4',     { fg=C.green,  bg=C.base })
        hl(0, 'MarkviewPalette4Fg',   { fg=C.green,  bg='NONE', })
        hl(0, 'MarkviewPalette4Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette4Sign', { fg=C.green,  bg='NONE', })
        hl(0, 'MarkviewPalette5',     { fg=C.teal,   bg=C.base })
        hl(0, 'MarkviewPalette5Fg',   { fg=C.teal,   bg='NONE', })
        hl(0, 'MarkviewPalette5Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette5Sign', { fg=C.teal,   bg='NONE', })
        hl(0, 'MarkviewPalette6',     { fg=C.mauve,   bg=C.base })
        hl(0, 'MarkviewPalette6Fg',   { fg=C.mauve,   bg='NONE', })
        hl(0, 'MarkviewPalette6Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette6Sign', { fg=C.mauve,   bg='NONE', })
        hl(0, 'MarkviewPalette7',     { fg=C.brown,  bg=C.base })
        hl(0, 'MarkviewPalette7Fg',   { fg=C.brown,  bg='NONE', })
        hl(0, 'MarkviewPalette7Bg',   { fg='NONE',   bg=C.base })
        hl(0, 'MarkviewPalette7Sign', { fg=C.brown,  bg='NONE', })

        hl(0, 'MarkviewHeading1Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading2Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading3Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading5Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading6Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'Markviewheading4Sign', { fg=C.text, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading1', { fg=C.yellow, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading2', { fg=C.yellow, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading3', { fg=C.yellow, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading5', { fg=C.yellow, bg = 'NONE', bold = true })
        hl(0, 'MarkviewHeading6', { fg=C.yellow, bg = 'NONE', bold = true })
        hl(0, 'Markviewheading4', { fg=C.yellow, bg = 'NONE', bold = true })

        hl(0, 'MarkviewHyperlink', { fg=C.blue, bg = 'NONE', underline = true })

        hl(0, 'MarkviewListItemPlus', { fg=C.surface2, bg = 'NONE' })
        hl(0, 'MarkviewListItemStar', { fg=C.surface2, bg = 'NONE' })
        hl(0, 'MarkviewListItemMinus', { fg=C.surface2, bg = 'NONE' })

        hl(0, 'MarkviewTableHeader', { fg=C.overlay1, bg = 'NONE' })
        hl(0, 'MarkviewTableBorder', { fg=C.overlay1, bg = 'NONE' })
    end
};
