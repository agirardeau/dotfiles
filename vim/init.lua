vim.cmd([[
  source $HOME/.config/nvim/viml/plugins.vim
  source $HOME/.config/nvim/viml/keys.vim
]])

require("plugins")
require("settings")

vim.cmd([[
  if filereadable($HOME . '/.config/dotfiles/local/vimrc-local')
      source $HOME/.config/dotfiles/local/vimrc-local
  endif
]])

