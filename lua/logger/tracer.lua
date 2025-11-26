local log = require('logger.log')

local function uuid()
    return tostring(math.random(0, 2^30))
end

local M = {}

local last_called = {}
local function should_record(id, debounce_s)
    debounce_s = debounce_s or 0.1
    local now = vim.loop.hrtime() / 1e9
    if last_called[id] and (now - last_called[id]) < debounce_s then return false end
    last_called[id] = now
    return true
end

function M.wrap(fn, name)
    local call_uuid = uuid()
    name = name or tostring(fn)
    return function(...)
        if should_record('fn:'..name) then
            local t0 = vim.loop.hrtime()
            log.debug(('ENTER %s id = %s'):format(name, call_uuid), {...})
            local ok, res = pcall(fn, ...)
            local dt = (vim.loop.hrtime() - t0) / 1e6 -- ms
            if ok then
                log.debug(('EXIT %s id = %s dt=%.2fms'):format(name, call_uuid, dt), res)
                return res
            else
                log.error(('ERROR %s id = %s dt=%.2fms'):format(name, call_uuid, dt), res)
                error(res)
            end
        else
            return fn(...)
        end
    end
end

local real_require = require
function M.hook_require()
    package.loaded = package.loaded or {}
    local orig = _G.require
    _G.require = function(name)
        log.info('REQUIRE_START', name)
        local t0 = vim.loop.hrtime()
        local res = orig(name)
        local dt = (vim.loop.hrtime() - t0) / 1e6
        log.info('REQUIRE_END', name, ('%.2fms'):format(dt))
        return res
    end
end

function M.hook_keymap()
    if not vim.keymap or not vim.keymap.set then return end
    local orig = vim.keymap.set
    vim.keymap.set = function(mode, lhs, rhs, opts)
        if type(rhs) == 'function' then
            rhs = M.wrap(rhs, ('keymap:%s:%s'):format(mode, lhs))
        end
        return orig(mode, lhs, rhs, opts)
    end
end

function M.hook_autocmd()
    if not vim.api or not vim.api.nvim_create_autocmd then return end
    local orig = vim.api.nvim_create_autocmd
    vim.api.nvim_create_autocmd = function(events, opts)
        if opts and type(opts.callback) == 'function' then
        opts.callback = M.wrap(opts.callback, ('autocmd:%s'):format(vim.inspect(events)))
        end
        return orig(events, opts)
    end
end

function M.setup(opts)
    opts = opts or {}
    if opts.log_level then log.set_level(opts.log_level) end
    if opts.clear_log then log.clear() end
    if opts.hook_require then M.hook_require() end
    if opts.hook_keymap then M.hook_keymap() end
    if opts.hook_autocmd then M.hook_autocmd() end
    log.info('tracer.setup', opts)
end


return M










