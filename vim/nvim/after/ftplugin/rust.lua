-- Disable inserting paired `'` character
-- Pretty sure buffer = 0 and buffer = true would be equivalent,
-- only applying to the current file
vim.keymap.set('i', "'", "'", { buffer = 0 })
