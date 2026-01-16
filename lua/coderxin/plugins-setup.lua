-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins to install
require("lazy").setup({
  -- lua functions
  { "nvim-lua/plenary.nvim" },

  -- navigation between tmux panes and vim splits
  { "christoomey/vim-tmux-navigator" },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- bufferline buffers and tabs
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- marking of file for revisiting
  { "theprimeagen/harpoon" },

  -- pretty list for showing diagnostics, references, etc
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({ icons = false })
    end,
  },

  -- git
  { "airblade/vim-gitgutter" },
  { "tpope/vim-fugitive" },
  { "kdheepak/lazygit.nvim" },

  -- lsp setup
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
    },
  },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
    },
  },

  -- Snippets
  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },

  -- Status of LSP progress
  {
    "j-hui/fidget.nvim",
    tag = "v1.4.5",
  },

  -- Rust support (rustaceanvim replaces rust-tools.nvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },

  -- Ruby and Rails
  { "vim-ruby/vim-ruby" },
  { "tpope/vim-rails" },
  { "tpope/vim-endwise" },

  -- TypeScript (typescript-tools replaces typescript.nvim)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Debugging
  { "mfussenegger/nvim-dap" },

  -- Autopairs & Formatting & Identation
  { "windwp/nvim-autopairs" },
  { "tpope/vim-surround" },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl" },

  -- Comments
  { "numToStr/Comment.nvim" },
  { "folke/todo-comments.nvim" },

  -- Automatically highlighting other uses of the word
  { "RRethy/vim-illuminate" },

  -- Nvim diagnostics
  { "dstein64/vim-startuptime" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -- shows the context of the currently visible buffer contents
  { "nvim-treesitter/nvim-treesitter-context" },

  -- file explorer
  { "nvim-tree/nvim-tree.lua" },

  -- vs-code like icons
  { "nvim-tree/nvim-web-devicons" },

  -- Fuzzy finding
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  -- telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
  },

  -- statusline
  { "nvim-lualine/lualine.nvim" },

  -- copying / pasting text to the os specific clipboard
  { "christoomey/vim-system-copy" },
}, {
  -- lazy.nvim configuration
  ui = {
    border = "rounded",
  },
})
