local g = vim.g
local o = vim.opt

g.have_nerd_font = true

o.number = true
o.relativenumber = true
o.termguicolors = true

o.signcolumn = 'yes'
o.colorcolumn = '80'
o.showmode = false
o.inccommand = 'split'

o.splitbelow = true
o.splitright = true

o.wrap = false
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.breakindent = true
o.smartindent = true
o.autoindent = true

o.swapfile = false
o.backup = false
o.undofile = true

o.scrolloff = 999
o.cursorline = true

o.mouse = ''
o.clipboard = ''

o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

o.backspace = { 'start', 'eol', 'indent' }

o.updatetime = 50
o.timeoutlen = 300

o.list = true
o.listchars = { multispace = '» ', trail = '·', nbsp = '␣' }
o.conceallevel = 3
o.concealcursor = 'nvc'

vim.diagnostic.config({
  -- float = true,
})
