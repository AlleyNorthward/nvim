require("mason").setup()
local lsp_data = require("data.plugin_data").lsp_data
require("mason-lspconfig").setup({
    ensure_installed = lsp_data,
    modifiable = true
})








