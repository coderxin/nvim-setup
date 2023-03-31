-- import rust-tools safely
local rust_tools_setup, rust_tools = pcall(require, "rust-tools")
if not rust_tools_setup then
  return
end

rust_tools.setup({
  standalone = false,
  root_dir = require('lspconfig').util.find_git_ancestor,
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>ra", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
