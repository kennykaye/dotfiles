return {
  "folke/noice.nvim",
  enabled = true,
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        border = {
          style = "rounded",
          padding = { 1, 2 },
        },
        filter_options = {},
        win_options = {
          -- winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        position = {
          row = 8,
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = 11,
          col = "50%",
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          padding = { 1, 2 },
        },
      },
    },
    -- views = {
    --  cmdline_popup = {
    --    border = {
    --      style = "none",
    --      padding = { 2, 3 },
    --    },
    --    filter_options = {},
    --    win_options = {
    --      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    --    },
    --  },
    -- },   -- add any options here
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
  }
}
