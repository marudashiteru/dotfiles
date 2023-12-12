-- クリップボード
vim.opt.shortmess:append("c")
vim.opt.clipboard:append("unnamedplus")

vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
     ["+"] = "win32yank.exe -i --crlf",
     ["*"] = "win32yank.exe -i --crlf",
   },
  paste = {
     ["+"] = "win32yank.exe -o --lf",
     ["*"] = "win32yank.exe -o --lf",
  },
  cache_enabled = 1,
}

-- Leaderキーの設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	title = true,
	backup = false,
	tabstop = 2,
	shiftwidth = 2,
	softtabstop = 2,
	expandtab = true,
	autoindent = true,
	copyindent = true,
	numberwidth = 4,
	wrap = false,
	cursorline = true,
	termguicolors = true,
	guifont = "HackGen Console NF:style=Regular",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

