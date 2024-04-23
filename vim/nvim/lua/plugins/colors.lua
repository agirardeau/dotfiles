return {
  { "ellisonleao/gruvbox.nvim" },
  { "tiagovla/tokyodark.nvim" },

  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        -- Set a darker background than the default
        colors.bg = "#16161c"
        colors.bg_dark = "#101018"
      end,
    },
  },
}
