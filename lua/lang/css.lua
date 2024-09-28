return{
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        opts = function (_, opts)
            vim.list_extend(opts.ensure_installed, {"css"})
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "css_variables", "cssls","cssmodules_ls","tailwindcss" })
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            opts.handlers = vim.tbl_deep_extend("force", opts.handlers, {
                ["css_variables"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.css_variables.setup({
                        capabilities = capabilities,
                    })
                end,
                ["cssls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.cssls.setup({
                        capabilities = capabilities,
                    })
                end,
                ["cssmodules_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.cssmodules_ls.setup({
                        capabilities = capabilities,
                    })
                end,
                ["tailwindcss"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tailwindcss.setup({
                        capabilities = capabilities,
                    })
                end,
            })
        end,
    },
}
