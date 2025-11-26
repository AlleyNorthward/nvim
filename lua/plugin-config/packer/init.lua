require("plugin-config.packer.plugins")
require("plugin-config.packer.bufferline")
require("plugin-config.packer.nvim_tree")
require("plugin-config.packer.nvim_treesitter")
require("plugin-config.packer.mason")
require("plugin-config.packer.cmp")

-- require("plugin-config.packer.lualine") 
local lualine_operation = require("data.plugin_data")
lualine_operation.delete("lualine_data") -- 可选参数:true

local lsp_data = require("data.plugin_data").lsp_data
local servers = lsp_data

for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end











