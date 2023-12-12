local opts = { silent = true, noremap = true }

vim.keymap.set('n', '<F5>', '<cmd>DapContinue<cr>', opts)
vim.keymap.set('n', '<F10>', '<cmd>DapStepOver<cr>', opts)
vim.keymap.set('n', '<F11>', '<cmd>DapStepInto<cr>', opts)
vim.keymap.set('n', '<S-F11>', '<cmd>DapStepOut<cr>', opts)
vim.keymap.set('n', '<Leader>b', '<cmd>DapToggleBreakpoint<cr>', opts)
vim.keymap.set('n', '<Leader>d', require('dapui').toggle, opts)

