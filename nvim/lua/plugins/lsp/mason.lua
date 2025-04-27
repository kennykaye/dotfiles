return {
  'williamboman/mason.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')
    local mason_tool_installer = require('mason-tool-installer')

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      automatic_installation = true,
      ensure_installed = {
        'pyright',
        'lua_ls',
        'emmet_ls',
        'gopls',
        'kotlin_language_server',
      },

      -- Hack to bridge neovim 0.11.0+ apis with mason_lspconfig
      -- @see https://github.com/williamboman/mason-lspconfig.nvim/issues/534
      handlers = {
        -- default setup for all LSP servers
        function(server_name)
          -- Global LSP configuration
          vim.lsp.config( server_name, {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            root_markers = { '.git' },
          })
          vim.lsp.enable(server_name)
        end,

        ['lua_ls'] = function()
          vim.lsp.config('lua_ls', {
            cmd = { 'lua-language-server' },
            filetypes = { 'lua' },
            root_markers = {
              '.luarc.json',
              '.luarc.jsonc',
              '.luacheckrc',
              '.stylua.toml',
              'stylua.toml',
              'selene.toml',
              'selene.yml',
              '.git',
            },
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            settings = {
              Lua = {
                runtime = {
                  version = 'LuaJIT'
                },
                diagnostics = {
                  globals = { 'vim' },
                  disable = { 'missing-fields' },
                }
              }
            }
          })
          vim.lsp.enable('lua_ls')
        end,
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        'prettier', -- prettier formatter
        'stylua', -- lua formatter
        'isort', -- python formatter
        'black', -- python formatter
        'pylint',
        'eslint_d',
        'detekt',
      },
    })
  end,
}
