-- import bufferline plugin safely
local setup, bufferline = pcall(require, "bufferline")
if not setup then
  return
end

bufferline.setup({})
