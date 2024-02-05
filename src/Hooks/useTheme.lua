local Inject = require(script.Parent.Parent.Provider).Inject
local Symbols = require(script.Parent.Parent.Symbols)

local function useTheme()
    return Inject(Symbols.THEME)
end

return useTheme