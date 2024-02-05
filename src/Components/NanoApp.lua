local Provider = require(script.Parent.Provider)
local Provide = Provider.Provide
local Symbols = require(script.Parent.Symbols)


type NanoConfig = {
    fusion: any,
    theme: any,
    routes: any,
    provide: {[any]: any}?,
}
type NanoSetup = (config: NanoConfig) -> nil
type NanoRender = (setupNano: NanoSetup) -> Instance


local function NanoApp(render: NanoRender): Instance
    return Provider(function()
        -- Provide/inject enabled
        
        return render(function(config)
            Provide(Symbols.FUSION, config.fusion)
            Provide(Symbols.THEME, config.theme)
            
            for key, value in pairs(config.provide) do
                Provide(key, value)
            end
        end)
    end)
end