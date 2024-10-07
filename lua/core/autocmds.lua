local function is_telescope_visible()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
    if filetype == "TelescopePrompt" then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({"CursorMoved","CursorMovedI", "InsertChange","DiagnosticChanged","InsertEnter", "InsertLeave"}, {
    desc = "Center cursor",
    group = vim.api.nvim_create_augroup("CenterCursor", { clear = true }),
    callback = function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local column = vim.api.nvim_win_get_cursor(0)[2]
        local mode = vim.fn.mode(1)
        if is_telescope_visible() then
            return
        end
        if mode == "i" then
            vim.cmd('normal! zz')
            vim.api.nvim_win_set_cursor(0, {line, column})
            return
        end

        if line ~= vim.b.last_line then
            vim.cmd('normal! zz')
        end
    end
})
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {'docker-compose.yaml','docker-compose.yml','compose.yaml', 'compose.yml'},
  callback = function()
    vim.bo.filetype = "yaml.docker-compose"
  end
})

-- ftplugin
-- typescript
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'typescript',
    callback = function ()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'typescriptreact',
    callback = function ()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'norg',
    callback = function ()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.keymap.set('n', '<leader>nt', ':Neorg toc right<CR>', {
            buffer = 0,  -- Aplica apenas ao buffer atual
            silent = true,
            noremap = true,
            desc = "Neorg: Abrir índice à direita"
        })

        vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { buffer=0, noremap=true, expr = true, silent = true })
        vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { buffer=0, noremap=true, expr = true, silent = true })
    end
})
