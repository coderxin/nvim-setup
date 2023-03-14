-- set a leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General Keymaps --
keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Plugin Keymaps --
-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

local builtin = require('telescope.builtin')
keymap.set('n', "<leader>fg", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
