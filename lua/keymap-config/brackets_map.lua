local data = require("data.keymap_data")
local func = require("utils.keymap_func")

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local pairs_open = data.pairs_open
local pairs_open_same = data.pairs_open_same
local pairs_close = data.pairs_close
local pairs_ = data.pairs

for open, close in pairs(pairs_open) do
  map("i", open, function() return func.auto_close(open, close) end, { expr = true })
end

for key, char in pairs(pairs_close) do
  map("i", key, function() return func.auto_move(key, char) end, { expr = true })
end

for _, quote in ipairs(pairs_open_same) do
  map("i", quote, function() return func.auto_close_same(quote) end, { expr = true })
end

map("i", "<BS>", function() return func.auto_delete(pairs_) end, { expr = true })
