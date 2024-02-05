local Inject = require(script.Parent.Parent.Provider).Inject
local Symbols = require(script.Parent.Parent.Symbols)

local function useRouter()
    return Inject(Symbols.ROUTER)
end

return useRouter