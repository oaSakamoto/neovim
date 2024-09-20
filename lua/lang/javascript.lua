return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "javascript" })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "tsserver" })
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			opts.handlers = vim.tbl_deep_extend("force", opts.handlers, {
				["tsserver"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						settings = {
							completions = {
								completeFunctionCalls = true,
							},
						},
					})
				end,
			})
		end,
	},
}
