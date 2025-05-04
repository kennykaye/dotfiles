return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
            markdown = true,
            help = true,
        },
    },
    config = function ()
        require("copilot").setup()
    end
}
