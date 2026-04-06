local AVANTE_PROVIDER = os.getenv("AVANTE_PROVIDER")
local PORTKEY_MODEL = os.getenv("PORTKEY_MODEL")
local PORTKEY_API_KEY = os.getenv("PORTKEY_API_KEY")
local PORTKEY_ENDPOINT = os.getenv("PORTKEY_ENDPOINT")
local PORTKEY_VIRTUAL_KEY = os.getenv("PORTKEY_VIRTUAL_KEY")

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = function()
        return {
            provider = AVANTE_PROVIDER,
            portkey_openai = {
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
                    start_insert = true,
                },
            },
            hints = {
                enabled = false,
            },

            selector = {
                provider = "snacks",
            },

            providers = {
                portkey_openai = {
                    __inherited_from = "openai",
                    endpoint = PORTKEY_ENDPOINT,
                    api_key_name = "PORTKEY_API_KEY",
                    model = PORTKEY_MODEL,
                    parse_curl_args = function(vendor_opts, code_opts)
                        local openai_provider_utils = require("avante.providers.openai")
                        local base_args = openai_provider_utils.parse_curl_args(vendor_opts, code_opts)

                        base_args.url = vendor_opts.endpoint .. "/chat/completions"

                        if not base_args.headers then
                            base_args.headers = {}
                        end
                        base_args.headers["x-portkey-api-key"] = PORTKEY_API_KEY or ""
                        base_args.headers["x-portkey-virtual-key"] = PORTKEY_VIRTUAL_KEY or ""
                        base_args.headers["Content-Type"] = "application/json"

                        base_args.body.temperature = vendor_opts.temperature or 1
                        base_args.body.model = vendor_opts.model

                        return base_args
                    end,
                },
            },
        }
    end,
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
