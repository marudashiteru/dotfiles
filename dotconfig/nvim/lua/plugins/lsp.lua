return {
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'folke/neoconf.nvim' },
    config = function ()
      -- neoconfはlspの初期化前にsetupする必要がある
      require("neoconf").setup({})
    end
  },
  {
    'williamboman/mason.nvim',
    config = function ()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function ()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
        },
      })
    end,
    init = function ()
      local capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
      require('mason-lspconfig').setup_handlers({
        function (server)
          local opt = {
            capabilities = capabilities
          }
          require('lspconfig')[server].setup(opt)
        end,
        ["rust_analyzer"] = function() end,
      })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    config = function ()
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function (args)
            vim.fn['vsnip#anonymous'](args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' }
        }),
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-space>"] = cmp.mapping.complete(),
          --["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true })
        }),
        experimental = {
          ghost_text = true,
        },
      })

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        }),
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      toggle_key = '<C-p>',
    },
    config = function(_, opts) require'lsp_signature'.setup(opts) end,
    init = function ()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function (args)
          local buffer = args.buf
          --local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp_signature').on_attach({}, buffer)
        end
      })
    end
  },
}
