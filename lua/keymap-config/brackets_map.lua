local data = require("data.keymap_data")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local pairs_open = data.pairs_open
local pairs_open_same = data.pairs_open_same
local pairs_close = data.pairs_close
local pairs_ = data.pairs

for open, close in pairs(pairs_open) do
    map(
        "i",
        open,
        function()
            if (vim.bo.filetype == "cpp" or vim.bo.filetype == "hpp" or vim.bo.filetype == "c" or vim.bo.filetype == "h") and open == "<" then
                return open
            end

            local line = vim.api.nvim_get_current_line()
            local col = vim.fn.col('.') - 1

            local next_char = line:sub(col + 1, col + 1)

            if next_char == "" or next_char:match("%s") or next_char == close then
                return open .. close .. "<Left>"
            else
                return open
            end
        end,
        { expr = true }
    )
end

for key, char in pairs(pairs_close) do
    map(
        "i",
        key,
        function()
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            row = row - 1
            col = col + 1
            local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

            if line:sub(col, col) == char then
                return "<Right>"
            else
                return key
            end
        end,
        { expr = true }
    )
end

for _, quote in ipairs(pairs_open_same) do
    map(
        "i",
        quote,
        function()
            if vim.bo.filetype == "ps1" and quote == "`" then
                return quote
            end

            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            row = row - 1
            col = col + 1
            local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
            local under = line:sub(col, col)
            local prev = line:sub(col - 1, col - 1)
            local next = line:sub(col + 1, col + 1)

            if under == quote then
                return "<Right>"
            end

            if prev == "\\" then
                return quote
            end

            if under == "" or under:match("%s") or next == quote then
                return quote .. quote .. "<Left>"
            else
                return quote
            end
        end,
        { expr = true }
    )
end

map("i",
    "<BS>",
    function()
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))

        if col == 0 then
            return "<BS>"
        end

        local line = vim.api.nvim_get_current_line()

        -- 光标左边字符
        local left = line:sub(col, col)
        -- 光标右边字符
        local right = line:sub(col + 1, col + 1)

        -- 如果是成对符号并且光标位于中间
        if pairs_[left] == right then
            return "<BS><Del>"
        end
        return "<BS>"
    end,
    { expr = true }
)



