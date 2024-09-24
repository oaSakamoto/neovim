local M = {}

function M.toggle_telescope(harpoon_files)
    local conf = require("telescope.config").values
    local themes = require("telescope.themes")

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
        initial_mode = "normal",
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

return M
