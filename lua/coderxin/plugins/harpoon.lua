-- import harpoon.mark safely
local mark_setup, mark = pcall(require, "harpoon.mark")
if not mark_setup then
  return
end

-- import harpoon.ui safely
local ui_setup, ui = pcall(require, "harpoon.ui")
if not ui_setup then
  return
end

local keymap = vim.keymap

keymap.set("n", "<leader>a", mark.add_file)
keymap.set("n", "<C-e>", ui.toggle_quick_menu)

keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
