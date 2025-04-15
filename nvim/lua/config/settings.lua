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
vim.opt.lazyredraw = true          -- only redraw when necessary
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
vim.opt.fillchars:append({ vert = "│" })
vim.cmd("hi! link VertSplit Conceal")

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
]])

-- Mappings
-- disable Ex-only mapping
vim.keymap.set('n', 'Q', '<nop>')

-- bind K to grep word under cursor
vim.keymap.set('n', 'K', ':grep! "\\b<C-R><C-W>\\b"<CR>:cw<CR>')

-- FZF
-- vim.keymap.set('n', '<C-P>', ':FzfLua files<CR>', { silent = true })
-- vim.keymap.set('n', '<C-F>', ':FzfLua live_grep<CR>', { silent = true })

-- Easy enthium split navigation
vim.keymap.set('n', '<leader>i', '<C-W><C-J>', { silent = true })
vim.keymap.set('n', '<leader>e', '<C-W><C-K>', { silent = true })
vim.keymap.set('n', '<leader>c', '<C-W><C-L>', { silent = true })
vim.keymap.set('n', '<leader>a', '<C-W><C-H>', { silent = true })

-- Provide easier tab navigation
vim.keymap.set('', '<F6>', ':tabn<kEnter>', { silent = true })
vim.keymap.set('', '<F5>', ':tabp<kEnter>', { silent = true })
vim.keymap.set('', '<End>', ':tabn<kEnter>', { silent = true })
vim.keymap.set('', '<Home>', ':tabp<kEnter>', { silent = true })

-- Increment / Decrement numbers
vim.keymap.set('n', '-', '<C-x>', { silent = true })
vim.keymap.set('n', '+', '<C-a>', { silent = true })

-- Show syntax information under cursor
vim.keymap.set('', '<F10>', [[:echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]])

-- Center text on screen
vim.keymap.set('n', '<space>', 'zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- nvim specific config
if vim.fn.has('nvim') == 1 then
  vim.g.python2_host_prog = '/usr/local/bin/python'
  vim.g.python3_host_prog = '/usr/bin/python3'
  vim.env.NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
end

-- Create undodir if it doesn't exist
local undodir = vim.fn.expand("~/.config/nvim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end
vim.opt.undodir = undodir
vim.opt.undofile = true 
