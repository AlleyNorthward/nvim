local interface = {}
local colorscheme_module = require("colors-config.colorscheme")

function interface.get_current_theme()
  return colorscheme_module.current_theme
end

return interface
