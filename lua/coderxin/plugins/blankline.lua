-- import ibl (indent-blankline v3) safely
local ibl_setup, ibl = pcall(require, "ibl")
if not ibl_setup then
  return
end

-- Define custom highlight groups
local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2d3033", nocombine = true })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#3FC5FF", nocombine = true })
end)

ibl.setup({
  indent = {
    char = "│",
    highlight = "IblIndent",
  },
  scope = {
    enabled = true,
    highlight = "IblScope",
    show_start = false,
    show_end = false,
  },
})
