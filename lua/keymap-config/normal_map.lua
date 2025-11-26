local func = require("utils.keymap_func")
local data = require("data.keymap_data")
local comment_map = data.comment_map

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = {noremap = true, silent = true}

-- 一.映射部分
-- (1)s是替换字符, 替换后进入插入模式, 比较鸡肋, 修改的话, 用r比较好.
map("n", "s", "", opts)
-- (2) S是删除一行, 并进入插入模式.有类似的
map("n", "S", "", opts) 
-- (3) L比较奇怪吧, 去末尾, 取消了,可以n+j,可以G
map("n", "L", "", opts)
-- (4) H是去头部, 跟gg类似, 取消了
map("n", "H", "", opts)
-- (5) K是显示某些东西, 这里映射取消了
map("n", "K", "", opts)
-- (6) J是合并一行, 但是感觉之后很少用到, 取消了
map("n", "J", "", opts)

-- 二.分屏相关快捷键这里相关的只用S, 本意是分屏, 其余的是
-- (1) windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opts)
map("n", "sh", ":sp<CR>", opts) 
-- (2) 关闭当前
map("n", "so", "<C-w>c", opts)
-- (3) 关闭其他
map("n", "sc", "<C-w>o", opts)
-- (4) 调整左右比例
map("n", "<C-Left>", ":vertical resize -2<CR>", opts)
map("n", "<C-RIGHT>", ":vertical resize +2<CR>", opts)
map("n", "<A-l>", ":vertical resize +10<CR>", opts)
map("n", "<A-h>", ":vertical resize -10<CR>", opts)
-- (5) 调整上下比例
map("n", "<A-j>", ":resize +2<CR>", opts)
map("n", "<A-k>", ":resize -2<CR>", opts)
map("n", "<C-Down>", ":resize +2<CR>", opts)
map("n", "<C-Up>", ":resize -2<CR>", opts)
-- (6) 等比例
map("n", "<A-e>", "<C-w>=", opts)
-- (7) Alt + hjkl 窗口之间跳转
map("n", "H", "<C-w>h", opts)
map("n", "J", "<C-w>j", opts)
map("n", "K", "<C-w>k", opts)
map("n", "L", "<C-w>l", opts)

-- 三.Terminal模式配置
map("n", "<leader>t", ":sp | terminal<CR>", opts)
map("n", "<leader>vt", ":vsp | terminal<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)
map("t", "H", [[ <C-\><C-N><C-w>h ]], opts)
map("t", "J", [[ <C-\><C-N><C-w>j ]], opts)
map("t", "K", [[ <C-\><C-N><C-w>k ]], opts)
map("t", "L", [[ <C-\><C-N><C-w>l ]], opts)

-- 四.Visule模式下快捷键
-- (1) visual模式下缩进代码
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- (2) 上下移动选中文本
map("v", "<C-j>", ":move '>+1<CR>gv-gv", opts)
map("v", "<C-k>", ":move '<-2<CR>gv-gv", opts)

-- 五.代码阅读
-- (1) ctrl u ctrl d  翻滚
map("n", "<C-u>", "9k", opts)
map("n", "<C-d>", "9j", opts)

-- 六. 其它配置
-- 在visual模式里粘贴不要复制
map("v", "p", '"_dp', opts)

-- 全屏复制(复制到粘贴板中)
map("n", "SY", "ggVG\"+y", opts)
-- 粘贴粘贴板内容
map("n", "SP", "\"+p", opts)

-- 注释相关按键绑定
map("n", "<C-_>", function() func.smart_comment_mode_n(comment_map) end, opts)
map("i", "<C-_>", function() func.smart_comment_mode_i(comment_map) end, opts)
-- 回车后, 自动匹配
map("i", "<CR>", func.CR_map, {expr = true})













