local function set_python_path(command)
    local path = command.args
    local clients = vim.lsp.get_clients {
        bufnr = vim.api.nvim_get_current_buf(),
        name = 'pyright',
    }
    for _, client in ipairs(clients) do
        if client.settings then
            client.settings.python =
                vim.tbl_deep_extend('force', client.settings.python --[[@as table]], { pythonPath = path })
        else
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings,
                { python = { pythonPath = path } })
        end
        client:notify('workspace/didChangeConfiguration', { settings = nil })
    end
end

return {
    settings = {
        python = {
            --             pythonPath = "E:/Anaconda3/envs/ManimCEV19_0/python.exe",
            analysis = {
                typeCheckingMode = "off"
            }
        }
    },
    on_attach = function(client, bufnr)
        require("keymap-config.keymap_interface").lsp_map.on_attach(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
            local params = {
                command = 'pyright.organizeimports',
                arguments = { vim.uri_from_bufnr(bufnr) },
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            client.request('workspace/executeCommand', params, nil, bufnr)
        end, {
            desc = 'Organize Imports',
        })
        vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
            desc = 'Reconfigure pyright with the provided python path',
            nargs = 1,
            complete = 'file',
        })
    end
}
