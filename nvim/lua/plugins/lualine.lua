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

    -- Put proper separators and gaps between components in sections
    local function process_sections(sections)
      for name, section in pairs(sections) do
        local left = name:sub(9, 10) < 'x'
        for id, comp in ipairs(section) do
          if type(comp) ~= 'table' then
            comp = { comp }
            section[id] = comp
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
          statusline = 100,
          tabline = 100,
          winbar = 100,
        }
      },
      sections = process_sections{
        lualine_a = {
          {'mode', fmt = function(res) return res:sub(1,1) end}
        },
        lualine_b = {'filename'},
        lualine_c = {},
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = colors.peach },
          },
          {'filetype'},
        },
        lualine_y = {'progress'},
        lualine_z = {
          -- 'location',
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'error' },
            diagnostics_color = { error = { bg = colors.red, fg = colors.surface0 } },
          },
          {
            'diagnostics',
            source = { 'nvim' },
            sections = { 'warn' },
            diagnostics_color = { warn = { bg = colors.yellow, fg = colors.surface0 } },
          }
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {'filename'},
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
