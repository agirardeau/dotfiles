local utils = require("utils")
local which_key = require("which-key")

-- Find
utils.noremap("n", "nzz")

-- Smooth scrolling
utils.noremap("<C-j>", "j<C-e>")
utils.noremap("<C-k>", "k<C-y>")

-- Scrolling with line wrap
utils.noremap("j", "gj")
utils.noremap("k", "gk")

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

-- Misc
which_key.add({ "<leader>m", group = "Misc" })
utils.noremap("<Leader>ms", ":syntax off<CR>")

-- Opening split and switching to second buffer
utils.noremap("<Leader>v", ":vsp | b2<CR><C-w>h")

-- Yank over ssh/tmux via vim-oscyank
utils.vnoremap("<Leader>c", ":OSCYank<CR>")

-- NvimTree
which_key.add({ "<leader>e", group = "NvimTree (disabled?)" })
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
which_key.add({ "<leader>d", group = "Diagnostics" })
vim.keymap.set("n", "<Leader>dj", vim.diagnostic.goto_next, { desc = "Next" })
vim.keymap.set("n", "<Leader>dk", vim.diagnostic.goto_prev, { desc = "Previous" })
vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action, { desc = "Fix" })

-- Telescope
which_key.add({ "<leader>f", group = "Find (Telescope)" })
local ts_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", ts_builtin.find_files, { desc = "Files" })
vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep, { desc = "Grep live" })
vim.keymap.set("n", "<leader>fb", ts_builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", ts_builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>ft", ts_builtin.treesitter, { desc = "Treesitter" })
vim.keymap.set("n", "<leader>fi", ts_builtin.builtin, { desc = "Builtin" })
vim.keymap.set("n", "<leader>fp", ts_builtin.pickers, { desc = "Pickers" })
vim.keymap.set("n", "<leader>fc", ts_builtin.commands, { desc = "Commands" })
vim.keymap.set("n", "<leader>fq", ts_builtin.quickfix, { desc = "Quickfix" })
vim.keymap.set("n", "<leader>fx", ts_builtin.oldfiles, { desc = "Oldfiles" })
-- These two throw errors
--vim.keymap.set("n", "<leader>fm", builtin.command_history, {})
--vim.keymap.set("n", "<leader>fs", builtin.search_history, {})

-- Neorg
which_key.add({ "<leader>o", group = "Neorg (disabled?)" })
utils.noremap("<Leader>ots", ":Neorg toc split<CR>")
utils.noremap("<Leader>oti", ":Neorg toc inline<CR>")
utils.noremap("<Leader>otq", ":Neorg toc toqflist<CR>")

utils.noremap("<Leader>ojn", ":Neorg journal today<CR>")  -- "new"
utils.noremap("<Leader>ojy", ":Neorg journal yesterday<CR>")
utils.noremap("<Leader>ojw", ":Neorg journal tomorrow<CR>")
utils.noremap("<Leader>ojd", ':exec ":Neorg journal custom ".input("date:")<CR>')
--utils.noremap("<Leader>ojtu", ":Neorg journal toc update<CR>")
--utils.noremap("<Leader>ojto", ":Neorg journal toc open<CR>")  -- opens without updating

utils.noremap("<Leader>ogv", ":Neorg gtd views<CR>")  -- "new"
utils.noremap("<Leader>ogc", ":Neorg gtd capture<CR>")  -- "new"
utils.noremap("<Leader>oge", ":Neorg gtd edit<CR>")  -- "new"
