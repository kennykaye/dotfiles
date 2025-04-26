return {
  -- Lazy-load plugins
  {
    "tpope/vim-commentary",
    cmd = { "Commentary", "CommentaryLine" },
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment" },
      { "gcc", mode = "n", desc = "Comment line" },
    },
  },
}
