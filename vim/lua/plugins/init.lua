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

  use 'godlygeek/tabular'
  use 'editorconfig/editorconfig-vim'
  use '907th/vim-auto-save'
  use 'chrisbra/Recover.vim'

  use { 'folke/tokyonight.nvim', branch = 'main' }

  use 'tmux-plugins/vim-tmux-focus-events'
  use { 'ojroques/vim-oscyank', branch = 'main' }

  use { 'nvim-treesitter/nvim-treesitter', ['do'] = ':TSUpdate' }
  use 'neovim/nvim-lspconfig' -- Collection of common configurations for the Nvim LSP client
  use 'simrat39/rust-tools.nvim' -- Enable more rust-analyzer features, such as inlay hints

  -- Completion
  use { 'hrsh7th/nvim-cmp', branch = 'main' }     -- Framework
  use { 'hrsh7th/cmp-nvim-lsp', branch = 'main' } -- LSP completion source
  use { 'hrsh7th/cmp-path', branch = 'main' }     -- Path completion source
  use { 'hrsh7th/cmp-buffer', branch = 'main' }   -- Buffer completion source
  --use {'hrsh7th/cmp-vsnip', branch = 'main' }    -- Snippet completion source

  use {
    'nvim-tree/nvim-tree.lua',
    setup = function() 
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('plugins.nvim-tree')
    end,
  }

  -- Automatically set up configuration after cloning packer.nvim
  if is_first_install then
    require('packer').sync()
  end
end)
