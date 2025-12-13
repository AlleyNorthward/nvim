-- config
local log_levels = {
  DEBUG = { hl = "Comment" },      -- 灰色
  INFO  = { hl = "Normal" },       -- 默认颜色
  WARN  = { hl = "WarningMsg" },   -- 黄色
  ERROR = { hl = "ErrorMsg" },     -- 红色
}

local function notify(msg, level)
  level = level or "INFO"
  local hl = log_levels[level] and log_levels[level].hl or "Normal"
  vim.api.nvim_echo({ { msg, hl } }, true, {})
end

-- 具体实现

local DebugManager = {}

DebugManager._registry = {}

function DebugManager.register_module(module_name)
  if not DebugManager._registry[module_name] then
    DebugManager._registry[module_name] = {}
  end
end

function DebugManager.set(module_name, key, value)
  DebugManager.register_module(module_name)

  local info = debug.getinfo(2, "Sl")
  DebugManager._registry[module_name][key] = {
    value = value,
    file = info.source,
    line = info.currentline,
    time = os.date("%H:%M:%S")
  }
end

function DebugManager.get(module_name, key)
  DebugManager.register_module(module_name)
  return DebugManager._registry[module_name][key]
end

function DebugManager.delete(module_name, key)
  if DebugManager._registry[module_name] then
    DebugManager._registry[module_name][key] = nil
  end
end

function DebugManager.get_module(module_name)
  DebugManager.register_module(module_name)
  return DebugManager._registry[module_name]
end

function DebugManager.print_all()
  local infos = ""
  for mod, tbl in pairs(DebugManager._registry) do
    infos = infos .. "Module: " .. mod .. "\n"
    for k, info in pairs(tbl) do
      infos = infos .. string.format(
        "%s = %s (at %s, in line %d, time %s)\n",
        k,
        tostring(info.value),
        info.file,
        info.line,
        info.time
      )
    end
    infos = infos .. "\n"
  end
  notify(infos, "DEBUG")
end

function DebugManager.print_module(module_name)
  local infos = ""
  local module = DebugManager.get_module(module_name)
  infos = "Module: " .. module_name .. "\n"
  for k, info in pairs(module) do
    infos = infos .. string.format(
      "%s = %s (at %s, in line %d, time %s)\n",
      k,
      tostring(info.value),
      info.file,
      info.line,
      info.time
    )
  end
  infos = infos .. "\n"
  notify(infos, "DEBUG")
end

return DebugManager
