local utils = require("utils")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Find
utils.noremap("n", "nzz")

-- Smooth scrolling
utils.noremap("<C-j>", "j<C-e>")
utils.noremap("<C-k>", "k<C-y>")

-- Scrolling with line wrap
utils.map("j", "gj")
utils.map("k", "gk")

-- Unhighlight
utils.noremap("<C-L>", ":nohl<CR><C-L>")

-- Copy/paste
utils.xnoremap("p", "pgvy")
utils.noremap("x", '"_x')
utils.noremap("s", '"_s')

-- Terminal
utils.tnoremap("<C-[>", "<C-\\><C-N>")
utils.tnoremap("<Esc>", "<C-\\><C-N>")
utils.tnoremap("<C-W>", "<C-\\><C-N><C-W>")

-- Tabular
utils.noremap("<Leader>t", ":Tabular /*<CR>")

-- Formatting
utils.noremap("<Leader>w", ":set wrap! lbr!<CR>")
utils.noremap("<Leader>s", ":syntax off<CR>")

-- Opening split and switching to second buffer
utils.noremap("<Leader>v", ":vsp | b2<CR><C-w>h")

-- Yank over ssh/tmux via vim-oscyank
utils.vnoremap("<Leader>c", ":OSCYank<CR>")

-- NvimTree
utils.noremap("<Leader>ee", ":NvimTreeFocus<CR>")
utils.noremap("<Leader>ef", ":NvimTreeFindFile<CR>")
utils.noremap("<Leader>eg", ":NvimTreeFindFileToggle<CR>")
utils.noremap("<Leader>eu", ":NvimTreeFindFile!<CR>")
utils.noremap("<Leader>ei", ":NvimTreeFindFileToggle!<CR>")
utils.noremap("<Leader>et", ":NvimTreeToggle<CR>")
utils.noremap("<Leader>eo", ":NvimTreeOpen<CR>")
utils.noremap("<Leader>ec", ":NvimTreeClose<CR>")
utils.noremap("<Leader>ek", ":NvimTreeCollapse<CR>")
utils.noremap("<Leader>ej", ":NvimTreeCollapseKeepBuffers<CR>")
utils.noremap("<Leader>er", ":NvimTreeRefresh<CR>")
utils.noremap("<Leader>ep", ":NvimTreeClipboard<CR>")
utils.noremap("<Leader>eh", ":NvimTreeResize -5<CR>")
utils.noremap("<Leader>el", ":NvimTreeResize +5<CR>")

-- Diagnostics
utils.noremap("<Leader>dj", ":lua vim.diagnostic.goto_next()<CR>")
utils.noremap("<Leader>dk", ":lua vim.diagnostic.goto_prev()<CR>")

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fi', builtin.builtin, {})
vim.keymap.set('n', '<leader>fp', builtin.pickers, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fq', builtin.quickfix, {})
vim.keymap.set('n', '<leader>fx', builtin.oldfiles, {})
-- These two throw errors
--vim.keymap.set('n', '<leader>fm', builtin.command_history, {})
--vim.keymap.set('n', '<leader>fs', builtin.search_history, {})

-- Neorg
utils.noremap("<Leader>ots", ":Neorg toc split<CR>")
utils.noremap("<Leader>oti", ":Neorg toc inline<CR>")
utils.noremap("<Leader>otq", ":Neorg toc toqflist<CR>")

utils.noremap("<Leader>ojn", ":Neorg journal today<CR>")  -- "new"
utils.noremap("<Leader>ojy", ":Neorg journal yesterday<CR>")
utils.noremap("<Leader>ojw", ":Neorg journal tomorrow<CR>")
utils.noremap("<Leader>ojd", ':exec ":Neorg journal custom ".input("date:")<CR>')
--utils.noremap("<Leader>ojtu", ':Neorg journal toc update<CR>')
--utils.noremap("<Leader>ojto", ':Neorg journal toc open<CR>')  -- opens without updating

utils.noremap("<Leader>ogv", ":Neorg gtd views<CR>")  -- "new"
utils.noremap("<Leader>ogc", ":Neorg gtd capture<CR>")  -- "new"
utils.noremap("<Leader>oge", ":Neorg gtd edit<CR>")  -- "new"
