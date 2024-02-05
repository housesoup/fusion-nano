local useFusion = require(script.Parent.Parent.Hooks.useFusion)
local Page = require(script.Parent.Page)

local class = {}
class.__index = class

function class:push()
    Page {
        Parent = self._root,
    }
end

function class:pop(result: any)
    
end

function class:popPage(i: number)
    local routes = self._routes:get()
    local pages = self._pages
    i = i or pages[#pages]
    
    -- pop pages
    for p = #pages, i, -1 do
        local page = pages[p]
        
        -- pop routes
        for r = #routes, page, -1 do
            table.remove(routes, r)
        end
    end
end

function class:__tostring()
    return "NanoRouter"
end

local function Router(root: Instance)
    local Fusion = useFusion()
    local Value = Fusion.Value

    local self = setmetatable({
      _root = root,
      _stack = Value({}),
      _pages = {},
    }, class)

    return self
end

return Router