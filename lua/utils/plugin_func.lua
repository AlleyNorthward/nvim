local utils = {}

local nvim_tree_status, api = pcall(require, "nvim-tree.api")
if not nvim_tree_status then
    vim.notify("没有nvim-tree模块.", vim.log.levels.INFO)
    return
end

-- 本地实现的局部函数

local function on_tree()
    -- 应用函数:open_file, open_file_v
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_buf_get_name(buf):match("NvimTree_") then
            vim.api.nvim_set_current_win(win)
            break
        end
    end
end


utils.open_file = function()
    api.node.open.edit()
    on_tree()
end

utils.open_file_v = function()
    api.node.open.vertical()
    on_tree()
end

utils.auto_delete_bufferLine = function()
    vim.notify("Quit: esc Continue: <space>")
    local first = true

    while true do
        if first then
            vim.cmd("BufferLinePickClose")
            first = false
        else
            local key = vim.fn.getchar() -- 获取输入
            if key == 27 then
                vim.notify("Exit Success", vim.log.levels.INFO)
                break
            elseif key == 32 then
                vim.cmd("BufferLinePickClose")
            else
                vim.notify("Press Esc to quit of <space> to continue.", vim.log.levels.INFO)
            end
        end
    end
end

utils.auto_delete_bufferLine_two = function()
    vim.notify("Quit: Esc. ", vim.log.levels.INFO)

    while true do
        vim.cmd("BufferLinePickClose")

        local key = vim.fn.getchar()
        if key == 27 then
            vim.notify("Exit Success.", vim.log.levels.INFO)
            break
        else
            local buffer_key = vim.fn.nr2char(key)
            vim.api.nvim_feedkeys(buffer_key, "n", false)
        end
    end
end

return utils
