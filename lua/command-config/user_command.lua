-- 自定义命令

-- 查看lua路径
vim.api.nvim_create_user_command(
  "MyShowPath",
  function()
    vim.notify(vim.inspect(package.path), vim.log.levels.INFO)
  end,
  {}
)

vim.api.nvim_create_user_command(
  'WriteAuthorAndTime',
  function()
    local emsp = "&emsp;"
    local author = "@author 巷北"
    local time = "@time "
    local real_time = os.date("%Y-%m-%d %H:%M:%S")
    local lines = {
      string.format("%s%s%s  ", emsp, emsp, author),
      string.format("%s%s%s%s  ", emsp, emsp, time, real_time),
      ""
    }
    vim.api.nvim_put(lines, 'c', true, true)
  end,
  {}
)
