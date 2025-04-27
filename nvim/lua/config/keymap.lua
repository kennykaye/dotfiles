local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.timeoutlen = 250

-- Tab Navigation (M-S-#)
map('n', '<M-!>', '1gt', { silent = true, desc = "Go to tab 1" })
map('n', '<M-@>', '2gt', { silent = true, desc = "Go to tab 2" })
map('n', '<M-#>', '3gt', { silent = true, desc = "Go to tab 3" })
map('n', '<M-$>', '4gt', { silent = true, desc = "Go to tab 4" })
map('n', '<M-%>', '5gt', { silent = true, desc = "Go to tab 5" })
map('n', '<M-^>', '6gt', { silent = true, desc = "Go to tab 6" })
map('n', '<M-&>', '7gt', { silent = true, desc = "Go to tab 7" })
map('n', '<M-*>', '8gt', { silent = true, desc = "Go to tab 8" })
map('n', '<M-(>', '9gt', { silent = true, desc = "Go to tab 9" })

-- Search
map("n", "n", "nzzzv", { desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { desc = "Back search '/' or '?'" })

-- Undo
map('n', '<leader>u', vim.cmd.UndotreeToggle)

-- easyalign
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')

-- diagnostic
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(_)
    map("n", "<leader>d", vim.diagnostic.open_float) -- show diagnostics for line
    map("n", "K", vim.lsp.buf.hover) -- show documentation for what is under cursor
    -- keymap.set("n", "gD", vim.lsp.buf.declaration) -- go to declaration

    -- opts.desc = "Show LSP references"
    -- keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    -- opts.desc = "Go to declaration"

    -- opts.desc = "Show LSP definitions"
    -- keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    -- opts.desc = "Show LSP implementations"
    -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    -- opts.desc = "Show LSP type definitions"
    -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    -- opts.desc = "See available code actions"
    -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    -- opts.desc = "Smart rename"
    -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    -- opts.desc = "Show line diagnostics"

    -- opts.desc = "Go to previous diagnostic"
    -- keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    -- -- opts.desc = "Go to next diagnostic"
    -- keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    -- opts.desc = "Show documentation for what is under cursor"

    -- opts.desc = "Restart LSP"
    -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

  end,
})
