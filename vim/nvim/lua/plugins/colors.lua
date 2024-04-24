return {
  {
    "tiagovla/tokyodark.nvim",
    config = function()
      -- Activate as default color scheme as soon as it's configured.
      -- TODO: remove this if it doesn't prevent the issue where the lazy.nvim
      -- window shows up without proper formatting on first load.
      vim.cmd("colorscheme tokyodark")
    end,
  },

  { "ellisonleao/gruvbox.nvim", lazy = true },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      on_colors = function(colors)
        -- Set a darker background than the default
        colors.bg = "#16161c"
        colors.bg_dark = "#101018"
      end,
    },
  },
}
