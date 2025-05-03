return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require 'colorizer'.setup({
      'css';
      'lua';
      'vim';
    }, { mode = 'background' })
  end
}

