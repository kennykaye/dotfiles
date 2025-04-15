-- Configure nvim-tree
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then return end

-- Constants
local HEIGHT_RATIO = 0.8
local WIDTH_RATIO = 0.5
local BACKDROP_BG = "#000000"
local BACKDROP_BLEND = 70
local BACKDROP_WINBLEND = 30
local TREE_TOGGLE_DELAY = 20
local BACKDROP_DELAY = 10

vim.opt.termguicolors = true

-- Global variables to track backdrop
local backdrop = {
  buf = nil,
  win = nil,
}

-- API reference (reduce repeated requires)
local api = require("nvim-tree.api")

-- Create and maintain AutoGroups
local groups = {
  backdrop = vim.api.nvim_create_augroup("NvimTreeBackdrop", { clear = true }),
  resize = vim.api.nvim_create_augroup("NvimTreeResize", { clear = true }),
  highlights = vim.api.nvim_create_augroup("NvimTreeHighlights", { clear = true })
}

-- Helper to check if tree is visible
local function is_tree_visible()
  return api.tree.is_visible()
end

-- Helper to set NvimTreeBackdrop highlight
local function set_backdrop_highlight()
  vim.api.nvim_set_hl(0, "NvimTreeBackdrop", { bg = BACKDROP_BG, blend = BACKDROP_BLEND })
end

-- Create and show the backdrop
local function show_backdrop()
  local status, err = pcall(function()
    -- Always create a fresh buffer to avoid issues with invalid IDs
    backdrop.buf = vim.api.nvim_create_buf(false, true)
    
    if backdrop.buf and vim.api.nvim_buf_is_valid(backdrop.buf) then
      vim.api.nvim_buf_set_option(backdrop.buf, 'bufhidden', 'wipe')
      
      -- Close any existing backdrop window
      if backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
        vim.api.nvim_win_close(backdrop.win, true)
      end
      
      -- Create the backdrop window
      backdrop.win = vim.api.nvim_open_win(backdrop.buf, false, {
        relative = "editor",
        width = vim.o.columns,
        height = vim.o.lines,
        row = 0,
        col = 0,
        focusable = false,
        zindex = 10,
        style = "minimal",
      })
      
      -- Apply backdrop highlighting
      if backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
        vim.api.nvim_win_set_option(backdrop.win, "winhighlight", "Normal:NvimTreeBackdrop")
        -- Add winblend for additional transparency effect
        vim.api.nvim_win_set_option(backdrop.win, "winblend", BACKDROP_WINBLEND)
      end
    end
  end)
  
  if not status then
    -- If there was an error, clean up and log it
    if backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
      pcall(vim.api.nvim_win_close, backdrop.win, true)
    end
    backdrop.win = nil
    backdrop.buf = nil
    -- print("NvimTree backdrop error: " .. err)
  end
end

-- Close the backdrop
local function hide_backdrop()
  pcall(function()
    if backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
      vim.api.nvim_win_close(backdrop.win, true)
    end
    backdrop.win = nil
    backdrop.buf = nil
  end)
end

-- Create a function to check if nvim-tree is still open
local function check_tree_open()
  pcall(function()
    -- If tree is not visible, hide backdrop
    if not is_tree_visible() then
      hide_backdrop()
    end
  end)
end

-- Common tree toggle function with backdrop handling
local function toggle_tree_with_backdrop()
  local was_visible = is_tree_visible()
  
  -- Toggle tree
  vim.cmd("NvimTreeToggle")
  
  -- Wait a bit for the tree to open/close
  vim.defer_fn(function()
    local is_visible = is_tree_visible()
    
    if is_visible and not was_visible then
      show_backdrop()
    elseif not is_visible and was_visible then
      hide_backdrop()
    end
  end, TREE_TOGGLE_DELAY)
end

-- Set up keymaps
local function setup_keymaps()
  -- Default toggle mapping
  vim.keymap.set('n', '-', toggle_tree_with_backdrop, { silent = true })
  
  -- Leader mapping
  vim.keymap.set('n', '<leader>e', toggle_tree_with_backdrop, { silent = true })
  
  -- Find file mapping
  vim.keymap.set('n', '<leader>f', function()
    vim.cmd("NvimTreeFindFile")
    
    -- Wait a bit for the tree to open
    vim.defer_fn(function()
      if is_tree_visible() then
        show_backdrop()
      end
    end, TREE_TOGGLE_DELAY)
  end, { silent = true })
end

-- Register autocmds for backdrop
local function setup_autocmds()
  -- Create backdrop when nvim-tree opens
  vim.api.nvim_create_autocmd("FileType", {
    group = groups.backdrop,
    pattern = "NvimTree",
    callback = function()
      vim.defer_fn(function()
        pcall(show_backdrop)
      end, BACKDROP_DELAY)
    end
  })

  -- Remove backdrop when nvim-tree closes
  vim.api.nvim_create_autocmd("BufWinLeave", {
    group = groups.backdrop,
    callback = function(ev)
      pcall(function()
        if vim.bo[ev.buf] and vim.bo[ev.buf].filetype == "NvimTree" then
          hide_backdrop()
        end
      end)
    end
  })

  -- Also listen for tree toggle events
  vim.api.nvim_create_autocmd("User", {
    group = groups.backdrop,
    pattern = "NvimTreeClose",
    callback = function()
      pcall(hide_backdrop)
    end
  })

  -- Monitor when vim is leaving a buffer
  vim.api.nvim_create_autocmd("BufLeave", {
    group = groups.backdrop,
    callback = function(ev)
      pcall(function()
        if vim.bo[ev.buf] and vim.bo[ev.buf].filetype == "NvimTree" then
          vim.defer_fn(function()
            check_tree_open()
          end, 100)
        end
      end)
    end
  })

  -- Handle window resize
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = groups.resize,
    callback = function()
      if is_tree_visible() then
        -- Also update the backdrop
        if backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
          vim.api.nvim_win_close(backdrop.win, true)
          backdrop.win = nil
        end
        
        -- Close tree and reopen with updated dimensions
        api.tree.toggle()
        vim.defer_fn(function()
          api.tree.toggle({ focus = false })
          -- Ensure backdrop is recreated after resize
          show_backdrop()
        end, BACKDROP_DELAY)
      end
    end
  })

  -- Make :bd and :q behave as usual when tree is visible
  vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
    nested = false,
    callback = function(e)
      -- Nothing to do if tree is not opened
      if not is_tree_visible() then
        return
      end

      -- How many focusable windows do we have? (excluding e.g. incline status window)
      local winCount = 0
      for _,winId in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(winId).focusable then
          winCount = winCount + 1
        end
      end

      -- We want to quit and only one window besides tree is left
      if e.event == 'QuitPre' and winCount == 2 then
        vim.api.nvim_cmd({cmd = 'qall'}, {})
      end

      -- :bd was probably issued an only tree window is left
      -- Behave as if tree was closed (see `:h :bd`)
      if e.event == 'BufEnter' and winCount == 1 then
        -- Required to avoid "Vim:E444: Cannot close last window"
        vim.defer_fn(function()
          -- close nvim-tree: will go to the last buffer used before closing
          api.tree.toggle({find_file = true, focus = true})
          -- re-open nivm-tree
          api.tree.toggle({find_file = true, focus = false})
        end, BACKDROP_DELAY)
      end
    end
  })

  -- Set colors to match base16-eighties after colorscheme is loaded
  vim.api.nvim_create_autocmd({"ColorScheme", "VimEnter"}, {
    group = groups.highlights,
    callback = function()
      -- Set backdrop highlight
      set_backdrop_highlight()
      
      -- Set colors to match base16-eighties
      vim.cmd([[
        highlight! NvimTreeFolderIcon guifg=#66cccc
        highlight! NvimTreeFolderName guifg=#66cccc
        highlight! NvimTreeOpenedFolderName guifg=#66cccc
        highlight! NvimTreeEmptyFolderName guifg=#66cccc
        highlight! NvimTreeIndentMarker guifg=#4e4e4e
        highlight! NvimTreeGitDirty guifg=#ffcc66
        highlight! NvimTreeGitStaged guifg=#99cc99
        highlight! NvimTreeGitMerge guifg=#f99157
        highlight! NvimTreeGitRenamed guifg=#6699cc
        highlight! NvimTreeGitNew guifg=#d3d0c8
        highlight! NvimTreeGitDeleted guifg=#f2777a
        highlight! NvimTreeSpecialFile guifg=#cc99cc
        highlight! NvimTreeNormal guibg=#2d2d2d
        highlight! NvimTreeEndOfBuffer guibg=#2d2d2d guifg=#2d2d2d
        highlight! NvimTreeCursorLine guibg=#393939
        highlight! NvimTreeWinSeparator guifg=#393939 guibg=#2d2d2d
        highlight! NvimTreeRootFolder guifg=#f99157
        highlight! NvimTreeFolderArrowOpen guifg=#d3d0c8
        highlight! NvimTreeFolderArrowClosed guifg=#747369
        highlight! link NvimTreeSymlink Special
        highlight! link NvimTreeExecFile String
      ]])
    end,
    desc = "Set NvimTree colors to match base16-eighties"
  })
end

-- Calculate centered floating window config
local function get_float_window_config()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = screen_w * WIDTH_RATIO
  local window_h = screen_h * HEIGHT_RATIO
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
  
  return {
    border = "rounded",
    relative = "editor",
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
    title = "Directory",
    title_pos = "center",
    zindex = 50, -- Higher than backdrop
  }
end

-- NvimTree setup
nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  respect_buf_cwd = true,
  sync_root_with_cwd = true,
  on_attach = function(bufnr)
    -- Close nvim-tree with Escape key
    vim.keymap.set('n', '<Esc>', function()
      api.tree.close()
    end, { buffer = bufnr, noremap = true, silent = true })
    
    -- Also close nvim-tree with q key
    vim.keymap.set('n', 'q', function()
      api.tree.close()
    end, { buffer = bufnr, noremap = true, silent = true })
  end,
  view = {
    relativenumber = true,
    float = {
      enable = true,
      open_win_config = get_float_window_config,
    },
    width = function()
      return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    end,
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
    indent_width = 3,
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      },
    glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "",
          deleted = "",
          ignored = "◌",
        },
        folder = {
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
        },
      },
      symlink_arrow = " ➛ ",
    },
    indent_markers = {
      enable = true,
      icons = {
        corner = "└──",
        edge = "│  ",
        item = "│  ",
        none = "   ",
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  filters = {
    dotfiles = true,
    custom = { "^.git$" },
    exclude = {},
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
})

-- Initialize
set_backdrop_highlight()
setup_keymaps()
setup_autocmds()
