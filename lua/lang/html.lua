return{
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        opts = function (_, opts)
            vim.list_extend(opts.ensure_installed, {"html"})
        end
    },
    {
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "html", "emmet_language_server" })
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			opts.handlers = vim.tbl_deep_extend("force", opts.handlers, {
				["html"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.html.setup({
						capabilities = capabilities,
					})
				end,
                ["emmet_language_server"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.emmet_language_server.setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
}
