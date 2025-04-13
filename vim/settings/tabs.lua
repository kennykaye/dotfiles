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
  local tab_count = vim.fn.tabpagenr('$')
  local current_tab = vim.fn.tabpagenr()
  local tabline = ''

  for i = 1, tab_count do
    local buflist = vim.fn.tabpagebuflist(i)
    local winnr = vim.fn.tabpagewinnr(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')
    
    -- Show [No Name] if buffer has no name
    if bufname == '' then
      bufname = '[No Name]'
    end
    
    -- Add click handler for the tab
    tabline = tabline .. '%' .. i .. 'T'
    
    -- Highlight current tab
    if i == current_tab then
      tabline = tabline .. '%#TabLineSel#'
    else
      tabline = tabline .. '%#TabLine#'
    end
    
    -- Add tab number and name
    tabline = tabline .. ' ' .. i .. ' ' .. bufname .. ' '
    
    -- Reset to TabLineFill after each tab
    tabline = tabline .. '%#TabLineFill#'
  end

  -- Add right-aligned indicator
  return tabline .. (tab_count > 1 and ' %T' or '')
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