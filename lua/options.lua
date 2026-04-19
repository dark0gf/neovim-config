require "nvchad.options"

-- add yours here!

vim.opt.number = true
vim.opt.relativenumber = true

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
	vim.g.clipboard = "osc52"
	vim.opt.clipboard = "unnamedplus"
end

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
