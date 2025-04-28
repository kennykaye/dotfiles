return {
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
