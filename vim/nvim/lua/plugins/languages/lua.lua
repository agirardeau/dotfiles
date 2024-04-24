return {
  {
    -- Lua settings active for neovim plugin development only.
    "folke/neodev.nvim",
    opts = {
      -- Enable for vim configuration in dotfiles directory.
      override = function(root_dir, library)
        if root_dir:find("/home/andrew/dotfiles/vim", 1, true) == 1 then
          library.enabled = true
          library.plugins = true
        end
      end,
    },
  },
}
