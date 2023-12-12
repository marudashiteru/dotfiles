return {
  {
    'rust-lang/rust.vim',
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    'simrat39/rust-tools.nvim',
    ft = 'rust',
    config = function ()
      local mason_registry = require("mason-registry")
      local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
      local codelldb_path = codelldb_root .. "adapter/codelldb"
      local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"
      local rt = require('rust-tools')
      rt.setup({
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
          end,
          standalone = true,
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            ["rust_analyzer"] = {
              checkOnSave = { enable = true, command = 'clippy' },
              cargo = { allFeatures = true },
            },
          },
        },
        dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
        },
      })
    end,
  },
}
