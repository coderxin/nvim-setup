-- rustaceanvim configuration (replaces rust-tools.nvim)
-- rustaceanvim is configured via vim.g.rustaceanvim

vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", function()
        vim.cmd.RustLsp({ 'hover', 'actions' })
      end, { buffer = bufnr, desc = "Rust hover actions" })

      -- Code action groups
      vim.keymap.set("n", "<Leader>ra", function()
        vim.cmd.RustLsp('codeAction')
      end, { buffer = bufnr, desc = "Rust code actions" })
    end,
    default_settings = {
      ['rust-analyzer'] = {},
    },
  },
}
