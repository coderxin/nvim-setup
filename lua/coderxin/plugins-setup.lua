-- Auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim and installs/updates/removes plugins
-- Is triggered when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- Import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- Plugins to install
return packer.startup(function(use)
  -- package management (packer can manage itself)
  use("wbthomason/packer.nvim")

  -- makes nvim faster
  use("lewis6991/impatient.nvim")

  -- lua functions
  use("nvim-lua/plenary.nvim")

  -- navigation between tmux panes and vim splits
  use("christoomey/vim-tmux-navigator")

  -- colorscheme
  use({
    "sainnhe/edge",
    config = function()
      vim.cmd("set termguicolors")
      vim.cmd("colorscheme edge")
    end
  })

  -- bufferline buffers and tabs
  use({
    "akinsho/bufferline.nvim",
    tag = "v3.*",
    requires = "nvim-tree/nvim-web-devicons"
  })

  -- pretty list for showing diagnostics, references, etc
  use({
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({ icons = false })
    end
  })

  -- lsp setup
  use("neovim/nvim-lspconfig")
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    requires = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"saadparwaiz1/cmp_luasnip"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-nvim-lua"},

      -- Snippets
      {"L3MON4D3/LuaSnip"},
      {"rafamadriz/friendly-snippets"},
    }
  })

  -- Status of LSP progress
  use("j-hui/fidget.nvim")
  -- Rust specific tools
  use("simrat39/rust-tools.nvim")

  -- Debugging
  use("mfussenegger/nvim-dap")

  -- Autopairs & Formatting & Identation
  use("windwp/nvim-autopairs")
  use("tpope/vim-surround")
  use("lukas-reineke/indent-blankline.nvim")

  -- Comments
  use("numToStr/Comment.nvim")
  use("folke/todo-comments.nvim")

  -- Automatically highlighting other uses of the word
  use("RRethy/vim-illuminate")

  -- Nvim diagnostics
  use("dstein64/vim-startuptime")

  -- configurations and abstraction layer
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  })

  -- shows the context of the currently visible buffer contents (ex: function signature)
  use("nvim-treesitter/nvim-treesitter-context")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- vs-code like icons
  use("lambdalisue/nerdfont.vim")
  use("nvim-tree/nvim-web-devicons")

  -- Fuzzy finding
  -- dependency for better sorting performance
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  })
  -- telescope fuzzy finder
  use({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x"
  })

  -- statusline
  use("nvim-lualine/lualine.nvim")

  -- copying / pasting text to the os specific clipboard
  use("christoomey/vim-system-copy")

  if packer_bootstrap then
    require("packer").sync()
  end
end)
