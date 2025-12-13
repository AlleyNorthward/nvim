local data = {}

data.comment_map = {
  ["lua"] = "--",
  ["python"] = "#",
  ["cpp"] = "//",
  ["c"] = "//",
  ["javascript"] = "//",
  ["vim"] = '"',
  ["matlab"] = "%"
}

data.pairs_open = {
  ["("] = ")",
  ["["] = "]",
  ["{"] = "}",
  ["<"] = ">",
}

data.pairs_close = {
  [")"] = ")",
  ["]"] = "]",
  ["}"] = "}",
  [">"] = ">",
}

data.pairs_open_same = { '"', "'", "`" }

data.pairs = {
  ["("] = ")",
  ["{"] = "}",
  ["["] = "]",
  ['"'] = '"',
  ["'"] = "'",
  ["`"] = "`",
  ["<"] = ">"
}
return data
