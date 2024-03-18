-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
utils.noremap("<leader> t", ":Tabular /*<CR>")

-- Formatting
utils.noremap("<leader> w", ":set wrap! lbr!<CR>")
utils.noremap("<leader> s", ":syntax off<CR>")

-- Opening split and switching to second buffer
utils.noremap("<leader> v", ":vsp | b2<CR><C-w>h")

-- Yank over ssh/tmux via vim-oscyank
utils.vnoremap("<leader> c", ":OSCYank<CR>")

-- Diagnostics
utils.noremap("<leader>dj", ":lua vim.diagnostic.goto_next()<CR>")
utils.noremap("<leader>dk", ":lua vim.diagnostic.goto_prev()<CR>")

--
