local treesitter = require("nvim-treesitter")
treesitter.setup({})

local parsers = {
  "javascript", "typescript", "tsx", "ruby", "rust", "lua", "vim", "vimdoc",
  "query", "bash", "json", "yaml", "terraform", "hcl", "html", "css", "toml", "python",
}
local install = treesitter.install(parsers)

local group = vim.api.nvim_create_augroup("CoderxinTreesitter", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(ev)
    -- Plain-text and unsupported filetypes keep their normal syntax settings.
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if not lang then return end
    local ok, loaded = pcall(vim.treesitter.language.add, lang)
    if not ok or not loaded then return end
    vim.treesitter.start(ev.buf, lang)
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

return install
