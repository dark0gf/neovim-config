return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        api.config.mappings.default_on_attach(bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }

        vim.keymap.set("n", "l", function()
          local node = api.tree.get_node_under_cursor()
          if node.type == "directory" then
            api.node.open.edit()
          else
            api.node.open.edit()
          end
        end, opts)

        vim.keymap.set("n", "h", function()
          local node = api.tree.get_node_under_cursor()
          if node.type == "directory" and node.open then
            api.node.open.edit()
          else
            api.node.navigate.parent_close()
          end
        end, opts)

        -- Toggle favorites-only filter in NvimTree
        vim.keymap.set("n", "F", function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, opts)
      end,
      view = {
        width = "25%",
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    }
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()
    end,
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc",
        "html", "css",
        "javascript", "typescript", "tsx",
  		},
  	},
  },
}
