local highlights = require("colors.tokyonightadjusted.highlights")
local terminal = require("colors.tokyonightadjusted.terminal")

local M = {}

function M.colorscheme()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.o.termguicolors = true
    vim.g.colors_name = "tokyonightadjusted"
    highlights.setup()
    terminal.setup()
end

return M

