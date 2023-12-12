local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Docs
  -- アップデートでエラーになるので除外
  -- 'vim-jp/vimdoc-ja',

  {
    'j-hui/fidget.nvim',
    opts = {},
  },

  require("plugins.textobj"),
  require("plugins.operator"),

  -- nvim-tree
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('nvim-tree').setup()
    end,
    init = function ()
      vim.api.nvim_create_user_command('Ex', function () vim.cmd.NvimTreeToggle() end, {})
    end,
    cond = not vim.g.vscode
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {"c", "lua", "vim", "vimdoc", "javascript", "typescript"},
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- coc
  -- require("plugins.coc"),
  -- LSP
  require('plugins.lsp'),

  -- Telescope
  require("plugins.telescope"),

  -- Colorscheme 目についたのを適当に追加
  { 'sainnhe/gruvbox-material' },
  --{ 'kepano/flexoki-neovim', name = 'flexoki' },
  --{ 'ellisonleao/gruvbox.nvim', config = true },
  --{ 'jacoborus/tender.vim' },
  --{ 'patstockwell/vim-monokai-tasty' },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require('lualine').setup({
        options = {
--          theme = 'codedark',
          theme = 'gruvbox-material',
        }
      })
    end,
    cond = not vim.g.vscode,
  },
  {
    'akinsho/bufferline.nvim', version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function ()
      require('bufferline').setup({
        options = {
          mode = "buffer",
        }
      })
    end,
    keys = {
      { '<C-l>', '<cmd>BufferLineCycleNext<CR>', noremap = true, silent = true },
      { '<C-h>', '<cmd>BufferLineCyclePrev<CR>', noremap = true, silent = true },
    },
    cond = vim.g.vscode ~= 1,
  },
  require('plugins.rust'),
  require('plugins.dap'),
})

