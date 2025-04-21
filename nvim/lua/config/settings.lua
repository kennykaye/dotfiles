-- General settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.timeoutlen = 700
vim.opt.ttimeoutlen = 0
vim.opt.wildmenu = true            -- visual autocomplete for command menu
vim.opt.exrc = true                -- load project-specific vimrc's
vim.opt.secure = true              -- limit the capability of those vimrc's
vim.opt.laststatus = 2
vim.opt.swapfile = false
vim.opt.termguicolors = true       -- set gui colors for vim and nvim
vim.opt.backspace = "indent,eol,start" -- backspace through lines
vim.opt.clipboard = "unnamed"      -- tmux and system copy/paste
vim.opt.number = true              -- show current line numbers
vim.opt.cursorline = true          -- highlight current line
vim.opt.showmode = false           -- hide mode since we use lualine
vim.opt.visualbell = true          -- disable error bell
vim.opt.scrolloff = 5              -- set minimum number of lines above/below cursor
vim.opt.sidescroll = 1             -- enable horizontal scrolling
vim.opt.sidescrolloff = 1          -- horizontal scrolling is offset by '>'
vim.opt.wrap = false               -- disable autowrapping
vim.opt.autoread = true            -- automatically re-read changed files
vim.opt.mouse = "a"                -- enable mouse scrolling
vim.opt.completeopt:remove("preview") -- disable preview scratch buffer
vim.opt.splitbelow = true          -- open new split below current split
vim.opt.splitright = true          -- open new split to the right
vim.opt.nrformats:append("alpha")  -- Allow integers to be incremented/decremented
vim.opt.hlsearch = false           -- Prevent search results from being highlighted
vim.opt.colorcolumn = "101"        -- Highlight column
vim.opt.backupcopy = "yes"
vim.opt.listchars:append({ extends = "…", precedes = "…" })

-- Appearance settings
vim.cmd("syntax on")               -- enable syntax highlighting
vim.cmd("syntax sync minlines=200")
vim.opt.fillchars:append({ vert = "│"})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--   vim.opt.background = "dark"      -- set dark background

-- Commands
vim.cmd([[
  " General Commands
  :command! Q q
  :command! Qa qa
  :command! W w
  :command! Wa wa
  :command! WQ wq
  :command! Wq wq
  :command! Wqa wqa
  :command! Vimrc :tabe ~/.vimrc
  :command! Source so ~/.vimrc
  :command! Path :echo expand('%:p')

  " Create a new file in the same directory as the current file
  " new tab
  :command! -nargs=+ -complete=file -bar OT :tabe %:p:h/<args>
  " vertical split
  :command! -nargs=+ -complete=file -bar OV :vnew %:p:h/<args>
  " horizontal split
  :command! -nargs=+ -complete=file -bar OS :new %:p:h/<args>

  " Delete single line, or a range of lines and jump back to previous position
  :command! -range -nargs=0 D <line1>,<line2>d|norm ``

  " Format JSON Documents
  :command! FormatJSON set ft=json | %!python -m json.tool

  " Format XML Documents
  :command! FormatXML set ft=xml | %!xmllint --format %

  " Replace the current buffer with a new buffer
  function! ReplaceBuffer(bang, newfile)
    let curbuf = bufnr('%')
    exec "e %:p:h/" . a:newfile
    exec "bd" . a:bang . " " . curbuf
  endfunction
  :command! -nargs=1 -complete=file -bang -bar BDE call ReplaceBuffer('<bang>', <f-args>)

  " let g:gitgutter_sign_removed_first_line = "^_"
  " let g:gitgutter_sign_added = '∙'
  " let g:gitgutter_sign_modified = '∙'
  " let g:gitgutter_sign_removed = '∙'
  " let g:gitgutter_sign_modified_removed = '∙'
  let g:gitgutter_sign_removed_first_line = "^_"
  let g:gitgutter_sign_added = '▏'
  let g:gitgutter_sign_modified = '▏'
  let g:gitgutter_sign_removed = '▏'
  let g:gitgutter_sign_modified_removed = '▏'
]])


local keymap = vim.keymap -- for conciseness
-- Mappings
-- disable Ex-only mapping
keymap.set('n', 'Q', '<nop>')

-- diagnostic
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(_)
    keymap.set("n", "<leader>d", vim.diagnostic.open_float) -- show diagnostics for line
    keymap.set("n", "K", vim.lsp.buf.hover) -- show documentation for what is under cursor
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

-- Easy enthium split navigation
keymap.set('n', '<leader>i', '<C-W><C-J>', { silent = true })
keymap.set('n', '<leader>e', '<C-W><C-K>', { silent = true })
keymap.set('n', '<leader>c', '<C-W><C-L>', { silent = true })
keymap.set('n', '<leader>a', '<C-W><C-H>', { silent = true })

-- Provide easier tab navigation
keymap.set('', '<F6>', ':tabn<kEnter>', { silent = true })
keymap.set('', '<F5>', ':tabp<kEnter>', { silent = true })
keymap.set('', '<End>', ':tabn<kEnter>', { silent = true })
keymap.set('', '<Home>', ':tabp<kEnter>', { silent = true })

-- Increment / Decrement numbers
keymap.set('n', '-', '<C-x>', { silent = true })
keymap.set('n', '+', '<C-a>', { silent = true })

-- Show syntax information under cursor
keymap.set('', '<F10>', [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]])

-- Center text on screen
keymap.set('n', '<space>', 'zz')
keymap.set('n', 'n', 'nzz')
keymap.set('n', 'N', 'Nzz')

-- nvim specific config
if vim.fn.has('nvim') == 1 then
  vim.g.python2_host_prog = '/usr/local/bin/python'
  vim.g.python3_host_prog = '/usr/bin/python3'
  vim.env.NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
end

