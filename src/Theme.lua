local class = {}
class.__index = class

function class:get(key: string)

end

function class:__tostring()
    return "NanoTheme"
end

local function Theme()
    local self = setmetatable({

    }, class)

    return self
end

return Theme