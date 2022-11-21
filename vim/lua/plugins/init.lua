-- Install packer if it isn't present already
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Bootstrapping packer...")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_first_install = ensure_packer()

return require('packer').startup(function(use)
  -- Let packer manage itself
  use 'wbthomason/packer.nvim'


  --use {
  --  'nvim-tree/nvim-web-devicons',
  --}

  use {
    'nvim-tree/nvim-tree.lua',
    --requires = { 'nvim-tree/nvim-web-devicons' },  -- optional, for file icons
    setup = function() 
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      require('plugins.nvim-tree')
    end,
  }

  -- Automatically set up configuration after cloning packer.nvim
  if packer_first_install then
    require('packer').sync()
  end
end)
