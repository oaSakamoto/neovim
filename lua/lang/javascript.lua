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
			vim.list_extend(opts.ensure_installed, { "ts_ls" })
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			opts.handlers = vim.tbl_deep_extend("force", opts.handlers, {
				["ts_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ts_ls.setup({
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
