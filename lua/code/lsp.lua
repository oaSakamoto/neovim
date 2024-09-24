return {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	dependencies = {
		{
			"williamboman/mason.nvim",
			lazy = false,
		},
		{
			"neovim/nvim-lspconfig",
			lazy = false,
		},
	},
	opts = {
		ensure_installed = { "rust_analyzer" },
		handlers = {
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		},
	},

	config = function(_, opts)
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = opts.ensure_installed,
			automatic_installation = true,
		})
		require("mason-lspconfig").setup_handlers(opts.handlers)
        vim.diagnostic.config({
            virtual_text = true, -- Desativa os diagnósticos virtuais (inline)
            signs = true,        -- Desativa os sinais na coluna lateral
            underline = true,    -- Desativa sublinhado em diagnósticos
            update_in_insert = true, -- Não mostra diagnósticos durante inserção
            severity_sort = false,    -- Não ordena por severidade
        })
	end,
}
