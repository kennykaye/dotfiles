---@module "snacks"

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local status_ok, harpoon = pcall(require, "harpoon")
    if not status_ok then
      return
    end
    harpoon:setup()

    -- picker
    local normalize_list = function(t)
      local normalized = {}
      for _, v in pairs(t) do
        if v ~= nil then
          table.insert(normalized, v)
        end
      end
      return normalized
    end

    local get_index = function(value, array)
      for i, item in ipairs(array) do
        if item.value == value then
          return i
        end
      end
    end

    local map = vim.keymap.set
    map("n", "<C-s>", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
    map("n", "<C-n>", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
    map("n", "<C-t>", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
    map("n", "<C-h>", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
    map("n", "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle harpoon quick menu" })
    map("n", "<leader>ha", function()
      harpoon:list():add()
      local buf = vim.fn.expand("%:.")
      local items = harpoon:list().items

      print(
        "`" .. buf .. "`\n" ..
        "**Harpoon**: " .. get_index(buf, items)
      )
    end, { desc = "Add to harpoon list" })

    map("n", "<leader>hh", function()
      Snacks.picker({
        title = "Harpoon",
        format = Snacks.picker.format.ui_select(nil, 0),
        layout = {
          preview = false,
          layout = {
            backdrop = false,
            row = 1,
            width = 0.4,
            min_width = 80,
            height = 0.4,
            border = "rounded",
            box = "vertical",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "hpad" },
            { win = "preview", title = "{preview}", border = "rounded" },
          },
        },
        finder = function()
          local file_paths = {}
          local list = normalize_list(harpoon:list().items)
          for i, item in ipairs(list) do
            table.insert(file_paths, {
              idx = i,
              formatted = item.value,
              text = item.value,
              file = item.value
            })
          end
          return file_paths
        end,
        win = {
          input = {
            keys = { ["<a-d>"] = { "harpoon_delete", mode = { "i", "n", "x" } } },
          },
          list = {
            keys = { ["<a-d>"] = { "harpoon_delete", mode = { "i", "n", "x" } } },
          },
        },
        actions = {
          harpoon_delete = function(picker, item)
            local to_remove = item or picker:selected()
            harpoon:list():remove({ value = to_remove.text })
            harpoon:list().items = normalize_list(harpoon:list().items)
            picker:find({ refresh = true })
          end,
        },
      })
    end, { desc = "Open Harpoon Picker" })
  end
}
