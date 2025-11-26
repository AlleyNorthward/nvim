local data = {}

data.lualine_data = {
    "gruvbox",
    "tokyonight",
    "OceanicNext",
    "nord",
    "onedark",
    "nightfox",
}

data.lsp_data = {
    "lua_ls",
    "pyright",
    "clangd",
    "jdtls",
    "sqlls"
}

function data.delete(name, isnotify)
    if data[name] ~= nil then
        data[name] = nil
        if isnotify then
            vim.notify("已删除:"..name, vim.log.levels.INFO)
        end
    else
        vim.notify("不存在:"..name, vim.log.levels.WARN)
    end
end

return data

