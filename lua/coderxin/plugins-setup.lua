-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to continue...", "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- lua functions (plenary is a dependency, not lazy-loaded on its own)
  { "nvim-lua/plenary.nvim", lazy = true },

  -- navigation between tmux panes and vim splits
  { "christoomey/vim-tmux-navigator", lazy = false },

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("set termguicolors")
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    version = "*",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("coderxin.plugins.bufferline") end,
  },

  -- marking of files for revisiting
  {
    "theprimeagen/harpoon",
    config = function() require("coderxin.plugins.harpoon") end,
  },

  -- pretty list for diagnostics, references, etc
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    config = function()
      require("trouble").setup({ icons = false })
    end,
  },

  -- which-key: shows available keybindings in popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  -- git
  { "airblade/vim-gitgutter", lazy = false },
  {
    "tpope/vim-fugitive",
    lazy = false,
    config = function() require("coderxin.plugins.fugitive") end,
  },
  { "kdheepak/lazygit.nvim", cmd = "LazyGit" },

  -- LSP (native nvim 0.11 APIs + mason for server management)
  {
    "mason-org/mason.nvim",
    lazy = false,
    dependencies = {
      { "mason-org/mason-lspconfig.nvim" },
      { "neovim/nvim-lspconfig" },
      -- Completion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function() require("coderxin.plugins.lsp") end,
  },

  -- Status of LSP progress
  {
    "j-hui/fidget.nvim",
    config = function() require("coderxin.plugins.fidget") end,
  },

  -- Rust (replaces deprecated rust-tools.nvim)
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    init = function() require("coderxin.plugins.rustaceanvim") end,
  },

  -- Ruby and Rails
  { "vim-ruby/vim-ruby", ft = { "ruby", "eruby" } },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  { "tpope/vim-endwise", ft = { "ruby", "eruby", "lua" } },

  -- TypeScript (replaces deprecated typescript.nvim)
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function() require("coderxin.plugins.typescript-tools") end,
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
      },
    },
    config = function() require("coderxin.plugins.dap-ui") end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
        mode = { "n", "v" },
        desc = "Format buffer or selection",
      },
    },
    config = function() require("coderxin.plugins.conform") end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("coderxin.plugins.autopairs") end,
  },

  -- Surround
  { "tpope/vim-surround" },

  -- indent-blankline v3
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    lazy = false,
    config = function() require("coderxin.plugins.blankline") end,
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    config = function() require("coderxin.plugins.comment") end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    config = function() require("coderxin.plugins.todo-comments") end,
  },

  -- Automatically highlighting other uses of the word
  { "RRethy/vim-illuminate" },

  -- Nvim diagnostics
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function() require("coderxin.plugins.treesitter") end,
  },
  { "nvim-treesitter/nvim-treesitter-context" },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    config = function() require("coderxin.plugins.nvim-tree") end,
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "lambdalisue/nerdfont.vim" },

  -- Fuzzy finding
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    lazy = true,
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function() require("coderxin.plugins.telescope") end,
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function() require("coderxin.plugins.lualine") end,
  },

  -- copying / pasting text to the os specific clipboard
  { "christoomey/vim-system-copy" },
}, {
  ui = {
    border = "rounded",
  },
})
