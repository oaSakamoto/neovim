return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "folke/neodev.nvim",
      opts = {},
    },
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "lua_ls" })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      opts.handlers = vim.tbl_deep_extend("force",opts.handlers, {
        ["lua_ls"]=function ()
          require("neodev").setup()
          local lspconfig = require("lspconfig")

          local configs = require("lspconfig.configs")
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                  displayCotext = 4,
                },
              },
            },
          })
        end,
      })
    end,
  },
}
