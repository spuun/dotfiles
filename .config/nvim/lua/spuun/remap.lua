vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Pane switching
vim.keymap.set('n', "<c-h>", "<c-w>h", { desc = "Switch to pane to the left" })
vim.keymap.set('n', "<c-j>", "<c-w>j", { desc = "Switch to pane above" })
vim.keymap.set('n', "<c-k>", "<c-w>k", { desc = "Switch to pane below" })
vim.keymap.set('n', "<c-l>", "<c-w>l", { desc = "Switch to pane to the right" })

-- Switch to prev buffer
vim.keymap.set('n', 'åå', '<c-^>', { desc = 'Switch to prev buffer' })

-- git worktree
local ts_wt = require('telescope')
local wt = ts_wt.extensions.git_worktree
vim.keymap.set('n', '<leader>wts', wt.git_worktree, {  desc = 'Switch worktree' })
vim.keymap.set('n', '<leader>wtc', wt.create_git_worktree, {  desc = 'Create worktree' })


-- paste without put selected text into buffer
vim.keymap.set('v', 'p', '"_dp')
