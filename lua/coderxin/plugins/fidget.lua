-- import fidget safely
local fidget_setup, fidget = pcall(require, "fidget")
if not fidget_setup then
  return
end

-- Fidget - show status of LSP progress
fidget.setup {
    window = {
        relative = "editor",
        blend = 10,
    },
}

