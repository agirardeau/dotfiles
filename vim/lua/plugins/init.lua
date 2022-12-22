-- Install packer if it isn't present already
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_first_install = vim.fn.empty(vim.fn.glob(install_path)) > 0
if is_first_install then
  print("Bootstrapping packer...")
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup({function(use)
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'

  -- Luarocks
  use_rocks {
    'penlight',
    'inspect',
  }

  -- Misc
  use 'godlygeek/tabular'
  use 'editorconfig/editorconfig-vim'
  use '907th/vim-auto-save'
  use 'chrisbra/Recover.vim'
  use 'lewis6991/impatient.nvim'

  use {
    'folke/tokyonight.nvim',
    branch = 'main',
    config = function()
      require('plugins.tokyonight')
    end,
  }

  -- Tmux
  use 'tmux-plugins/vim-tmux-focus-events'
  use { 'ojroques/vim-oscyank', branch = 'main' }

  -- Tree-Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    ['do'] = ':TSUpdate',
    config = function()
      require('plugins.nvim-treesitter')
    end,
  }

  -- LSPs
  use 'neovim/nvim-lspconfig' -- Collection of common configurations for the Nvim LSP client
  use {
    'simrat39/rust-tools.nvim', -- Enable more rust-analyzer features, such as inlay hints
    after = 'nvim-lspconfig',
    config = function()
      require('plugins.rust-tools')
    end,
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    branch = 'main',
    config = function()
      require('plugins.cmp')
    end,
    requires = {
      { 'hrsh7th/cmp-nvim-lsp', branch = 'main' },  -- LSP completion source
      { 'hrsh7th/cmp-path', branch = 'main' },      -- Path completion source
      { 'hrsh7th/cmp-buffer', branch = 'main' }     -- Buffer completion source
      --{ 'hrsh7th/cmp-vsnip', branch = 'main' },     -- Snippet completion source
    },
  }

  -- NVim Tree
  use {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      {'nvim-lua/plenary.nvim'},
      --{'BurntSushi/ripgrep'},
      --{'sharkdp/fd'},
      {'nvim-telescope/telescope-fzf-native.nvim'},
    },
    --after = {
    --  'nvim-lspconfig',
    --  'nvim-treesitter',
    --},
    --cmd = 'Telescope',
    --module = 'telescope',  -- Load the plugin on a call like require('telescope.builtin')
    config = function()
      require('plugins.telescope')
    end,
  }

  -- Neorg
  -- Temporarily disable this since I'm not using it much and it's slow on startup. Probably
  -- worth getting lazy loading working for it at some point.
  -- It could be slow to load because the workspace directories are in ~/truehome/notesync/
  -- which is symlinked from its home in /mnt/c/
  --use {
  --  "nvim-neorg/neorg",
  --  -- Don't lazy load so that opening a journal or new todo is always available
  --  --ft = "norg", 
  --  run = ":Neorg sync-parsers",
  --  requires = {
  --    "nvim-lua/plenary.nvim",
  --    "nvim-neorg/neorg-telescope",
  --  },
  --  config = function()
  --    require('plugins.neorg')
  --  end,
  --}

  -- Automatically set up configuration after cloning packer.nvim
  if is_first_install then
    require('packer').sync()
  end
end,
config = {
  profile = {
    enable = true,
    threshold = 1,  -- time in ms that a plugin load must consume to be included in profile
  },
}})

