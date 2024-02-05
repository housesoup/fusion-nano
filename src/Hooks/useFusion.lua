local Inject = require(script.Parent.Parent.Provider).Inject
local Symbols = require(script.Parent.Parent.Symbols)

local function useFusion()
    return Inject(Symbols.FUSION)
end

return useFusion