require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file" })
map("n", "<A-k>", "k<C-y>", { desc = "Up one line, keep cursor screen position" })
map("n", "<A-j>", "j<C-e>", { desc = "Down one line, keep cursor screen position" })

-- Use LSP navigation (cross-file) instead of Vim's local-only defaults.
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP go to definition" }) -- go deeper, into code if that function
map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP go to implementation" })
map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" }) -- who uses this function
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP go to declaration" })

map("n", "<leader>e", function()
  vim.cmd("NvimTreeFocus")
  vim.cmd("only")
end, { desc = "NvimTree full screen" })

map("n", "<leader>q", ":q<CR>", { desc = "Window commands" })

map("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
map("n", "<leader>wj", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<leader>wk", "<C-w>k", { desc = "Move to top window" })
map("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split window horizontal" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split window vertical" })
map("n", "<leader>ww", "<C-w>w", { desc = "Cycle windows" })

map("n", "]q", ":cnext<CR>", { desc = "Next quickfix" })
map("n", "[q", ":cprev<CR>", { desc = "Prev quickfix" })

-- Harpoon (favorites)
map("n", "<leader>fa", function()
  require("harpoon"):list():add()
  vim.notify("Added to favorites", vim.log.levels.INFO)
end, { desc = "Add file to favorites" })

map("n", "<leader>fr", function()
  require("harpoon"):list():remove()
  vim.notify("Removed from favorites", vim.log.levels.INFO)
end, { desc = "Remove file from favorites" })

map("n", "<leader>ff", function()
  local harpoon = require "harpoon"
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Show favorites list" })

local line_favorites = require "configs.line_favorites"
line_favorites.setup()

local jump_slots = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local set_keys = { "!", "@", "#", "$", "%", "^", "&", "*", "(", ")" }

for i, slot in ipairs(jump_slots) do
  map("n", "<leader>" .. set_keys[i], function()
    line_favorites.set(slot)
  end, { desc = "Set line favorite " .. slot })

  map("n", "<leader>" .. slot, function()
    line_favorites.jump(slot)
  end, { desc = "Go to line favorite " .. slot })
end


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
