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
  function(opts)
    local pram = opts.args ~= "" and opts.args or "";

    local emsp = "&emsp;"
    local author = "@author 巷北"
    local time = "@time "
    local real_time = os.date("%Y-%m-%d %H:%M:%S")

    local lines
    if pram == "" then
      lines = {
        string.format("%s%s%s  ", emsp, emsp, author),
        string.format("%s%s%s%s  ", emsp, emsp, time, real_time),
        ""
      }
    else
      lines = {
        string.format("%s  ", author),
        string.format("%s%s  ", time, real_time),
        ""
      }
    end

    vim.api.nvim_put(lines, 'c', true, true)
  end,
  { nargs = "?" }
)

vim.api.nvim_create_user_command(
  'GenerateCodeBlock',
  function(opts)
    local pram = opts.args
    local block = "~~~"
    local lines = {
      "",
      string.format("%s%s", block, pram),
      "",
      block,
    }
    vim.api.nvim_put(lines, 'c', true, true)

    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_win_set_cursor(0, { row - 1, 0 })
    vim.cmd("startinsert")
  end,
  { nargs = 1 }
)
