return {
cmd = { "lua-language-server" }, -- 如果在 PATH，直接写命令即可
filetypes = { "lua" },
root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'init.lua' }, { upward = true })[1]),
settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";"),
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = { enable = false },
        }
    },
    on_attach = function(client, bufnr)
        require("keymap-config.keymap_interface").lsp_map.on_attach(client, bufnr)
    end
}
