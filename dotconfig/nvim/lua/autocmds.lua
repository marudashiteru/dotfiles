local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 行末スペースの除去
autocmd("BufWritePre", {
  pattern = "*",
  command = ":%s/\\s\\+%//e",
})

-- 改行したときに自動的にコメント行にしない
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- カーソル位置の復元
autocmd("BufReadPost", {
  pattern = "*",
  callback = function ()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end
})

augroup('filetype', { clear = true })

autocmd('FileType', {
  pattern = 'rust',
  group = 'filetype',
  command = 'setlocal ts=4 sts=-1 sw=0 expandtab'
})

autocmd('FileType', {
  pattern = { 'tsv', 'csv' },
  group = 'filetype',
  command = 'setlocal ts=4 sts=-1 sw=0 noexpandtab'
})

