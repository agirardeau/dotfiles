vim.cmd([[
  source $HOME/.config/nvim/viml/plugins.vim
]])

require("plugins")
require("settings")
require("keys")

vim.cmd([[
  if filereadable($HOME . '/.config/dotfiles/local/vimrc-local')
      source $HOME/.config/dotfiles/local/vimrc-local
  endif
]])

--fas dfjad dfasduipfh afpdhsfjdf fdnkljwenfas dfjad dfasduipfh afpdhsfjdf fdnkljwenfas dfjad dfasduipfh afpdhsfjdf fdnkljwen
