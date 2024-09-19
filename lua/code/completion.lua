return {
    {
        "hrsh7th/nvim-cmp",
        lazy = false,
        priority = 100,
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            {"L3MON4D3/LuaSnip", build = "make install_jsregexp"},
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            require "snippets"
            vim.opt.completeopt = {"menu", "menuone","noselect","popup"}
            vim.opt.shortmess:append "c"

            local lspkind = require "lspkind"
            lspkind.init {}
            
            local cmp = require "cmp"
            cmp.setup {
                sources = {
                    { name = "nvim_lsp"},
                    {name = "luasnip"},
                    { name = "path"},
                },
                
                mapping = {
                    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Isert },
                    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Isert },
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-y>"] = cmp.mapping(
                    cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    },
                    { "i", "c" }
                    ),
                },

                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                }
            }
            local ls = require "luasnip"
            ls.config.set_config {
                history = false,
                updateevents = "TextChanged,TextChangedI",
            }
            vim.keymap.set({"i", "s"},"<C-l>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, {silent = true})

            vim.keymap.set({"i", "s"} , "<C-h>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end,{silent = true })
        end,
    }
}
