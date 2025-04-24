return {
  "easymotion/vim-easymotion",
  config = function ()
    -- Mappings
    local map = vim.keymap.set
    map('', '<C-s>', '<Plug>(easymotion-sn)')
    map('o', '<C-s>', '<Plug>(easymotion-tn)')
    map('', '<C-/>', '<Plug>(easymotion-sn)')
    map('o', '<C-/>', '<Plug>(easymotion-tn)')
    map('', '<C-_>', '<Plug>(easymotion-sn)')
    map('o', '<C-_>', '<Plug>(easymotion-tn)')
    map('', '<leader>/', '<Plug>(easymotion-sn)')
    map('o', '<leader>/', '<Plug>(easymotion-tn)')
    map('', '<leader>s', '<Plug>(easymotion-sn)')
    map('o', '<leader>s', '<Plug>(easymotion-tn)')

    -- Configuration
    vim.g.EasyMotion_use_upper = 1
    vim.g.EasyMotion_smartcase = 1
    vim.g.EasyMotion_use_smartsign_us = 1
  end
}
