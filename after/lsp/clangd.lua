-- 下面呢, 是我期望能导入文件, 但是很可惜, 似乎无法这么做. 所以, 只能在这个文件里单独写了.

-- local function auto_add_path()
--     local this_path = debug.getinfo(1, "S").source:sub(2, -2):match("(.*[/\\])"):sub(1, -2):match("(.*[/\\])")
--     package.path = package.path
--     ..";"..this_path.."utils\\?.lua"
--     print(this_path)
--     print(package.path)
-- end
-- auto_add_path()

-- local ok, path = pcall(require, "path")
-- if not ok then
--     vim.notify("没有找到path_模块!", vim.log.levels.WARN)
--     return
-- end
-- vim.notify("成功导入path_模块!", vim.log.levels.Info)
local compile = {}
local os_name = jit.os

if os_name == "Windows" then
  compile.cpp1 = "F:/Qt/Qt.6.9/Tools/mingw1310_64/bin/g++.exe"
  compile.cpp2 = "C:/mingw64/bin/g++.exe"
  compile.cpp3 = "E:/StrawberryPerl/c/bin/g++.exe"

  compile.c1 = "F:/Qt/Qt.6.9/Tools/mingw1310_64/bin/gcc.exe"
  compile.c2 = "C:/mingw64/bin/gcc.exe"
  compile.c3 = "E:/StrawberryPerl/c/bin/gcc.exe"
elseif os_name == "Linux" then
  compile.cpp1 = ""

  compile.c1 = ""
elseif os_name == "OSX" then
  compile.cpp1 = ""

  compile.c1 = ""
end

local cpp_compile = compile.cpp1
local c_compile = compile.c1

local function switch_source_header(bufnr, client)
  local method_name = 'textDocument/switchSourceHeader'
  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify(('method %s is not supported by any servers active on the current buffer'):format(method_name))
  end
  local params = vim.lsp.util.make_text_document_params(bufnr)
  ---@diagnostic disable-next-line:param-type-mismatch
  client:request(method_name, params, function(err, result)
    if err then
      error(tostring(err))
    end
    if not result then
      vim.notify('corresponding file cannot be determined')
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end, bufnr)
end

local function symbol_info(bufnr, client)
  local method_name = 'textDocument/symbolInfo'
  ---@diagnostic disable-next-line:param-type-mismatch
  if not client or not client:supports_method(method_name) then
    return vim.notify('Clangd client not found', vim.log.levels.ERROR)
  end
  local win = vim.api.nvim_get_current_win()
  local params = vim.lsp.util.make_position_params(win, client.offset_encoding)
  ---@diagnostic disable-next-line:param-type-mismatch
  client:request(method_name, params, function(err, res)
    if err or #res == 0 then
      -- Clangd always returns an error, there is no reason to parse it
      return
    end
    local container = string.format('container: %s', res[1].containerName) ---@type string
    local name = string.format('name: %s', res[1].name) ---@type string
    vim.lsp.util.open_floating_preview({ name, container }, '', {
      height = 2,
      width = math.max(string.len(name), string.len(container)),
      focusable = false,
      focus = false,
      title = 'Symbol Info',
    })
  end, bufnr)
end

return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--pch-storage=memory",
    "--query-driver=" .. c_compile .. "," .. cpp_compile,
  },
  on_attach = function(client, bufnr)
    require("keymap-config.keymap_interface").lsp_map.on_attach(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdSwitchSourceHeader', function()
      switch_source_header(bufnr, client)
    end, { desc = 'Switch between source/header' })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspClangdShowSymbolInfo', function()
      symbol_info(bufnr, client)
    end, { desc = 'Show symbol info' })
  end
}
