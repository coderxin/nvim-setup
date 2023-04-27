local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

typescript.setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false,            -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true,        -- fall back to standard LSP definition on failure
  },
})
