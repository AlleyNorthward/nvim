local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    vim.notify("没有找到 nvim-treesitter")
    return
end
treesitter.setup({
    -- 安装 language parser
    -- :TSInstallInfo 命令查看支持的语言
    ensure_installed = { 
        "json", 
        "html", 
        "css", 
        "vim", 
        "lua", 
        "javascript", 
        "python", 
        "cpp", 
        "c", 
        "java", 
        "matlab",
        "sql"
    },
    -- 启用代码高亮模块
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
})


-- 默认最后!!
-- 折叠代码块 zc折叠, zo打开
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- 默认不要折叠
vim.opt.foldlevel = 99
