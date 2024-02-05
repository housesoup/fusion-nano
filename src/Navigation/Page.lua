local useFusion = require(script.Parent.Parent.Hooks.useFusion)

local function Route(props)
    local Fusion = useFusion()
    local New = Fusion.New
    local Children = Fusion.Children

    return New "Frame" {
        BackgroundTransparency = 1,
        Name = "Route",
        Parent = props.Parent,
        Position = props.TransitionOffset,
        Size = UDim2.fromScale(1, 1),
        ZIndex = props.ZIndex,
        [Children] = New "Frame" {
            BackgroundTransparency = 1,
            Name = "Transition",
            Size = UDim2.fromScale(1, 1),
        }
    }
end

return Route