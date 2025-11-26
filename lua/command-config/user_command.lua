-- 自定义命令

-- 查看lua路径
vim.api.nvim_create_user_command(
    "MyShowPath",
    function()
        vim.notify(vim.inspect(package.path), vim.log.levels.INFO)
    end,
    {}
)


