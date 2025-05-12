return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local base16 = require('lualine.themes.base16')
    local colors = require('utils.colors')

    -- Change the background of lualine_c section for normal mode
    base16.normal.a.bg = colors.teal
    base16.insert.a.bg = colors.green
    base16.visual.a.bg = colors.yellow
    base16.replace.a.bg = colors.red
    base16.inactive.a.bg = colors.overlay1

    -- Initialize and set gray background for lualine_z section
    base16.normal.z = { bg = colors.overlay1, fg = colors.text }
    base16.insert.z = { bg = colors.overlay1, fg = colors.text }
    base16.visual.z = { bg = colors.overlay1, fg = colors.text }
    base16.replace.z = { bg = colors.overlay1, fg = colors.text }
    base16.inactive.z = { bg = colors.overlay1, fg = colors.text }

    local empty = require('lualine.component'):extend()
    function empty:draw(default_highlight)
      self.status = ''
      self.applied_separator = ''
      self:apply_highliglts(default_highlight)
      self:apply_section_separators()
      return self.status
    end

    -- LSP clients attached to buffer
    local lsp_or_filetype = function ()
      local bufnr = vim.api.nvim_get_current_buf()

      local clients = vim.lsp.get_clients({bufnr=bufnr})
      if next(clients) == nil then
        return vim.bo.filetype
      end

      local c = {}
      for _, client in pairs(clients) do
        if client.name ~= 'copilot' then
          table.insert(c, client.name)
        end
      end
      return ' ' .. table.concat(c, ',')
    end

    -- Check if a buffer is on an allowlist to display lualine componentn
    local should_show_component = function()
      local ft = vim.bo.filetype
      return not (ft:match("Avante") or ft:match("snacks"))
    end

    -- Function to check if diagnostics are enabled
    local diagnostics_enabled = function()
      -- Check if snacks.nvim has disabled diagnostics

      ---@module "snacks"
      if package.loaded.snacks and Snacks.toggle and Snacks.toggle.diagnostics then
        return Snacks.toggle.diagnostics():get()
      end
      -- Default to enabled if snacks isn't loaded yet or doesn't have the toggle
      return true
    end

    -- Put proper separators and gaps between components in sections
    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
          end
          if not comp.cond then
            comp.cond = should_show_component
          end
          comp.separator = left and { right = '' } or { left = '' }
          -- comp.separator = left and { right = '' } or { left = '' }
        end
      end
      return sections
    end

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = base16,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 1,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = process_sections {
        lualine_a = { { 'mode', fmt = function(res) return res:sub(1,1) end } },
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = {
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = colors.red },
          },
          { lsp_or_filetype },
        },
        lualine_y = { 'progress' },
        lualine_z = {
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'warn' },
            diagnostics_color = { warn = { bg = colors.yellow, fg = colors.surface0 } },
            cond = diagnostics_enabled
          },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'error' },
            diagnostics_color = { error = { bg = colors.red, fg = colors.surface0 } },
            cond = diagnostics_enabled
          },
        }
      },
      inactive_sections = process_sections {
        lualine_a = {},
        lualine_b = { { 'filename' } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
  end
}
