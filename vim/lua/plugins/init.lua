-- Install packer if it isn't present already
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local is_first_install = vim.fn.empty(vim.fn.glob(install_path)) > 0
if is_first_install then
  print("Bootstrapping packer...")
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
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

  use { 'folke/tokyonight.nvim', branch = 'main' }

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
      {'BurntSushi/ripgrep'},
      {'sharkdp/fd'},
      {'nvim-telescope/telescope-fzf-native.nvim'},
    },
    after = {
      'nvim-lspconfig',
      'nvim-treesitter',
    },
    module = 'telescope',  -- Load the plugin on a call like require('telescope.builtin')
    config = function()
      require('plugins.telescope')
      --require('telescope').setup({
      --  defaults = {
      --    mappings = {
      --      i = {
      --        ['<C-J>'] = 'move_selection_next',
      --        ['<C-K>'] = 'move_selection_previous',
      --        ['<C-E>'] = 'results_scrolling_down',
      --        ['<C-Y>'] = 'results_scrolling_up',
      --      },
      --      n = {
      --        ['<C-[>'] = 'close',
      --        ['<C-E>'] = 'results_scrolling_down',
      --        ['<C-Y>'] = 'results_scrolling_up',
      --      },
      --    },
      --    layout_config = {
      --      horizontal = {
      --        prompt_position = 'top',
      --      },
      --    },
      --  },
      --})
    end,
  }

  -- Automatically set up configuration after cloning packer.nvim
  if is_first_install then
    require('packer').sync()
  end
end)
