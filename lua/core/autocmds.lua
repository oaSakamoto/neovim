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
