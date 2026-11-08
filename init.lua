if vim.fn.has("nvim-0.11.3") == 0 then
  error("This configuration requires Neovim 0.11.3 or later")
end

-- Set leaders before plugins register their mappings.
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.loader.enable()

require("coderxin.core.options")
require("coderxin.plugins-setup")
require("coderxin.core.keymap")
