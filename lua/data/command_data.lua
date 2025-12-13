local data = {}

data.pairs_open = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
}

data.pairs_open_same = {
  ['"'] = '"',
  ["'"] = "'",
  ["`"] = "`"
}

return data
