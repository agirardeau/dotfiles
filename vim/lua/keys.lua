local utils = require("utils")

vim.g.mapleader = " "

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
utils.noremap("<leader>ff", ":Telescope find_files<CR>")
utils.noremap("<leader>fg", ":Telescope live_grep<CR>")
utils.noremap("<leader>fb", ":Telescope buffers<CR>")
utils.noremap("<leader>fh", ":Telescope help_tags<CR>")
utils.noremap("<leader>ft", ":Telescope treesitter<CR>")
utils.noremap("<leader>fi", ":Telescope builtin<CR>")
utils.noremap("<leader>fp", ":Telescope pickers<CR>")
utils.noremap("<leader>fc", ":Telescope commands<CR>")
utils.noremap("<leader>fq", ":Telescope quickfix<CR>")
utils.noremap("<leader>fx", ":Telescope oldfiles<CR>")
utils.noremap("<leader>fh", ":Telescope command_history<CR>")
utils.noremap("<leader>fs", ":Telescope search_history<CR>")
---- Note: the following would be a better way to configure telescope, but
-- it throws an error due to trying to require 'telescope' before the
-- plugin is loaded. The `module = 'telescope'` line in plugins/init.lua
-- is supposed to fix that but it doesn't for me. Maybe try again after
-- updating to neovim 0.8.
--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
