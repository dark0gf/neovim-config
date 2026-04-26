return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function(_, opts)
      local OpenedFolderDecorator = require "configs.nvimtree_opened_dirs"
      local api = require "nvim-tree.api"

      local function set_opened_node_highlight()
        local colors = require("base46").get_theme_tb "base_30"
        vim.api.nvim_set_hl(0, "NvimTreeOpenedHL", { bg = colors.one_bg3 })
        vim.api.nvim_set_hl(0, "NvimTreeGitDirtyIcon", { fg = colors.yellow })
        vim.api.nvim_set_hl(0, "NvimTreeGitNewIcon", { fg = colors.green })
      end

      local function open_tree_on_startup()
        if api.tree.is_visible() then
          return
        end

        local current_buf = vim.api.nvim_get_current_buf()
        local current_name = vim.api.nvim_buf_get_name(current_buf)

        if vim.bo[current_buf].buftype ~= "" or current_name == "" then
          return
        end

        vim.schedule(function()
          if not api.tree.is_visible() then
            api.tree.open({ focus = false })
          end
        end)
      end

      opts.renderer = opts.renderer or {}
      opts.renderer.decorators = {
        "Git",
        "Open",
        OpenedFolderDecorator,
        "Hidden",
        "Modified",
        "Bookmark",
        -- "Diagnostics",  
        "Copied",
        "Cut",
      }

      require("nvim-tree").setup(opts)
      require("configs.nvimtree_session").setup()
      set_opened_node_highlight()

      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("NvimTreeOpenOnStartup", { clear = true }),
        once = true,
        callback = open_tree_on_startup,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "NvThemeReload",
        callback = set_opened_node_highlight,
      })
    end,
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
      end,
      view = {
        width = "20%",
        number = false,
        relativenumber = false,
      },
      renderer = {
        highlight_opened_files = "name",
        icons = {
          show = {
            file = false,
            folder = false,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            git = {
              unstaged = "●",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      update_focused_file = {
        enable = false,
        update_root = false,
      },
      git = {
        enable = true,
        show_on_dirs = false,
      },
      diagnostics = {
        enable = false,
      },
      filters = {
        git_ignored = false,
        dotfiles = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    }
  },

  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_restore_enabled = true,
      auto_save_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
      save_extra_data = function(session_name)
        return require("configs.nvimtree_session").save_extra_data(session_name)
      end,
      restore_extra_data = function(session_name, extra_data)
        require("configs.nvimtree_session").restore_extra_data(session_name, extra_data)
      end,
      post_restore_cmds = {
        function()
          require("configs.nvimtree_session").restore_if_needed()
        end,
      },
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
  "pmizio/typescript-tools.nvim",
  ft = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "neovim/nvim-lspconfig",
  },
  opts = function()
    return require "configs.typescript_tools"
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
