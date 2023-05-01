require("coderxin.plugins-setup")

-- for faster loading
local status, impatient = pcall(require, "impatient")
if not status then
  return
end

require("coderxin.core.options")
require("coderxin.core.keymap")

require("coderxin.plugins.lsp")
require("coderxin.plugins.treesitter")
require("coderxin.plugins.telescope")
require("coderxin.plugins.nvim-tree")
require("coderxin.plugins.autopairs")
require("coderxin.plugins.fidget")
require("coderxin.plugins.blankline")
require("coderxin.plugins.todo-comments")
require("coderxin.plugins.lualine")
require("coderxin.plugins.rust-tools")
require("coderxin.plugins.comment")
require("coderxin.plugins.bufferline")
require("coderxin.plugins.harpoon")
require("coderxin.plugins.typescript")
require("coderxin.plugins.solograph")
require("coderxin.plugins.fugitive")
