vim.cmd([[
  source $HOME/.config/dotfiles/vim/plugins.vim
  source $HOME/.config/dotfiles/vim/settings.vim
  source $HOME/.config/dotfiles/vim/keys.vim
]])

require("dotfiles.luasettings")

vim.cmd([[
  if filereadable($HOME . '/.config/dotfiles/local/vimrc-local')
      source $HOME/.config/dotfiles/local/vimrc-local
  endif
]])

