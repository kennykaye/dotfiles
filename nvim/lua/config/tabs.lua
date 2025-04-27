-- Custom tabline configuration for Neovim
--
-- This module provides a custom tabline that:
-- * Shows 1-based tab numbers (e.g., "1:main.lua")
-- * Displays "[No Name]" for unnamed buffers
-- * Highlights the current tab
-- * Makes tabs clickable for easy navigation
-- * Shows tab count when multiple tabs are open
-- * Uses TabLineFill for the background of inactive tab areas
--
-- The tabline format is:
-- [1:filename] [2:filename] [3:filename] ... [N]
-- Where:
-- * Numbers are 1-based tab indices
-- * Current tab is highlighted
-- * N is the total number of tabs (shown only when > 1)
-- * Clicking a tab switches to that tab
--
-- Dependencies: None
-- Usage: Source this file in your Neovim configuration

-- Function to format tab names with 1-based indexes
local function format_tab_name()
  local show_breadcrumbs = false
  local tab_count = vim.fn.tabpagenr('$')
  local current_tab = vim.fn.tabpagenr()
  local tabline = ' '

  for i = 1, tab_count do
    -- Add visible separator before tabs (except the first one, the current tab, and the tab right after current)
    if i > 1 then
        tabline = tabline .. '%#TabLineSeparator#│%#TabLineFill#'
    end

    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local bufname = ' ' .. vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t') .. '  '

    -- Show [No Name] if buffer has no name
    if bufname == '' then
      bufname = '[No Name]'
    end

    -- Add click handler for the tab
    tabline = tabline .. '%' .. i .. 'T'

    -- Highlight current tab and its index differently
    if i == current_tab then
      tabline = tabline .. '%#TabLineSelected#'
      tabline = tabline .. '  %#TabLineSelectedIndex#' .. i .. '%#TabLineSelected# ' .. bufname .. ' '
    else
      tabline = tabline .. '%#TabLine#'
      tabline = tabline .. '  %#TabLineIndex#' .. i .. '%#TabLine# ' .. bufname .. ' '
    end

    -- Reset to TabLineFill after each tab
    tabline = tabline .. '%#TabLineFill#'
  end

  -- Add breadcrumbs for the current buffer's path on the right side
  local current_bufnr = vim.fn.bufnr('%')
  local full_path = vim.fn.bufname(current_bufnr)
  local breadcrumbs = ''

  if full_path ~= '' then
    -- Get the directory part of the path (excluding the filename)
    local dir_path = vim.fn.fnamemodify(full_path, ':h')

    -- Skip if it's just "." (current directory)
    if dir_path ~= '.' then
      -- Replace home directory with tilde
      dir_path = vim.fn.fnamemodify(dir_path, ':~')

      -- Split the path into components
      local path_parts = {}
      for part in string.gmatch(dir_path, '[^/]+') do
        table.insert(path_parts, part)
      end

      -- Create the breadcrumbs with chevron separators
      breadcrumbs = '%#TabLineBreadcrumb#'
      for i, part in ipairs(path_parts) do
        breadcrumbs = breadcrumbs .. part
        if i < #path_parts then
          breadcrumbs = breadcrumbs .. ' %#TabLineBreadcrumbSeparator#›%#TabLineBreadcrumb# '
        end
      end
    end
  end

  -- Add right-aligned breadcrumbs if they exist
  if breadcrumbs ~= '' and show_breadcrumbs then
    tabline = tabline .. '%=%#TabLineFill# ' .. breadcrumbs .. ' '
  end

  -- Return the final tabline
  return tabline
end

-- Function to handle tab switching
local function switch_tab(tabnr)
  vim.cmd('tabnext ' .. tabnr)
end

-- Make the switch function globally available
_G.SwitchTab = switch_tab

-- Set the tabline option
vim.opt.tabline = '%!v:lua.format_tab_name()'

-- Make the function globally available
_G.format_tab_name = format_tab_name

return {
  format_tab_name = format_tab_name
}
