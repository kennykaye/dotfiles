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

-- Other
map('x', 'ga', '<Plug>(EasyAlign)', { desc = "EasyAlign" })
map('n', 'ga', '<Plug>(EasyAlign)', { desc = "EasyAlign" })
map('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = 'Toggle Undo Tree' })
map("n", "<Leader>cc", function() require("menu").open("default") end, { desc = "Show context Menu"})

-- diagnostic
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(_)
    map("n", "<leader>d",  vim.diagnostic.open_float, { desc = "Show diagnostics for line" })
    map("n", "K",          vim.lsp.buf.hover,         { desc = "Show documentation for what is under cursor" })
    map("n", "<leader>rn", vim.lsp.buf.rename,        { desc = "Smart rename" })
    map("n", "<leader>ca", vim.lsp.buf.code_action,   { desc = "See available code actions" })
    map("n", "<leader>rs", ":LspRestart<CR>",         { desc = "Restart LSP" })

    -- map.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
    -- map.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  end,
})
