require "nvchad.options"

-- add yours here!

vim.opt.number = true
vim.opt.relativenumber = true
vim.o.selection = "exclusive"
vim.opt.timeout = true
vim.opt.updatetime = 300

vim.opt.sessionoptions = {
	"buffers",
	"curdir",
	"folds",
	"help",
	"tabpages",
	"winsize",
	"terminal",
	"localoptions",
}

if vim.env.SSH_CLIENT or vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
	local osc52 = require "vim.ui.clipboard.osc52"
	vim.g.clipboard = {
		name = "OSC 52 (copy only)",
		copy = {
			["+"] = osc52.copy "+",
			["*"] = osc52.copy "*",
		},
		paste = {
			["+"] = function() end,
			["*"] = function() end,
		},
	}
	vim.opt.clipboard = "unnamedplus"
end

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
