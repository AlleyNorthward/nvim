local tracer = require('logger.tracer')

tracer.setup{
    log_level = 'debug',
    clear_log = true,
    hook_require = true,
    hook_keymap = true,
    hook_autocmd = true
}

vim.api.nvim_create_user_command(
    'MyClear',
    function()
        require('plugin_trace.log').clear()
        vim.notify("plugin_trace log cleared")
    end,
    {}
)














