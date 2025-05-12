return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
    'Kaiser-Yang/blink-cmp-avante',
  },
  version = '1.*',

  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      list = {
        selection = { preselect = true, auto_insert = true }
      },

      -- Show documentation when selecting a completion item
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = { border = 'rounded' },
      },

      -- Display a preview of the selected item on the current line
      -- ghost_text = { enabled = true },
      menu = {
        -- border = 'rounded',
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" }
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local cmp_kinds = {
                  Copilot = ' 󱐌  ',
                  Avante = ' 󱐌  ',
                  Text = '   ',
                  Dict = '   ',
                  Method = '   ',
                  Function = '   ',
                  Constructor = '   ',
                  Field = '   ',
                  Variable = '   ',
                  Class = '   ',
                  Interface = '   ',
                  Module = '   ',
                  Property = '   ',
                  Unit = '   ',
                  Value = '   ',
                  Enum = '   ',
                  Keyword = '   ',
                  Snippet = '   ',
                  Color = '   ',
                  File = '   ',
                  Reference = '   ',
                  Folder = '   ',
                  EnumMember = '   ',
                  Constant = '   ',
                  Struct = '   ',
                  Event = '   ',
                  Operator = '   ',
                  TypeParameter = '   ',
                }

                return (cmp_kinds[ctx.kind] or '')
              end,
            },
          }
        }
      }
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'avante', 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'copilot' },

      per_filetype = {
        lua = { inherit_defaults = true, 'lazydev' }
      },

      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          transform_items = function(_, items)
            local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
            local kind_idx = #CompletionItemKind + 1
            CompletionItemKind[kind_idx] = "Copilot"
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end,
        },
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            -- options for blink-cmp-avante
          }
        }
      },
    },


    -- Experimental signature help support
    signature = {
      enabled = true,
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" }
}
