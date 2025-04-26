return {
  "mbbill/undotree",
  config = function ()
    -- Create undodir if it doesn't exist
    local undodir = vim.fn.expand("~/.config/vim/undodir")
    if vim.fn.isdirectory(undodir) == 0 then
      vim.fn.mkdir(undodir, "p")
    end

    vim.opt.undodir = undodir
    vim.opt.undofile = true
  end
}

