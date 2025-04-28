return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  enabled = false,
  ft = "markdown",
  opts = {},
  config = function ()
    require('render-markdown').setup({
      completions = { blink = { enabled = true } },

      vim.keymap.set('n', '<leader>m', '<cmd>RenderMarkdown toggle', { desc = 'Toggle RenderMarkdown' })
    })
  end
}
