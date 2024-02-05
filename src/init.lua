local NanoApp = require(script.Components.NanoApp)
local Provider = require(script.Components.Provider)
local useFusion = require(script.Hooks.useFusion)
local useRouter = require(script.Hooks.useProvide)
local useTheme = require(script.Hooks.useTheme)

local Nano = {}

Nano.NanoApp = NanoApp
Nano.Provide = Provider.Provide
Nano.Inject = Provider.Inject

Nano.useFusion = useFusion
Nano.useRouter = useRouter
Nano.useTheme = useTheme

return Nano