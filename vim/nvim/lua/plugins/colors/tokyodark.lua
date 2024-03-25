return {
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      custom_highlights = function(highlights, palette)
        -- This doesn't seem to run :/
        return vim.tbl_extend(highlights, {
          Visual = {
            bg = palette.bg_blue,
          },
        })
      end,
    },
  },
}
