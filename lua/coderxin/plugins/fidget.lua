-- import fidget safely
local fidget_setup, fidget = pcall(require, "fidget")
if not fidget_setup then
  return
end

-- Fidget - show status of LSP progress (v1.x API)
fidget.setup({
  notification = {
    window = {
      winblend = 10,
      relative = "editor",
    },
  },
})
