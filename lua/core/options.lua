local g = vim.g
local set = vim.keymap.set

g.mapleader = " "
g.localleader = " "
set({ "n", "v"}, "<Space>", "<Nop>", { silent = true})

local o = vim.opt

o.number = true
o.relativenumber = true
o.signcolumn = "yes"

o.splitbelow = true
o.splitright = true

o.wrap = false

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.clipboard = "unnamedplus"

o.scrolloff = 999
vim.opt.cursorline = true

o.mouse=""
