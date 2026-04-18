require("nvchad.configs.lspconfig").defaults()

if vim.fn.has("win32") == 1 then
	vim.lsp.config("cssls", {
		cmd = { "vscode-css-language-server.cmd", "--stdio" },
	})
end

local servers = {
	"html",
	"cssls",
	"lua_ls",
	"pyright",
	"ts_ls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
