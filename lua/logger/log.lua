-- simple log with levels
local M = {}
M.levels = { debug = 1, info = 2, warn = 3, error = 4 }
M.level = "info"
M.file = vim.fn.stdpath('cache') .. '/plugin_trace.log'


local function write(line)
    local f = io.open(M.file, 'a')
    if not f then
        vim.notify("Failed to open log file:" .. M.file, vim.log.levels.ERROE)
    end
    if f then
        f:write(line .. "\n")
        f:close()
    end
end


function M.set_level(l)
    if M.levels[l] then M.level = l end
end

function M.clear()
    local f = io.open(M.file, 'w')
    if f then f:close() end
end

function M.log(level, ...)
    if M.levels[level] < M.levels[M.level] then return end
    local t = { "[" .. level:upper() .. "]", os.date('%Y-%m-%d %H:%M:%S') }
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(t, vim.inspect(v))
    end
    write(table.concat(t, ' '))
end

function M.debug(...) M.log('debug', ...) end

function M.info(...) M.log('info', ...) end

function M.warn(...) M.log('warn', ...) end

function M.error(...) M.log('error', ...) end

return M
