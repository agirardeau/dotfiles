-- TODO: migrate away from plugin-based color scheme
require("tokyonight.util")
require("tokyonight").setup({
  -- use the night style
  style = "night",
  -- disable italic for keywords
  styles = {
    keywords = { italic = false }
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    local charcoal = "#161616"
    local darker_charcoal = "#121212"
    local darkest_charcoal = "#040404"
    local lighter_charcoal = "#404040"

    colors.bg = charcoal
    colors.bg_dark = darker_charcoal
    colors.terminal_black = darker_charcoal
    colors.bg_dark = darker_charcoal
    colors.comment = "#6A6A6A"
    colors.black = darkest_charcoal
    colors.bg_popup = darker_charcoal
    colors.bg_search = darker_charcoal
    colors.bg_sidebar = darker_charcoal
    colors.bg_visual = lighter_charcoal
  end,
  terminal_colors = true,
})

-- This doesn't work, I don't know why
--vim.api.nvim_set_hl(0, "LineNr", {
--  fg = "#FFFFFF",
--  bg = "#000000",
--  --fg = 0xFFFFFF,
--  --bg = 0x000000,
--  --ctermfg = "#FFFFFF",
--  --ctermbg = "#000000",
--  --guifg = "#FFFFFF",
--  --guibg = "#000000",
--})


