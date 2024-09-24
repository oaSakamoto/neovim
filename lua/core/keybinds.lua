local wk = require "which-key"
local l = "<leader>"

--harpoon keys
local harpoon = require "harpoon"
local harpoon_telescope = require "util.harpoon_telescope".toggle_telescope
local lh = l .. "h"
local lhr = lh .. "r"
wk.add({
    {
        { l .. "h" , group = "Harpoon",},
        { l .. l , function() harpoon_telescope(harpoon:list()) end,  desc = "Open harpoon window"},
        { l .. "(",function() harpoon:list():select(1) end, desc = "First buffer", hidden=true},
        { l .. "{",function() harpoon:list():select(2) end, desc = "Second buffer", hidden=true},
        { l .. "=",function() harpoon:list():select(4) end, desc = "Fourth buffer", hidden=true},
        { l .. "[",function() harpoon:list():select(3) end, desc = "Third buffer", hidden=true},
        { lh .. "a", function() harpoon:list():add() end, desc = "Add buffer", },
        { lh .. "c", function() harpoon:list():clear() end, desc = "Clean list", },
        { lh .. "h", function() harpoon:list():prev() end, desc = "Previous buffer", },
        { lh .. "l", function() harpoon:list():next() end, desc = "Next buffer",},
        { lhr, group = "Replace at"},
        { lhr .. "(", function() harpoon:list():replace_at(1) end, desc = "Replace First buffer",},
        { lhr .. "{", function() harpoon:list():replace_at(2) end, desc = "Replace Second buffer",},
        { lhr .. "[", function() harpoon:list():replace_at(3) end, desc = "Replace Third buffer",},
        { lhr .. "=", function() harpoon:list():replace_at(4) end, desc = "Replace Fourth buffer",},
     },
})

-- lazy git
wk.add({
    { l .. "g", function() vim.cmd("LazyGit") end, desc = "LazyGit" },
})
