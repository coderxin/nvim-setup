-- Solargraph (Ruby LSP) using native nvim 0.11 API
vim.lsp.config("solargraph", {
  flags = {
    debounce_text_changes = 150,
  },
})
vim.lsp.enable("solargraph")
