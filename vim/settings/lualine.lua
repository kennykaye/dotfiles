vim.cmd('colorscheme base16-eighties')

local base16_kaye = require'lualine.themes.base16'

local colors = {
  bg       = '#2d2d2d',
  fg       = '#d3d0c8',
  yellow   = '#ffcc66',
  cyan     = '#66cccc',
  darkgray = '#393939',
  green    = '#99cc99',
  orange   = '#f99157',
  violet   = '#cc99cc',
  magenta  = '#cc99cc',
  blue     = '#6699cc',
  red      = '#f2777a',
  gray     = '#747369',
}

-- Change the background of lualine_c section for normal mode
base16_kaye.normal.a.bg = colors.cyan
base16_kaye.insert.a.bg = colors.green
base16_kaye.visual.a.bg = colors.yellow
base16_kaye.replace.a.bg = colors.red
base16_kaye.inactive.a.bg = colors.gray

-- Initialize and set gray background for lualine_z section
base16_kaye.normal.z = { bg = colors.gray, fg = colors.fg }
base16_kaye.insert.z = { bg = colors.gray, fg = colors.fg }
base16_kaye.visual.z = { bg = colors.gray, fg = colors.fg }
base16_kaye.replace.z = { bg = colors.gray, fg = colors.fg }
base16_kaye.inactive.z = { bg = colors.gray, fg = colors.fg }

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
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
    end
  end
  return sections
end


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = base16_kaye,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {
      'location',
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.darkgray } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.yellow, fg = colors.darkgray } },
      }
    }
    --todo: add diagnostics
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
