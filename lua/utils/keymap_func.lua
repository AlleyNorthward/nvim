local func = require("utils/generic_func")

local utils = {}

-- 本地相关变量
local opts = { noremap = true, silent = true }
-- 本地实现的局部函数

local function add_comment(row, comment_map, move_cursor)
  local file_type = vim.bo.filetype
  local comment = comment_map[file_type] or "#"
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

  local trimmed_line = line:gsub("^%s*", "")
  if trimmed_line:sub(1, #comment) == comment then
    local new_line = line:gsub("^%s*" .. vim.pesc(comment) .. "%s?", "")
    vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })
    if move_cursor then
      vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    end
  else
    local new_line = comment .. " " .. line
    vim.api.nvim_buf_set_lines(0, row, row + 1, false, { new_line })
    if move_cursor then
      vim.api.nvim_win_set_cursor(0, { row + 1, #comment + 1 })
    end
  end
end

local function set_cursor_to_end()
  local buf = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

  for i = #lines, 1, -1 do
    if lines[i] ~= "" then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      vim.cmd("normal! zz")
      return
    end
  end
  vim.cmd("normal! G")
end

local function set_cursor_to_chosed_last_line()
  local buf = 0
  local end_row = vim.api.nvim_buf_get_mark(buf, ">")[1] - 1
  vim.api.nvim_win_set_cursor(0, { end_row + 1, 0 })
end

-- 导出的外键类
utils.smart_comment_mode_n = function(comment_map)
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  add_comment(row, comment_map, true)
end

utils.smart_comment_mode_i = function(comment_map)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
  utils.smart_comment_mode_n(comment_map)
end

utils.smart_comment_mode_v = function(comment_map)
  local buf = 0

  vim.cmd("normal <Esc>")
  local start_row = vim.api.nvim_buf_get_mark(buf, "<")[1] - 1
  local end_row = vim.api.nvim_buf_get_mark(buf, ">")[1] - 1

  for row = start_row, end_row do
    add_comment(row, comment_map, false)
  end
  --     vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
end

utils.CR_map = function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")

  local prev = line:sub(col - 1, col - 1)
  local next = line:sub(col, col)

  local infos = {
    ["("] = ")",
    ["{"] = "}"
  }

  if infos[prev] == next then
    return "<CR><Esc>O"
  end

  return "<CR>"
end

utils.CR_map_ = function()
  -- 这个怎么说呢, 直接用lua接口, 不会自动匹配换行, 上面的vim接口, 可以匹配, 所以还是使用上面的吧.
  local prev, next, _ = func.get_cursor_chars()
  local file_type = vim.bo.filetype
  local infos = {
    ["("] = ")",
    ["{"] = "}"
  }

  if file_type == 'python' then
    return "<CR>"
  end
  if infos[prev] == next then
    return "<CR><Esc>O"
  end
  return "<CR>"
end

utils.G_map = function()
  set_cursor_to_end()
end

utils.smart_easily_comment_mode_i = function()
  vim.cmd("stopinsert")
  vim.cmd("normal gcc")
end

utils.smart_easily_comment_mode_v = function()
  local buf = 0
  vim.cmd("normal gc")
  local end_row = vim.api.nvim_buf_get_mark(buf, ">")[1] - 1
  vim.api.nvim_win_set_cursor(0, { end_row + 1, 0 })
end

utils.copy_mode_n = function()
  vim.cmd("normal! ggVG\"+y")
  set_cursor_to_end()
end

utils.copy_mode_v = function(options)
  if options == 1 then
    vim.cmd("normal! \"+y")
  else
    vim.cmd("normal! y")
  end
  set_cursor_to_chosed_last_line()
end

utils.auto_close = function(open, close)
  local file_type = vim.bo.filetype
  if (file_type == "cpp" or file_type == "hpp" or file_type == "c" or file_type == "h" or file_type == "python") and open == "<" then
    return open
  end

  local line = vim.api.nvim_get_current_line()
  local col = vim.fn.col('.') - 1

  local next_char = line:sub(col + 1, col + 1)

  if next_char == "" or next_char:match("%s") or next_char == close then
    return open .. close .. "<Left>"
  else
    return open
  end
end

utils.auto_move = function(key, char)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col + 1
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]

  if line:sub(col, col) == char then
    return "<Right>"
  else
    return key
  end
end

utils.auto_close_same = function(quote)
  if vim.bo.filetype == "ps1" and quote == "`" then
    return quote
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  col = col + 1
  local line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  local under = line:sub(col, col)
  local prev = line:sub(col - 1, col - 1)

  if under == quote and prev ~= quote then
    return "<Right>"
  elseif under == quote and prev == quote then
    return quote
  end

  if (under == "" or under:match("%s")) and prev ~= quote then
    return quote .. quote .. "<Left>"
  else
    return quote
  end
end

utils.auto_delete = function(pairs_)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  if col == 0 then
    return "<BS>"
  end

  local line = vim.api.nvim_get_current_line()
  local left = line:sub(col, col)
  local right = line:sub(col + 1, col + 1)

  if pairs_[left] == right then
    return "<BS><Del>"
  end
  return "<BS>"
end

utils.new_line = function(n)
  local line_count = vim.api.nvim_buf_line_count(0)
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]

  if cur_line == line_count then
    local empty_lines = {}
    for i = 1, 12 do
      table.insert(empty_lines, "")
    end

    vim.api.nvim_buf_set_lines(0, line_count, line_count, false, empty_lines)
  end
end

return utils
