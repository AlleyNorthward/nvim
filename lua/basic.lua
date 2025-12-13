local g = vim.g
local o = vim.opt
local wo = vim.wo
local bo = vim.bo

-- 全局配置

-- utf8
g.encoding = "UTF-8"
-- 自动补全不自动选中
g.completeopt = "menu, menuone, noselect, noinsert"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- utf8
o.fileencoding = 'utf-8'
-- jkhl 移动时光标周围保留12行
o.scrolloff = 12
o.sidescrolloff = 12
-- 搜索大小写不敏感, 除非包含大写
o.ignorecase = true
o.smartcase = true
-- 搜索不要高亮
o.hlsearch = false
-- 边输入边搜索
o.incsearch = true
-- 命令行高为2, 提供足够的显示空间
o.cmdheight = 2
-- 鼠标支持
o.mouse = "a"
-- 允许隐藏被修改过的buffer
o.hidden = true
-- 禁止创建备份文件
o.backup = false
o.writebackup = false
o.swapfile = false
-- smaller updatetime
o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500ms, 可根据需要设置
o.timeoutlen = 500
-- split window 从下边和右边出现
o.splitbelow = true
o.splitright = true
-- 补全增强
o.wildmenu = true
-- Don't pass messages to |ins-completin menu|
--vim.o.shortmess = vim.o.shortmess .. 'c'
o.shortmess:append("c")
-- 补全最多显示10行
o.pumheight = 5
-- 样式
o.background = "dark"
o.termguicolors = true

-- 使用相对行号
wo.number = true
wo.relativenumber = true
-- 高亮所在行
wo.cursorline = true
-- 右侧参考线, 超过表示代码太长了, 考虑换行
-- wo.colorcolumn = "80"

-- 不可见字符的显示, 这里只把空格显示为一个点
o.list = true
o.listchars = "space:."

-- 显示左侧图标指示列
-- vim.wo.cursorline = true


-- 缩进, 一个tab等于四个空格
o.tabstop = 2
bo.tabstop = 2
o.softtabstop = 2
o.shiftround = true

-- >> << 时移动长度
o.shiftwidth = 2
bo.shiftwidth = 2
-- 空格代替tab
o.expandtab = true
bo.expandtab = true

-- 新行对齐当前行
o.autoindent = true
bo.autoindent = true
o.smartindent = true

-- 当前文件被外部程序修改时, 自动加载
o.autoread = true
bo.autoread = true

-- 禁止折行
wo.wrap = false

-- 光标在行首尾时<left><right>可以跳到下一行
-- vim.o.whichwrap = '<,>,[,]' -- []代表hl, 测试了不行, 还是就注释掉吧
o.whichwrap = '<,>'

-- vim.opt.termguicolors = true

-- 永远显示 tabline
o.showtabline = 2

-- 换行调整
o.wrap = true
-- o.linebreak = true
-- o.breakindent = true
o.showbreak = "↳"

-- 使用增强状态栏插件后不再需要vim的模式提示
-- vim.o.showmode = false

-- 空行显示
-- vim.opt.fillchars = {
--     eob = " "
-- }
