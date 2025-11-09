---
--- Keymaps
---

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode', silent = true })
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window', silent = true })
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window', silent = true })
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window', silent = true })
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window', silent = true })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file', silent = true })
vim.keymap.set('n', '<leader>q', ':bd<CR>', { desc = 'Close file', silent = true })
vim.keymap.set('n', '<leader>Q', ':qa<CR>', { desc = 'Close NeoVim', silent = true })
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'Open/Close File Explorer', silent = true })
vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = '[/] Toggle comment line', silent = true })
vim.keymap.set('v', '<leader>/', 'gc', { remap = true, desc = '[/] Toggle comment block', silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-c>', '"+y', { desc = 'Copy text to clipboard', silent = true })
vim.keymap.set({ 'n', 'x' }, '<C-v>', '"+p', { desc = 'Past text from cliboard', silent = true })
vim.keymap.set({ 'n', 'x' }, 'x', '"_x')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
