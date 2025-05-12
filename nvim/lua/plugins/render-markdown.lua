return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  enabled = true,
  ft = { "markdown", "Avante" },
  opts = {},
  config = function ()

    local C = require('utils.colors')
    vim.api.nvim_set_hl(0, 'RenderMarkdownCode',       { fg = 'NONE', bg = C.mantle })
    vim.api.nvim_set_hl(0, 'RenderMarkdownCodeBorder', { fg = C.overlay0, bg = C.mantle })

    require('render-markdown').setup({
      file_types = { "markdown", "Avante" },
      completions = {
        blink = {
          enabled = true
        }
      },
      code = {
        border = 'thin',
        language_name = false,
        inline_pad = 1,
      },
    })
  end
}
