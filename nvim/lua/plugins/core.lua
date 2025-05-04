return {
  { "nvim-lua/plenary.nvim" },

  -- Core plugins
  { "folke/lazy.nvim" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-obsession" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-sleuth" },
  { "junegunn/vim-easy-align" },

  -- Lazy Loaded
  { "nvzone/volt" , lazy = true },
  { "nvzone/menu" , lazy = true },
  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },
  {
    "tpope/vim-commentary",
    cmd = { "Commentary", "CommentaryLine" },
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment" },
      { "gcc", mode = "n", desc = "Comment line" },
    },
  },
}
