require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local telescope_find_files = require "configs.telescope_find_files"
local line_history = require "configs.line_history"

-- NvChad Telescope find files:
-- Space + f + f: find files
-- Space + f + w: live grep (fixed-string first, regex fallback)
-- Space + f + b: buffers
-- Space + f + h: help tags
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })
map("n", "<leader>ff", telescope_find_files.find_files_space_wildcard, {
  desc = "Find files (space = wildcard, case-insensitive)",
})
map("n", "<leader>fw", telescope_find_files.live_grep_fixed_or_regex, {
  desc = "Live grep (fixed-string first, regex fallback)",
})

local function move_cursor_keep_screen_position(delta)
  local view = vim.fn.winsaveview()
  local max_line = vim.api.nvim_buf_line_count(0)
  local target_line = math.max(1, math.min(view.lnum + (delta * vim.v.count1), max_line))
  local moved = target_line - view.lnum

  if moved == 0 then
    return
  end

  view.lnum = target_line
  view.topline = math.max(1, view.topline + moved)
  vim.fn.winrestview(view)
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })

local function move_10x(direction)
  local count = vim.v.count1 * 10
  vim.cmd("normal! " .. count .. direction)
end

local function focus_editor_window()
  local current_win = vim.api.nvim_get_current_win()

  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local config = vim.api.nvim_win_get_config(win)
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.bo[buf].filetype
    local buftype = vim.bo[buf].buftype

    if win ~= current_win and config.relative == "" and filetype ~= "NvimTree" and buftype ~= "quickfix" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end

map("n", "<C-h>", function()
  move_10x("h")
end, { desc = "Left 10 chars" })
map("n", "<C-j>", function()
  move_10x("j")
end, { desc = "Down 10 lines" })
map("n", "<C-k>", function()
  move_10x("k")
end, { desc = "Up 10 lines" })
map("n", "<C-l>", function()
  move_10x("l")
end, { desc = "Right 10 chars" })


map("n", "<A-Left>", line_history.back, { desc = "Line history back" })
map("n", "<A-Right>", line_history.forward, { desc = "Line history forward" })


map("n", "<A-k>", function()
  move_cursor_keep_screen_position(-1)
end, { desc = "Up one line, keep cursor screen position" })
map("n", "<A-j>", function()
  move_cursor_keep_screen_position(1)
end, { desc = "Down one line, keep cursor screen position" })

map("n", "<C-A-k>", function()
  move_cursor_keep_screen_position(-10)
end, { desc = "Up 10 lines, keep cursor screen position" })
map("n", "<C-A-j>", function()
  move_cursor_keep_screen_position(10)
end, { desc = "Down 10 lines, keep cursor screen position" })

-- Use LSP navigation (cross-file) instead of Vim's local-only defaults.
map("n", "<leader>r", vim.lsp.buf.references, { desc = "LSP references", nowait = true })
map("n", "<leader>d", vim.lsp.buf.definition, { desc = "LSP go to definition", nowait = true }) -- go deeper, into code if that function
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "LSP go to implementation" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })

-- nvim tree
map("n", "<leader>e", function()
  vim.cmd("NvimTreeFocus")
end, { desc = "Focus NvimTree" })

map("n", "<leader>E", function()
  require("nvim-tree.api").tree.find_file({ open = true, focus = true })
end, { desc = "Reveal current file in NvimTree" })

map("n", "<leader>o", focus_editor_window, { desc = "Focus editor window" })

-- close buffer or quickfix list
map("n", "<leader>q", function()
  if vim.bo.buftype == "quickfix" then
    local wininfo = vim.fn.getwininfo(vim.api.nvim_get_current_win())[1]

    if wininfo and wininfo.loclist == 1 then
      vim.cmd "lclose"
    else
      vim.cmd "cclose"
    end

    return
  end

  require("nvchad.tabufline").close_buffer()
end, { desc = "Close current buffer or list" })
map("n", "<leader>Q", "<cmd>confirm q<CR>", { desc = "Quit current window" })


-- winows layout
map("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertical" })
map("n", "<leader>ww", "<C-w>w", { desc = "Cycle windows" })

map("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })

map("x", "<leader>y", function()
  require("configs.copy_with_path").copy_visual_selection()
end, { desc = "Copy selection with path" })



-- line bookmarks
local line_favorites = require "configs.line_favorites"
line_history.setup()
line_favorites.setup()

local jump_slots = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local set_keys = { "!", "@", "#", "$", "%", "^", "&", "*", "(", ")" }

for i, slot in ipairs(jump_slots) do
  map("n", "<leader>" .. set_keys[i], function()
    line_favorites.toggle(slot)
  end, { desc = "Toggle line favorite " .. slot })

  map("n", "<leader>" .. slot, function()
    line_favorites.jump(slot)
  end, { desc = "Go to line favorite " .. slot })
end



-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
