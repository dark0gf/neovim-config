vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
local ok, base46 = pcall(require, "base46")

if ok then
  base46.load_all_highlights()
else
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
end

require "options"
require "autocmds"

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("OpenNvimTreeOnStartup", { clear = true }),
  once = true,
  callback = function()
    local current_buf = vim.api.nvim_get_current_buf()
    if vim.bo[current_buf].buftype ~= "" then
      return
    end

    local current_win = vim.api.nvim_get_current_win()

    vim.schedule(function()
      require("lazy").load({ plugins = { "nvim-tree.lua" } })

      local ok, api = pcall(require, "nvim-tree.api")
      if not ok or api.tree.is_visible() then
        return
      end

      vim.cmd "NvimTreeOpen"

      if vim.api.nvim_win_is_valid(current_win) then
        vim.api.nvim_set_current_win(current_win)
      end
    end)
  end,
})

vim.schedule(function()
  require "mappings"
end)
