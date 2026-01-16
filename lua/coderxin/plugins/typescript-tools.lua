-- typescript-tools.nvim configuration (replaces typescript.nvim)
local ts_tools_setup, ts_tools = pcall(require, "typescript-tools")
if not ts_tools_setup then
  return
end

ts_tools.setup({
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- specify a list of plugins to load by tsserver
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--telefonos
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeCompletionsForModuleExports = true,
      quotePreference = "auto",
    },
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
  },
})
