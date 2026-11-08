local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  return
end

local ok_dapui, dapui = pcall(require, "dapui")
if not ok_dapui then
  return
end

dapui.setup()

-- Auto-open/close UI when debugging starts/stops
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Keymaps
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() dap.continue() end, { desc = "DAP continue" })
vim.keymap.set("n", "<leader>di", function() dap.step_into() end, { desc = "DAP step into" })
vim.keymap.set("n", "<leader>do", function() dap.step_over() end, { desc = "DAP step over" })
vim.keymap.set("n", "<leader>dO", function() dap.step_out() end, { desc = "DAP step out" })
