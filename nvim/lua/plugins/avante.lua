return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = "claude",
        windows = {
            width = 33,
            height = 33,
            position = "right",
            input = {
                prefix = "❯ ",
            },
            edit = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                start_insert = false, -- Start insert mode when opening the edit window
            },
        },
        hints = {
            enabled = false,
        },

        selector = {
            provider = "snacks",
        },
    },
    build = "make",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'zbirenbaum/copilot.lua',
        'MeanderingProgrammer/render-markdown.nvim',
    },
}
