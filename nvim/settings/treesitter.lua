-- Configure Treesitter
local setup, treesitter = pcall(require, "nvim-treesitter.configs")
if not setup then return end

treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "javascript", "typescript", "lua", "vim", "vimdoc", "query",
    "html", "css", "json", "yaml", "markdown", "go", "bash",
    "python", "c", "cpp", "rust", "java", "kotlin"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true
  },

  -- Incremental selection based on the named nodes from the grammar
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- Enable folding with treesitter
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim-treesitter#foldexpr()'
-- Don't fold by default when opening a file
vim.wo.foldenable = false 