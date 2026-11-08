-- indent-blankline v3 API (ibl)
local ok, ibl = pcall(require, "ibl")
if not ok then
  return
end

vim.api.nvim_set_hl(0, "IndentGuide", { fg = "#2d3033" })

ibl.setup({
  indent = {
    char = "│",
    highlight = { "IndentGuide" },
  },
  scope = {
    enabled = true,
  },
})
