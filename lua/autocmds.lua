require "nvchad.autocmds"

local uv = vim.uv or vim.loop
local session_timer = uv.new_timer()

local function compute_buffers_fingerprint()
	local fingerprint = 0

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted then
			fingerprint = fingerprint + vim.api.nvim_buf_get_changedtick(bufnr)
		end
	end

	return fingerprint
end

local function save_session_if_changed()
	local ok, auto_session = pcall(require, "auto-session")
	if not ok then
		return
	end

	local current = compute_buffers_fingerprint()
	if vim.g._last_session_fingerprint == nil then
		vim.g._last_session_fingerprint = current
		return
	end

	if current ~= vim.g._last_session_fingerprint then
		auto_session.save_session(nil, { show_message = false, is_autosave = true })
		vim.g._last_session_fingerprint = current
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.g._last_session_fingerprint = compute_buffers_fingerprint()

		session_timer:start(
			300000,
			300000,
			vim.schedule_wrap(function()
				save_session_if_changed()
			end)
		)
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if session_timer and not session_timer:is_closing() then
			session_timer:stop()
			session_timer:close()
		end
	end,
})

-- Force line numbers on after session restore
vim.api.nvim_create_autocmd({ "SessionLoadPost", "BufEnter" }, {
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})
