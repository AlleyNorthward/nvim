local module = {}
local colorscheme = require("data.colors_data").colorscheme_data

local themeType = colorscheme[1]
module.current_theme = themeType

local cmd = "colorscheme "..themeType
local status_ok, _ = pcall(vim.cmd, cmd)

if not status_ok then
    vim.notify(cmd.."没有找到!")
    return
end

return module








