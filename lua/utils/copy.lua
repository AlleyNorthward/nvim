local utils = {}

function utils.deepcopy(t)
  if type(t) ~= "table" then
    return t
  end
  local t2 = {}
  for k, v in pairs(t) do
    t2[utils.deepcopy(k)] = utils.deepcopy(v)
  end
  return t2
end

return utils
