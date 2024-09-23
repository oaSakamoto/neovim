require("luasnip.session.snippet_collection").clear_snippets "lua"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets ("lua", {
    s("rp" , fmt([[
    return {{
        "{}",
        dependecies = {{{}}},
        lazy = {},
        config = function(_, opts)
            {}
        end,
    }}
    ]], {i(1), i(2), i(3, "false"), i(4)})),
})
