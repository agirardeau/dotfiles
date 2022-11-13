vim.cmd([[
  source $HOME/.config/nvim/viml/plugins.vim
  source $HOME/.config/nvim/viml/settings.vim
  source $HOME/.config/nvim/viml/keys.vim
]])

require("luasettings")

vim.cmd([[
  if filereadable($HOME . '/.config/dotfiles/local/vimrc-local')
      source $HOME/.config/dotfiles/local/vimrc-local
  endif
]])

