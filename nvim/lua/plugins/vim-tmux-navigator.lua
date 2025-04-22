return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<m-a>", "<cmd>TmuxNavigateLeft<cr>" },
    { "<m-i>", "<cmd>TmuxNavigateDown<cr>" },
    { "<m-e>", "<cmd>TmuxNavigateUp<cr>" },
    { "<m-c>", "<cmd>TmuxNavigateRight<cr>" },
    { "<m-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
  },
}
