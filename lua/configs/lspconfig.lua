require("nvchad.configs.lspconfig").defaults()

local is_win = vim.fn.has("win32") == 1
local npm_bin_dir
local document_highlight_group = vim.api.nvim_create_augroup("custom-lsp-document-highlight", { clear = true })

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

local function set_document_highlight_hl()
	local ok, base46 = pcall(require, "base46")
	if not ok then
		return
	end

	local colors = base46.get_theme_tb "base_30"
	vim.api.nvim_set_hl(0, "LspReferenceText", { bg = colors.one_bg3 })
	vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = colors.one_bg3 })
	vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = colors.one_bg2, underline = true })
end

local function enable_document_highlight(client, bufnr)
	if not client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
		return
	end

	local buffer_group = vim.api.nvim_create_augroup("custom-lsp-document-highlight-" .. bufnr, { clear = true })

	vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		group = buffer_group,
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
	})

	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
		group = buffer_group,
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
	})

	vim.api.nvim_create_autocmd("LspDetach", {
		group = document_highlight_group,
		buffer = bufnr,
		once = true,
		callback = function(args)
			vim.lsp.buf.clear_references()
			vim.api.nvim_clear_autocmds({ group = buffer_group, buffer = args.buf })
		end,
	})
end

set_document_highlight_hl()

vim.api.nvim_create_autocmd("User", {
	pattern = "NvThemeReload",
	callback = set_document_highlight_hl,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = document_highlight_group,
	callback = function(args)
		if not args.data or not args.data.client_id then
			return
		end

		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		enable_document_highlight(client, args.buf)
	end,
})

vim.lsp.config("html", {
	cmd = lsp_cmd(is_win and "vscode-html-language-server.cmd" or "vscode-html-language-server"),
})

vim.lsp.config("cssls", {
	cmd = lsp_cmd(is_win and "vscode-css-language-server.cmd" or "vscode-css-language-server"),
})

vim.lsp.config("pyright", {
	cmd = lsp_cmd(is_win and "pyright-langserver.cmd" or "pyright-langserver"),
})

local servers = {
	"html",
	"cssls",
	"lua_ls",
	"pyright",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
