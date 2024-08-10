local Orion = require(script.Parent.Orion)
local ExecCode = "print('Hello World!')"
coroutine.wrap(function()
    while wait() do
        script.Name = game.HttpService:GenerateGUID(true)
    end
end)()

coroutine.wrap(function()
    while wait() do
        script.Parent.Name = game.HttpService:GenerateGUID(true)
    end
end)()

coroutine.wrap(function()
    while wait() do
        script.Parent.Parent.Name = game.HttpService:GenerateGUID(true)
    end
end)()

local Window = Orion:MakeWindow({
    Name = "Project Alpha", 
    HidePremium = true, 
    SaveConfig = false, 
    ConfigFolder = nil
})
Window:SetBackgroundID(script.Parent.BackgroundId.Value)

local Executor = Window:MakeTab({
    Icon = "terminal",
    Name = "Executor",
    PremiumOnly = false
})

local ScriptLib = Window:MakeTab({
    Icon = "folder",
    Name = "Script Library",
    PremiumOnly = false
})

local Theme = Window:MakeTab({
    Icon = "palette",
    Name = "Themes",
    PremiumOnly = false
})

Theme:AddSection({
    Name = "Theme Colors"
})

local ServerDetails = Executor:AddSection({
    Name = "Executor"
})

local PrimColor = script.Parent.Orion.Primary.Value
local PrimPicker = Theme:AddColorpicker({
    Name = "Primary Color",
    Default = script.Parent.Orion.Primary.Value,
    Callback = function(Value)
        PrimColor = Value
    end
})

local SecColor = script.Parent.Orion.Secondary.Value
local SecPicker = Theme:AddColorpicker({
    Name = "Secondary Color",
    Default = script.Parent.Orion.Secondary.Value,
    Callback = function(Value)
        SecColor = Value
    end
})

local StrokeColor = script.Parent.Orion.Stroke.Value
local StrokePicker = Theme:AddColorpicker({
    Name = "Stroke Color",
    Default = script.Parent.Orion.Stroke.Value,
    Callback = function(Value)
        StrokeColor = Value
    end
})

local DividerColor = script.Parent.Orion.Divider.Value
local DividerPicker = Theme:AddColorpicker({
    Name = "Divider Color",
    Default = script.Parent.Orion.Divider.Value,
    Callback = function(Value)
        DividerColor = Value
    end
})

local TextColor = script.Parent.Orion.TextDark.Value
local TextPicker = Theme:AddColorpicker({
    Name = "Text",
    Default = script.Parent.Orion.TextDark.Value,
    Callback = function(Value)
        TextColor = Value
    end
})

local TextDarkColor = script.Parent.Orion.TextDark.Value
local TextDarkPicker = Theme:AddColorpicker({
    Name = "Text (Dark)",
    Default = script.Parent.Orion.TextDark.Value,
    Callback = function(Value)
        TextDarkColor = Value
    end
})

local TextLight = script.Parent.Orion.TextLight.Value
local TextLightPicker = Theme:AddColorpicker({
    Name = "Text (Light)",
    Default = script.Parent.Orion.TextLight.Value,
    Callback = function(Value)
        TextLight = Value
    end
})

local TextLooka = script.Parent.Orion.TextLooka.Value
local TextLookaPicker = Theme:AddColorpicker({
    Name = "Text (Looka)",
    Default = script.Parent.Orion.TextLooka.Value,
    Callback = function(Value)
        TextLooka = Value
    end
})

local BackgroundId = script.Parent.BackgroundId.Value
local BackgroundIdBox = Theme:AddRealTextbox({
    Name = "Background ID for UI (type 'NONE' for default)",
    Default = BackgroundId,
    TextDisappear = false,
    Callback = function(Value)
        BackgroundId = Value
    end
})

Theme:AddDropdown({
    Name = "Theme Templates",
    Options = {"Default", "Blood Moon"},
    Callback = function(Value)
        if Value == "Default" then
            BackgroundIdBox:Set("NONE")
            PrimPicker:Set(Color3.fromRGB(25, 25, 25))
            SecPicker:Set(Color3.fromRGB(32, 32, 32))
            StrokePicker:Set(Color3.fromRGB(60, 60, 60))
            DividerPicker:Set(Color3.fromRGB(60, 60, 60))
            TextDarkPicker:Set(Color3.fromRGB(150, 150, 150))
            TextLightPicker:Set(Color3.fromRGB(255, 255, 255))
            TextLookaPicker:Set(Color3.fromRGB(76, 76, 76))
            TextPicker:Set(Color3.fromRGB(240, 240, 240))
        end

        if Value == "Blood Moon" then
            BackgroundIdBox:Set("http://www.roblox.com/asset/?id=18829758242")
            PrimPicker:Set(Color3.fromRGB(25, 25, 25))
            SecPicker:Set(Color3.fromRGB(32, 32, 32))
            StrokePicker:Set(Color3.fromRGB(60, 60, 60))
            DividerPicker:Set(Color3.fromRGB(60, 60, 60))
            TextDarkPicker:Set(Color3.fromRGB(150, 150, 150))
            TextLightPicker:Set(Color3.fromRGB(255, 255, 255))
            TextLookaPicker:Set(Color3.fromRGB(76, 76, 76))
            TextPicker:Set(Color3.fromRGB(240, 240, 240))
        end
    end
})

Theme:AddSection({
    Name = "Controls"
})

local SaveTheme = Theme:AddButton({
    Name = "Load Theme",
    Callback = function()
        Window:DestroyEntire()
        script.Parent.ReloadUI:FireServer(PrimColor, SecColor, StrokeColor, DividerColor, TextLight, TextDarkColor, TextLooka, BackgroundId, TextColor)
        script.Parent.Parent:Destroy()
    end,
})

local ExecBox = Executor:AddTextbox({
    Name = " ",
    Default = "print('Hello World!')",
    TextDisappear = false,
    Callback = function(Value)
        ExecCode = Value
    end
})

local Execute = Executor:AddButton({
    Name = "Execute",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(ExecCode),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Announcement Panel",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(17628095171)('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "HD Admin Ranker",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(7192763922).load('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Mustard Gas",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(2989312214).load('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "TopKek v3",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(2609384717).load('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Eazy Gui (RARE)",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(0x459780537):eazyontop('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Btools",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(16635856261)(game.Players['%s'])", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Explosives (C to detonate)",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("require(18379867953)('%s')", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

ScriptLib:AddButton({
    Name = "Clown Kidnap",
    Callback = function()
        Orion:MakeNotification({
            Name = "Execution",
            Content = script.Parent.Exec:InvokeServer(string.format("for i, plr in pairs(game.Players:GetPlayers()) do require(03123450236).kidnap(plr.Name) end", game.Players.LocalPlayer.Name)),
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end,
})

local Orion = game.Players.LocalPlayer.PlayerGui.Orion
while wait() do
    Orion.Name = game.HttpService:GenerateGUID(true)
    for _, des in ipairs(Orion:GetDescendants()) do
        if des.Name ~= "UIListLayout" and des.Name ~= "Ico" and des.Name ~= "Icon" and des.Name ~= "Content" and des.Name ~= "UIStroke" and des.Name ~= "Title" and des.Name ~= "ItemContainer" and des.Name ~= "F" and des.Name ~= "Line" and des.Name ~= "Selected" then
            des.Name = game.HttpService:GenerateGUID(true)
        end
    end
end
