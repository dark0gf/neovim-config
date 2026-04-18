-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
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
