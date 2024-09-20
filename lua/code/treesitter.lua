return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				lazy = true,
			},
		},
		build = ":TSUpdate",
		lazy = false,
		event = { "BufReadPost", "BufNewFile" },
		---@type TSConfig
		opts = {
			custom_install = {
				-- function()
				--                 local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
				-- 	parser_config.xkb = {
				-- 		install_info = {
				-- 			url = "~/personal/parses_tressitter/tree-sitter-xkb", -- local path or git repo
				-- 			files = { "src/parser.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
				-- 			-- optional entries:
				-- 			-- branch = "main", -- default branch in case of git repo if different from master
				-- 			generate_requires_npm = false, -- if stand-alone parser without npm dependencies
				-- 			requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
				-- 		},
				-- 		filetype = "xkb", -- if filetype does not match the parser name
				-- 	}
				-- end,
			},
			ensure_installed = {
				"bash",
				"dockerfile",
				"markdown",
				"vim",
				"vimdoc",
				"yaml",
				"json",
				"jsonc",
				"scheme",
				-- "xkb",
			},
			auto_install = false,
			ignore_install = {},
			sync_install = false,

			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					scope_incremental = "<leader>sc",
					node_decremental = "<leader>sd",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
						["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
						["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
						["r="] = { query = "@assignment.outer", desc = "Select right hand of an assignment" },

						["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
						["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

						["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@assignment.inner", desc = "Select inner part of a conditional" },

						["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
						["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

						["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
						["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

						["am"] = {
							query = "@function.outer",
							desc = "Select outer part of a method/function definition",
						},
						["im"] = {
							query = "@function.inner",
							desc = "Select inner part of a method/function definition",
						},

						["ac"] = { query = "@class.outer", desc = "Select outer part of class" },
						["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
						["<leader>nm"] = "@function.outer", -- swap function with next
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
						["<leader>pm"] = "@function.outer", -- swap function with previous
					},
				},
				move = {
					enable = true,
					set_jumps = true, -- whether to set jumps in the jumplist
					goto_next_start = {
						[",f"] = { query = "@call.outer", desc = "Next function call start" },
						[",m"] = { query = "@function.outer", desc = "Next method/function def start" },
						[",c"] = { query = "@class.outer", desc = "Next class start" },
                        [",i"] = { query = "@conditional.outer", desc = "Next conditional start" },
						[",l"] = { query = "@loop.outer", desc = "Next loop start" },
					},
					goto_next_end = {
						[",F"] = { query = "@call.outer", desc = "Next function call end" },
						[",M"] = { query = "@function.outer", desc = "Next method/function def end" },
						[",C"] = { query = "@class.outer", desc = "Next class end" },
						[",I"] = { query = "@conditional.outer", desc = "Next conditional end" },
						[",L"] = { query = "@loop.outer", desc = "Next loop end" },
					},
					goto_previous_start = {
						[";f"] = { query = "@call.outer", desc = "Prev function call start" },
						[";m"] = { query = "@function.outer", desc = "Prev method/function def start" },
						[";c"] = { query = "@class.outer", desc = "Prev class start" },
						[";i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
						[";l"] = { query = "@loop.outer", desc = "Prev loop start" },
					},
					goto_previous_end = {
						[";F"] = { query = "@call.outer", desc = "Prev function call end" },
						[";M"] = { query = "@function.outer", desc = "Prev method/function def end" },
						[";C"] = { query = "@class.outer", desc = "Prev class end" },
						[";I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
						[";L"] = { query = "@loop.outer", desc = "Prev loop end" },
					},
				},
			},
			modules = {},
		},

		config = function(_, opts)
			local custom_install = opts.custom_install[1]
			custom_install()
			if type(opts.ensure_installed) == "table" then
				---@type table<string, boolean>
				local added = {}
				opts.ensure_installed = vim.tbl_filter(function(lang)
					if added[lang] then
						return false
					end
					added[lang] = true
					return true
					---@diagnostic disable-next-line: param-type-mismatch
				end, opts.ensure_installed)
			end
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
