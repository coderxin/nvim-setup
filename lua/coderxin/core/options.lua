local opt = vim.opt

-- Line numbers
opt.relativenumber = true -- Show relative line numbers
opt.nu = true -- Show absolute line number (when relative number is on)

-- Tabs
opt.tabstop = 2 -- Spaces for tabs
opt.softtabstop = 2 -- How many columns (=spaces) the cursor moves right when you press <Tab>
opt.shiftwidth = 2 -- Space for ident width
opt.expandtab = true -- Expand tab to spaces

-- Identation
opt.autoindent = true -- Copy ident from current line when starting a new one
opt.smartindent = true -- Reacts to the syntax/style of the code you are editing

-- Line wrapping
opt.wrap = false -- Disable line wrapping

-- Columns
opt.colorcolumn = "80" -- Highlighted screen column

-- Search settings
opt.ignorecase = true -- Ignore case when searching
opt.smartcase = true -- Case-insentitive if the search contains upper case chars
opt.hlsearch = false --  Do not highlight previous search matches 
opt.incsearch = true -- Show where the pattern, as it was typed so far, matches

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- Misc
opt.updatetime = 50
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

