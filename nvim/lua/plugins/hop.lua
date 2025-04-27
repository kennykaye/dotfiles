return {
    'smoka7/hop.nvim',
    dependencies = { 'mfussenegger/nvim-treehopper' },
    version = '*',
    config = function()
        local map = vim.keymap.set
        local hop = require('hop')
        local tsht = require('tsht')
        local directions = require('hop.hint').HintDirection

        tsht.config.hint_keys = { 's', 'n', 't', 'h', 'a', 'e', 'i', 'c', 'l', 'u', 'd', 'o', 'w' }

        hop.setup {
            create_hl_autocmd = false,
            -- uppercase_labels = true,
            multi_windows = true,
            keys = 'snthaeicwdluoy',

            map('', 'm', function() tsht.nodes() end, { remap = true }),
            map('', 's', function() hop.hint_words({}) end, { remap = true }),
            map('', 'ff', function() hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true }) end, { remap = true }),
            map('', 'Ff', function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true }) end, { remap = true }),
            map('', '<C-/>', function() hop.hint_patterns({}) end, { remap = true }),
            map('', '<C-_>', function() hop.hint_patterns({}) end, { remap = true })
        }
    end
}
