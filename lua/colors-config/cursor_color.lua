-- (1) yanking时高亮显示
-- 自定义颜色组
vim.api.nvim_set_hl(
  0,
  'YankColor',
  {
    fg = '#000000',
    bg = '#77ffff',
  }
)

vim.api.nvim_create_autocmd(
  'TextYankPost',
  {
    desc = 'yanking时高亮显示',
    group = vim.api.nvim_create_augroup('autocommand-highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank({
        higroup = 'YankColor',
        timeout = 150,
      })
    end,
  }
)

-- (2) 光标自定义颜色
-- 终端不支持, 所以废弃
vim.opt.guicursor = table.concat({
  "n-v-c:block-Cursor",
  "i-ci-ve:ver25-cursorInsert",
  "r-cr:hor20-CursorReplace",
}, ",")

local function set_cursor_colors()
  if vim.o.background == "dark" then
    vim.api.nvim_set_hl(
      0,
      "Cursor",
      {
        bg = "#ffaa00",
        fg = "#000000"
      }
    )

    vim.api.nvim_set_hl(
      0,
      "CursorInsert",
      {
        bg = "#ffaa00",
        fg = "#000000",
      }
    )

    vim.api.nvim_set_hl(
      0,
      "CursorReplace",
      {
        bg = "#ffaa00",
        fg = "#000000"
      }
    )
  end
end
--set_cursor_colors()
