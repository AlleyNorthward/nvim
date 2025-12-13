local M = {}
local Stack = {}
Stack.__index = Stack
M.stack = Stack

function Stack.new()
    return setmetatable({stack = {}}, Stack)
end


function Stack:push(v)
    self.stack[#self.stack+1] = v
end

function Stack:pop()
    if #self.stack ==0 then
        return nil
    end

    local v = self.stack[#self.stack]
    self.stack[#self.stack] = nil
    return v
end

function Stack:top()
    return self.stack[#self.stack]
end

function Stack:clear()
    for i = #self.stack, 1, -1 do
        self.stack[i] = nil
    end
end

function Stack:print_infos()
    local parts = {}
    for i = #self.stack, 1, -1 do
        table.insert(parts, tostring(self.stack[i]))
    end
    print(table.concat(parts, " "))
end

return M












