local M = {}

M.get_cursor_chars = function()
  local buf = vim.api.nvim_get_current_buf()

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  col = col + 1

  local line = vim.api.nvim_buf_get_lines(buf, row - 1, row, false)[1] or ""
  local len = #line

  local prev = nil
  if col > 1 then
    prev = line:sub(col - 1, col - 1)
  end

  local next = nil
  if col <= len then
    next = line:sub(col, col)
  end

  return prev, next, col > #line
end

return M












