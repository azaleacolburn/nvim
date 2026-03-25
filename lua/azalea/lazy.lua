local root = vim.fn.expand("~")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
	vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup({ { import = "azalea.plugins" }, { import = "azalea.plugins.lsp" } })

-- vim.g.nord_disable_background = false
require("everforest").load()

vim.g.netrw_liststyle = 1
vim.g.neovide_fullscreen = true

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

vim.opt.laststatus = 0
vim.opt.cursorline = false
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

-- Relative + current line numbers
vim.wo.relativenumber = true
vim.wo.number = true

-- Set conceal level for obsidian plugin
vim.wo.conceallevel = 1

-- Offwhite line numbers
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#c7c9d6" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#c7c9d6" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#c7c9d6" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#c7c9d6" })
-- Gray comments
vim.api.nvim_set_hl(0, "Comment", { fg = "#9fa2bd" })

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "NONE" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	command = "setlocal nocursorline",
})
-- Stray Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "t", "c", opts)
vim.keymap.set("n", "c", "t", opts)
vim.keymap.set("v", "t", "c", opts)
vim.keymap.set("v", "c", "t", opts)

vim.keymap.set("n", "<leader>o", "<C-o>", opts)
vim.keymap.set("n", "<leader>e", "<cmd>Explore<cr>", opts)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", opts)

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Check if the current buffer is for a Git commit message
		local bufname = vim.fn.expand("%:t")
		if vim.bo.filetype ~= "gitcommit" and bufname == "" then
			require("telescope.builtin").find_files()
		end
	end,
})
