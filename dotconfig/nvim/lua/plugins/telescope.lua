return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          --coc = {
          --  prefer_locations = true,
          --}
        }
      })
    end,
    init = function ()
      local builtin = require('telescope.builtin')
      local find_all_files = function ()
        builtin.find_files({no_ignore = false, hidden = true})
      end

      -- VSCodeっぽい感じを残しておく
      vim.keymap.set('n', '<C-p>', find_all_files)

      vim.keymap.set('n', '<Leader>ff', builtin.find_files);
      vim.keymap.set('n', '<Leader>fa', find_all_files);
      vim.keymap.set('n', '<Leader>fg', builtin.live_grep);
      vim.keymap.set('n', '<Leader>fb', builtin.buffers);
      vim.keymap.set('n', '<Leader>fh', builtin.help_tags);
    end,
    cond = not vim.g.vscode,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension('fzf')
    end,
    cond = not vim.g.vscode
  },
  {
    'nvim-telescope/telescope-frecency.nvim',
    config = function ()
      require('telescope').load_extension("frecency")
    end,
    cond = not vim.g.vscode,
  },
  --{
  --  'fannheyward/telescope-coc.nvim',
  --  config = function ()
  --    require('telescope').load_extension("coc")
  --  end,
  --  cond = not vim.g.vscode,
  --},
}
