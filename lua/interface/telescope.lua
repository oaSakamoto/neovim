return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"ThePrimeagen/harpoon",
				lazy = false,
				branch = "harpoon2",
				dependencies = { "nvim-lua/plenary.nvim" },
			},
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		cmd = "Telescope",
		opts = {
			defaults = {
				initial_mode = "normal",
				prompt_prefix = "   ",
				selection_caret = "  ",
				entry_prefix = "  ",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" },
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
					hidden = true,
					grouped = true,
					display_stat = false,
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						winblend = 15, -- Transparência
						width = 0.8, -- Largura do dropdown
						previewer = false, -- Sem preview para o dropdown
					}),
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			local themes = require("telescope.themes")
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
			local harpoon = require("harpoon")
			local conf = require("telescope.config").values

            harpoon:setup({})
			telescope.setup(opts)
			pcall(telescope.load_extension("file_browser"))
			pcall(telescope.load_extension("ui-select"))


			local function toggle_telescope(harpoon_files)
				local file_paths = vim.tbl_map(function(item) return item.value end, harpoon_files.items)
                local function get_index(tbl, value)
                    for i, v in ipairs(tbl) do
                        if v == value then
                            return i
                        end
                    end
                    return nil  -- Retorna nil se não encontrar o valor
                end
                require("telescope.pickers").new({},themes.get_dropdown({
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                        entry_maker = function(entry)
                            local index = get_index(file_paths, entry)
                            return {
                                value = entry,
                                display = function() return string.format("%d. %s", index, entry) end, 
                                ordinal = entry,
                                index = index,
                            }
                        end,
                    }),
                    previewer = false,
                    sorter = conf.generic_sorter({}),
                })):find()
            end

			
			-- builtin keymaps
			map("n", "<leader>tf", builtin.find_files, { desc = "[T]elescope [F]iles" })
			map("n", "<leader>tk", builtin.keymaps, { desc = "[T]elescope [K]eymaps" })
			map("n", "<leader>th", builtin.help_tags, { desc = "[T]elescope [H]elp" })
			map("n", "<leader>ts", builtin.builtin, { desc = "[T]elescope [S]elect Telescope" })
			map("n", "<leader>tw", builtin.grep_string, { desc = "[T]elescope current [W]ord" })
			map("n", "<leader>tg", builtin.live_grep, { desc = "[T]elescope by [G]rep" })
			map("n", "<leader>td", builtin.diagnostics, { desc = "[T]elescope [D]iagnostics" })
			map("n", "<leader>tr", builtin.resume, { desc = "[T]elescope [R]esume" })
			map("n", "<leader>t.", builtin.oldfiles, { desc = '[T]elescope Recent Files ("." for repeat)' })
			-- Slightly advanced example of overriding default behavior and theme
			map("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
					initial_mode = "insert",
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })
			map("n", "<leader>t/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[T]elescope [/] in Open Files" })
			map("n", "<leader>tn", function()
				builtin.find_files({ cwd = "/home/sakamoto/.dotfiles/neovim" })
			end, { desc = "[T]elescope [N]eovim files" })

			-- telescope file browser
			map("n", "<space>tb", function()
				require("telescope").extensions.file_browser.file_browser()
			end, { desc = "[T]elescope File [Browser]" })

			map("n", "<space>tc", function()
				require("telescope").extensions.file_browser.file_browser({
					path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
					select_buffer = true,
				})
			end, { desc = "[T]elescope File Browser [C]urrent" })

            --harpoon
            map("n", "<leader><leader>", function()
				toggle_telescope(harpoon:list())
			end, { desc = "Open harpoon window" })
			map("n", "<leader>ha", function()
				harpoon:list():add()
			end)
			map("n", "<leader>hr", function()
				harpoon:list():remove()
			end)
            -- map("n", "<leader>(>", function() harpoon:list():select(1) end)
            -- map("n", "<leader>{", function() harpoon:list():select(2) end)
            -- map("n", "<C-[>", function() harpoon:list():select(3) end)
            -- map("n", "<C->", function() harpoon:list():select(4) end)	
		end,
	},
}
