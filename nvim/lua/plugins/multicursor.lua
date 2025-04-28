return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
        local mc = require('multicursor-nvim')
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({'n', 'x'}, '<S-up>', function() mc.lineAddCursor(-1) end)
        set({'n', 'x'}, '<S-down>', function() mc.lineAddCursor(1) end)
        set({'n', 'x'}, '<leader><up>', function() mc.lineSkipCursor(-1) end)
        set({'n', 'x'}, '<leader><down>', function() mc.lineSkipCursor(1) end)

        -- Add or skip adding a new cursor by matching word/selection
        set({'n', 'x'}, '<C-n>', function() mc.matchAddCursor(1) end)
        set({'n', 'x'}, '<C-S-n>', function() mc.matchAddCursor(-1) end)
        set({'n', 'x'}, '<leader>S', function() mc.matchSkipCursor(-1) end)

        -- Add a cursor for all matches of cursor word/selection in the document.
        set({'n', 'x'}, '<leader>A', mc.matchAllAddCursors)

        -- Add and remove cursors with control + left click.
        set('n', '<C-leftmouse>', mc.handleMouse)
        set('n', '<C-leftdrag>', mc.handleMouseDrag)
        set('n', '<C-leftrelease>', mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({'n', 'x'}, '<C-q>', mc.toggleCursor)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)

            -- Select a different cursor as the main one.
            -- layerSet({'n', 'x'}, '<left>', mc.prevCursor)
            -- layerSet({'n', 'x'}, '<right>', mc.nextCursor)

            -- Delete the main cursor.
            -- layerSet({'n', 'x'}, '<leader>x', mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet('n', '<esc>', function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        -- Customize how cursors look.
    end
}
