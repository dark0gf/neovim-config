require("nvchad.configs.lspconfig").defaults()

local is_win = vim.fn.has("win32") == 1
local npm_bin_dir

if not is_win and vim.fn.executable("npm") == 1 then
	local prefix = vim.trim(vim.fn.system({ "npm", "config", "get", "prefix" }))
	if vim.v.shell_error == 0 and prefix ~= "" then
		npm_bin_dir = prefix .. "/bin"
	end
end

local function resolve_executable(name)
	local executable = vim.fn.exepath(name)
	if executable ~= "" then
		return executable
	end

	if npm_bin_dir then
		local candidate = npm_bin_dir .. "/" .. name
		if vim.uv.fs_stat(candidate) then
			return candidate
		end
	end

	return name
end

local function lsp_cmd(name)
	return { resolve_executable(name), "--stdio" }
end

vim.lsp.config("html", {
	cmd = lsp_cmd(is_win and "vscode-html-language-server.cmd" or "vscode-html-language-server"),
})

vim.lsp.config("cssls", {
	cmd = lsp_cmd(is_win and "vscode-css-language-server.cmd" or "vscode-css-language-server"),
})

vim.lsp.config("pyright", {
	cmd = lsp_cmd(is_win and "pyright-langserver.cmd" or "pyright-langserver"),
})

vim.lsp.config("ts_ls", {
	cmd = lsp_cmd(is_win and "typescript-language-server.cmd" or "typescript-language-server"),
})

local servers = {
	"html",
	"cssls",
	"lua_ls",
	"pyright",
	"ts_ls",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
