-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",
	changed_themes = {
		onedark = {
			base_30 = {
				darker_black = "#101419",
				black = "#14181f",
				black2 = "#1a1e25",
				one_bg = "#20252d",
				one_bg2 = "#272d36",
				one_bg3 = "#2d333d",
				line = "#252b34",
				statusline_bg = "#151920",
				lightbg = "#232830",
			},
			base_16 = {
				base00 = "#14181f",
				base01 = "#272d36",
				base02 = "#2d333d",
			},
		},
	},
}

M.ui = {
	statusline = {
		modules = {
			harpoon = function()
				local ok, harpoon = pcall(require, "harpoon")
				if not ok then return "" end
				local list = harpoon:list()
				local current = vim.fn.expand "%:p:."
				for i, item in ipairs(list.items) do
					if item.value == current then
						return "%#St_gitIcons# ★ " .. i .. " "
					end
				end
				return ""
			end,
		},
		order = { "mode", "file", "git", "%=", "harpoon", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
	},
}

return M
