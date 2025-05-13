local PORTKEY_MODEL = os.getenv("PORTKEY_MODEL")
local PORTKEY_API_KEY = os.getenv("PORTKEY_API_KEY")
local PORTKEY_ENDPOINT = os.getenv("PORTKEY_ENDPOINT")
local PORTKEY_VIRTUAL_KEY = os.getenv("PORTKEY_VIRTUAL_KEY")

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
        provider = os.getenv("AVANTE_PROVIDER"),
        portkey = {
            temperature = 1
        },
        windows = {
            width = 33,
            height = 33,
            position = "right",
            input = {
                prefix = "❯ ",
            },
            edit = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                start_insert = true, -- Start insert mode when opening the edit window
            },
        },
        hints = {
            enabled = false,
        },

        selector = {
            provider = "snacks",
        },

        vendors = {
            -- Custom portkey provider based on conformance to OpenAI spec.
            portkey = {
                __inherited_from = "openai",
                endpoint = PORTKEY_ENDPOINT,
                api_key_name = "PORTKEY_API_KEY",
                model = PORTKEY_MODEL,

                -- Override header building & curl args
                ---@param opts table      -- provider options (this table)
                ---@param code_opts table -- options describing current request
                ---@return table          -- curl args for avante
                parse_curl_args = function(opts, code_opts)
                    local provider = require("avante.providers.openai")
                    local base_args = provider.parse_curl_args(opts, code_opts)

                    base_args.url = opts.endpoint .. "/chat/completions"
                    base_args.headers = {
                        ["Content-Type"] = "application/json",
                        ["accept"] = "application/json",
                        ["x-portkey-api-key"] = PORTKEY_API_KEY or "",
                        ["x-portkey-virtual-key"] = PORTKEY_VIRTUAL_KEY or "",
                    }

                    base_args.body.temperature = opts.temperature or 1
                    base_args.body.model = opts.model

                    return base_args
                end,

                -- Portkey's stream often ends with a plain "[DONE]" sentinel without a final
                -- JSON chunk that contains `finish_reason = "stop"`.  Avante's default OpenAI
                -- parser relies on that final JSON to detect completion, so the spinner never
                -- stops.  We patch `parse_response` to treat the bare "[DONE]" sentinel as
                -- completion.
                parse_response = function(self, ctx, data_stream, current_event_state, opts)
                    if data_stream == "[DONE]" then
                        -- flush any buffered content/snippets, then mark the request complete
                        local provider = require("avante.providers.openai")
                        if provider.finish_pending_messages then
                            provider.finish_pending_messages(self, ctx, opts)
                        end
                        opts.on_stop({ reason = "complete" })
                        return
                    end

                    -- Otherwise defer to the original OpenAI implementation
                    local provider = require("avante.providers.openai")
                    provider.parse_response(self, ctx, data_stream, current_event_state, opts)
                end,
            },
        },
    },
    build = "make",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'zbirenbaum/copilot.lua',
        'MeanderingProgrammer/render-markdown.nvim',
    },
}
