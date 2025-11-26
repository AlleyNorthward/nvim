local module = {}
local func = require("utils.plugin_func")

local status_api, api = pcall(require, "nvim-tree.api")
if not status_api then
    vim.notify("没有nvim-tree模块.", vim.log.levels.INFO)
    return
end

local map = vim.keymap.set
local opts = {noremap = true, silent = true}


-- (1)bufferline
-- 左右切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opts)
-- 关闭
map("n", "<C-w>", ":Bdelete!<CR>", opts)
-- 灵活关闭 还有一个函数, auto_delete_bufferLine
map("n", "<leader>w", func.auto_delete_bufferLine, opts)

-- (2) nvim-tree
-- alt + m 打开tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opts)

-- 回调函数
module.mapTree = function(bufnr) -- 这里的回调函数, 用1表示吧
    api.config.mappings.default_on_attach(bufnr)

    local usebuffer = {
        buffer = bufnr,
        noremap = true,
        silent = true
    }

    map("n", "L", "<C-w>l", usebuffer)
    map("n", "<a-l>", ":vertical resize +2<cr>", usebuffer)
    map("n", "<a-h>", ":vertical resize -2<cr>", usebuffer)
    -- y 复制相对路径, gy复制绝对路径
    -- 打开文件, 光标在树中

    -- 打开文件, 并且光标在树中
    map("n", "o", func.open_file, usebuffer)
    map("n", "v", func.open_file_v, usebuffer)
end


return module









