-- local data = require("data/command_data")
-- 注释相关的命令, 取消其行为
vim.api.nvim_create_autocmd(
    "FileType",
    {
        pattern = "*",
        callback = function()
            vim.opt_local.formatoptions = vim.opt_local.formatoptions - { "c", "r", "o" }
        end,
    }
)

-- 一上来默认存在12行
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    pattern = "*",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()

        -- 如果文件是空的（只有 1 行且那行是空）
        local line_count = vim.api.nvim_buf_line_count(buf)
        if line_count ~= 1 then return end

        local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
        if first_line ~= "" then return end

        -- 插入指定数量的空行
        local blank_lines = {}
        for _ = 1, 13 do
            table.insert(blank_lines, "")
        end

        -- 覆盖 buffer
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, blank_lines)
    end,
})

-- vim.api.nvim_create_autocmd(
--     "InsertCharPre",
--     {
--         callback = function()
--             local stack = require("utils/data_structure").stack
--             local pairs_open = data.pairs_open
--             local pairs_open_same = data.pairs_open_open
--             local char = vim.v.char

--             if pairs_open[char] ~= nil then
--                 stack:push(char)
--             end
--         end
--     }
-- )

















