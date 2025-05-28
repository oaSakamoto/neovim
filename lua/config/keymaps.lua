local opts = { noremap = true, silent = true }

local g = vim.g
local set = vim.keymap.set

g.mapleader = ' '
g.localleader = ' '
set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'moves lines down in visual selection' })
set('v', 'K', ":m '>-2<CR>gv=gv", { desc = 'moves lines up in visual selection' })

set("n", "J", "mzJ`z")
set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

set("v", "<", "<gv", opts)
set("v", ">", ">gv", opts)

set('n', '<Esc>', '<cmd>nohlsearch<CR>', {desc = "Clear search hl", silent=true})

set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word cursor is on globally" })

-- Executes shell command from in here making file executable
set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

--split management
set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
-- split window vertically
set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
-- split window horizontally
set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
-- close current split window
set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Toggle LSP diagnostics visibility
local isLspDiagnosticsVisible = true
set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP diagnostics" })

