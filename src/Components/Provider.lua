local root = script.Parent
local Symbol = require(root.Packages.Symbol)

local PROVIDE_SYMBOL = Symbol "Provide"
local INJECT_SYMBOL = Symbol "Inject"
local CALLER_LEVEL = 3 -- 3 because of __call

type anyfunc = (...any) -> (...any)
type ValueCascade = {
    [any]: {
        [anyfunc]: {
            value: any
        }
    }
}

local function Provide(key, value)
    coroutine.yield(PROVIDE_SYMBOL, key, value)
end

local function Inject(key, defaultValue)
    return coroutine.yield(INJECT_SYMBOL, key) or defaultValue
end

local function Provider(render, ...)
    local rendererThread = coroutine.create(render)
    local values: ValueCascade = {}
    
    -- Perform rendering
    local args = table.pack(...) --Arguments to pass upon resumption
    while coroutine.status(rendererThread) ~= "dead" do
        args = table.pack(coroutine.resume(rendererThread, table.unpack(args)))
        local ok = table.remove(args, 1)
        assert(ok, "Error rendering in Provider: " .. tostring(args[1]))
        
        if args[1] == PROVIDE_SYMBOL then --Provide
            local _, key, value = table.unpack(args)
            local caller = debug.info(CALLER_LEVEL, "f")
            values[key] = values[key] or {}
            values[key][caller] = {value = value}

        elseif args[1] == INJECT_SYMBOL then --Inject
            local _, key = table.unpack(args)
            local versions = values[key]
            local value = nil

            if versions then
                for level = CALLER_LEVEL, math.huge do
                    local caller = debug.info(level, "f")
                    if caller == nil then
                        break
                    elseif versions[caller] ~= nil then
                        value = versions[caller].value
                    end
                end
            end
            
            args = { value }
        
        else --Done
            break
        end
    end

    -- Rendering complete!
    return table.unpack(args)
end

return setmetatable({
    Provide = Provide,
    Inject = Inject,
}, {
    __call = function(_, render)
        return Provider(render)
    end
})