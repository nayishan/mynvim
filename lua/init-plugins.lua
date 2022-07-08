-- auto download packer
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- download plugins 
return require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'

  -- lua functions
  use 'nvim-lua/plenary.nvim'
  -- popup windows implementation
  use 'nvim-lua/popup.nvim'
  -- icons for other plugins
  use 'kyazdani42/nvim-web-devicons'
  -- termial integration
  use 'akinsho/nvim-toggleterm.lua'

  -- auto completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  -- 代码段
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- lsp support
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    }
  -- lsp UI staffs
  use 'tami5/lspsaga.nvim'
  -- java lsp
  -- use 'mfussenegger/nvim-jdtls'
  -- debug
  use "ravenxrz/DAPInstall.nvim" -- help us install several debuggers
  use {
    "ravenxrz/nvim-dap",
    commit = "f9480362549e2b50a8616fe4530deaabbc4f889b",
  }
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'
  -- use 'theHamsta/nvim-dap-virtual-text'
  -- treesitter config
  use 'nvim-treesitter/nvim-treesitter'
  -- show scope in code with treesitter
  use 'SmiteshP/nvim-gps'
  -- auto pairs
  use 'windwp/nvim-autopairs'
  -- auto tags
  use 'windwp/nvim-ts-autotag'
  -- surround with
  --use 'blackCauldron7/surround.nvim'
    use 'ur4ltz/surround.nvim'
  -- comment
  use 'numToStr/Comment.nvim'
  -- indent
  use 'lukas-reineke/indent-blankline.nvim'

  -- color scheme
  use 'NTBBloodbath/doom-one.nvim'
  use "projekt0n/github-nvim-theme"
  use 'daschw/leaf.nvim'
  -- status line
  use 'windwp/windline.nvim'
  -- clickable buffer line
  use 'akinsho/nvim-bufferline.lua'
  -- git integration
  use 'lewis6991/gitsigns.nvim'
  -- which-key
  -- use 'folke/which-key.nvim'


  -- file explorer
  use 'kyazdani42/nvim-tree.lua'
  -- fuzzy finder
  use 'nvim-telescope/telescope.nvim'
  -- media file preview extension for telescope
  use 'nvim-telescope/telescope-media-files.nvim'
  --多高亮
  use 'lfv89/vim-interestingwords'
  --symbols
  use 'simrat39/symbols-outline.nvim'
end)
