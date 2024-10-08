local workspace = "~/.grimorio"
-- function keynormal()
--
-- end
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        lazy = false,
        opts = {
            highlight = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim" },
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {},
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = false,
                        },
                    },
                    ["core.concealer"] = {},
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                grimorio = workspace,
                                projetos = workspace .. "00-projetos",
                                assuntos = workspace .. "01-assuntos",
                                recursos = workspace .. "02-recursos",
                            },
                            default_workspaces = "grimorio",
                            index = "index.norg",
                        },
                    },
                },
            })

        end,
    },
}
