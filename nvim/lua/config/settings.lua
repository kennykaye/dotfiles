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
vim.opt.colorcolumn = "101"        -- Highlight column
vim.opt.backupcopy = "yes"
vim.opt.listchars:append({ extends = "…", precedes = "…" })

vim.g.python2_host_prog = '/usr/local/bin/python'
vim.g.python3_host_prog = '/usr/bin/python3'

-- Appearance settings
vim.cmd("syntax on")               -- enable syntax highlighting
vim.cmd("syntax sync minlines=200")
vim.opt.fillchars:append({ vert = "│"})

-- Commands
local function create_cmd(name, cmd, opts)
  opts = opts or {}
  opts.force = true
  vim.api.nvim_create_user_command(name, cmd, opts)
end

-- General Commands
create_cmd('Q', 'q')
create_cmd('Qa', 'qa')
create_cmd('W', 'w')
create_cmd('Wa', 'wa')
create_cmd('WQ', 'wq')
create_cmd('Wq', 'wq')
create_cmd('Wqa', 'wqa')
create_cmd('Vimrc', 'tabe ' .. vim.fn.expand('~/.vimrc'))
create_cmd('Source', 'so ' .. vim.fn.expand('~/.vimrc'))
create_cmd('Path', 'echo expand("%:p")')

-- Create a new file in the same directory as the current file
local function create_file_cmd(name, vim_cmd)
  create_cmd(name, function(opts)
    local dir = vim.fn.expand('%:p:h')
    vim.cmd(vim_cmd .. ' ' .. vim.fn.fnameescape(dir .. '/' .. opts.args))
  end, { nargs = '+', complete = 'file', bar = true })
end

create_file_cmd('OT', 'tabe') -- new tab
create_file_cmd('OV', 'vnew') -- vertical split
create_file_cmd('OS', 'new') -- horizontal split

-- Delete single line, or a range of lines and jump back to previous position
create_cmd('D', function(opts)
  vim.cmd(opts.line1 .. ',' .. opts.line2 .. 'd')
  vim.cmd('norm! ``')
end, { range = true, nargs = 0 })

-- Format JSON Documents
create_cmd('FormatJSON', function()
  vim.bo.filetype = 'json'
  vim.cmd('%!python -m json.tool')
end)

-- Format XML Documents
create_cmd('FormatXML', function()
  vim.bo.filetype = 'xml'
  vim.cmd('%!xmllint --format %')
end)

-- Replace the current buffer with a new buffer
local function replace_buffer(opts)
  local curbuf = vim.fn.bufnr('%')
  local dir = vim.fn.expand('%:p:h')
  local newfile = dir .. '/' .. opts.fargs[1]
  vim.cmd('e ' .. vim.fn.fnameescape(newfile))
  -- Use 'bdelete!' if bang is present, otherwise 'bdelete'
  local bd_cmd = 'bd' .. (opts.bang and '!' or '')
  vim.cmd(bd_cmd .. ' ' .. curbuf)
end

create_cmd('BDE', replace_buffer, {
  nargs = 1,
  complete = 'file',
  bang = true,
  bar = true,
})

-- Better handling of hlsearch
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")
