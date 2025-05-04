local aucmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
  fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Set Missing Filetypes
augroup("FiletypeDetection", function(g)
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "gitconfig",    command = "set filetype=gitconfig" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "*.conf",       command = "set filetype=conf" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "*.cfg",        command = "set filetype=sh" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "*.webapp",     command = "set filetype=json" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "pryrc",        command = "set filetype=ruby" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "scratch-pad",  command = "set filetype=ruby" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "bash_profile", command = "set filetype=sh" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = {"zprofile", "functions", "aliases"}, command = "set filetype=zsh" })
  aucmd({"BufRead", "BufNewFile"}, { group = g, pattern = "*.js.flow",    command = "set filetype=javascript.flow" })
end)

-- Trim whitespace on save
augroup("FileSave", function(g)
  aucmd("BufWritePre", {
    group = g,
    pattern = "*",
    callback = function()
      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      vim.cmd([[%s/\s\+$//e]])
      vim.api.nvim_win_set_cursor(0, cursor_pos)
    end
  })
end)

-- Toggle hlsearch based on if a search is active
augroup("ToggleSearchHL", function(g)
  aucmd("InsertEnter", {
    group = g,
    callback = function()
      vim.schedule(function() vim.cmd("nohlsearch") end)
    end
  })
  aucmd("CursorMoved", {
    group = g,
    callback = function()
      -- No bloat lua adaptation of: https://github.com/romainl/vim-cool
      local view, rpos = vim.fn.winsaveview(), vim.fn.getpos(".")
      -- Move the cursor to a position where (whereas in active search) pressing `n`
      -- brings us to the original cursor position, in a forward search / that means
      -- one column before the match, in a backward search ? we move one col forward
      vim.cmd(string.format("silent! keepjumps go%s",
        (vim.fn.line2byte(view.lnum) + view.col + 1 - (vim.v.searchforward == 1 and 2 or 0))))
      -- Attempt to goto next match, if we're in an active search cursor position
      -- should be equal to original cursor position
      local ok, _ = pcall(function() vim.cmd("silent! keepjumps norm! n") end)
      local insearch = ok and (function()
        local npos = vim.fn.getpos(".")
        return npos[2] == rpos[2] and npos[3] == rpos[3]
      end)()
      -- restore original view and position
      vim.fn.winrestview(view)
      if not insearch then
        vim.schedule(function() vim.cmd("nohlsearch") end)
      end
    end
  })
end)
