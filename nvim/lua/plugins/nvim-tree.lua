return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  config = function()
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
          pcall(function()
            if is_tree_visible() and backdrop.win and vim.api.nvim_win_is_valid(backdrop.win) then
              vim.api.nvim_win_set_config(backdrop.win, {
                relative = "editor",
                width = vim.o.columns,
                height = vim.o.lines,
                row = 0,
                col = 0,
              })
            end
          end)
        end
      })

      -- Set up highlight group when colorscheme changes
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        group = groups.highlights,
        callback = function()
          set_backdrop_highlight()
        end
      })
    end

    -- Initialize nvim-tree
    require("nvim-tree").setup({
      auto_reload_on_write = true,
      create_in_closed_folder = false,
      disable_netrw = false,
      hijack_cursor = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      open_on_tab = false,
      sort_by = "name",
      update_cwd = false,
      view = {
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get()
            local window_w = math.floor(screen_w * WIDTH_RATIO)
            local window_h = math.floor(screen_h * HEIGHT_RATIO)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((screen_h - window_h) / 2) - 1
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w,
              height = window_h,
            }
          end,
        },
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        full_name = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
          enable = false,
          icons = {
            corner = "└ ",
            edge = "│ ",
            item = "│ ",
            none = "  ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_cwd = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      filters = {
        dotfiles = false,
        custom = {},
        exclude = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 400,
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        open_file = {
          quit_on_open = true,
          resize_window = false,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          git = false,
        },
      },
    })

    -- Set up keymaps and autocmds
    set_backdrop_highlight()
    setup_keymaps()
    setup_autocmds()
  end
} 