local utils = {}

-- 本地相关变量
local opts = {noremap = true, silent = true}
-- 本地实现的局部函数

-- 导出的外键类
utils.smart_comment_mode_n = function(comment_map)
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    local file_type = vim.bo.filetype
    local comment = comment_map[file_type] or "#"
    local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
    local new_line = comment.." "..line
    vim.api.nvim_buf_set_lines(0, row, row + 1, false, {new_line})

    vim.api.nvim_win_set_cursor(0, {row + 1, #comment + 1})
end

utils.smart_comment_mode_i = function(comment_map)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    KeyMapFunc.smart_comment_mode_n()
end

utils.CR_map= function()
    local col = vim.fn.col(".")
    local line = vim.fn.getline(".")

    local prev = line:sub(col - 1, col - 1)
    local next = line:sub(col, col)

    if prev == "(" and next == ")" then
        return "<CR><Esc>O"
    end

    if prev == "{" and next == "}" then
        return "<CR><Esc>O"
    end
    return "<CR>"
end

return utils










