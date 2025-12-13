local module = {}
local colorscheme = require("data.colors_data").colorscheme_data

local themeType = colorscheme[1]
module.current_theme = themeType

local theme_name = "colorscheme " .. themeType
local status_ok, _ = pcall(vim.cmd, theme_name)

if not status_ok then
  vim.notify(theme_name .. "没有找到!")
  return
end

return module
