--[[
made by AmericanDisgrace (xvo)
https://www.roblox.com/games/7991339063
]]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 8888615802 and game.PlaceId ~= 7991339063 then
	game:GetService("Players").LocalPlayer:Kick('Executed script intended to run on "Rainbow Friends".')
end

--> variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local GuiActive = true

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local user = players.LocalPlayer
local function char() return user.Character end

local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")

local function notify(text)
	OrionLib:MakeNotification({
		Name = "Rainbow Friends",
		Content = text,
		Image = "rbxassetid://4483345998",
		Time = 4
	})
end

--> more load requirements
user.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		if syn then
			syn.queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/AmericanDisgrace/xvo/master/Rainbow%20Friends.lua"))()')
		elseif queue_on_teleport then
			queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/AmericanDisgrace/xvo/master/Rainbow%20Friends.lua"))()')
		else
			notify("[queue_on_teleport Not Supported] Some features may not work as intended.", 8)
		end
	end
end)

if game.PlaceId == 7991339063 then
	notify("Joining game.", 8)
	while wait() do
		char().HumanoidRootPart.CFrame = CFrame.new(Vector3.new(298.5892333984375, 57.64155197143555, -1032.72863769531250))
	end
end

--> settings
if not isfolder("xvo") then makefolder("xvo") end

local function rewrite(input)
	writefile("xvo/Rainbow Friends.txt", HttpService:JSONEncode(input))
end

local settings = {
	coinFarm = false,
	monsterChams = false,
	playerChams = false,
	itemChams = false,
	autoBox = false,
	boxDistance = 50
}

local function checkFile()
	if isfile("xvo/Rainbow Friends.txt") then
		tempSettings = HttpService:JSONDecode(readfile("xvo/Rainbow Friends.txt"))
		if tempSettings == nil or type(tempSettings) ~= "table" then
			return false
		end
		for i,v in pairs(tempSettings) do
			if settings[i] == nil then
				return false
			elseif type(settings[i]) ~= type(v) then
				return false
			end
		end
		return true
	else
		return false
	end
end

if not checkFile() then
	rewrite(settings)
	notify("Rewritten settings file.")
else
	for i,v in pairs(tempSettings) do
		settings[i] = v 
	end
end

--> coin farm
local function touch(part)
	if char():FindFirstChild("HumanoidRootPart") then
		firetouchinterest(part, char().HumanoidRootPart, 1)
		wait()
		firetouchinterest(part, char().HumanoidRootPart, 0)
	end
end

local function isItem(input)
	if input.Name == "Battery" or ((input.Name:find("^Block") or input.Name:find("^Food") or input.Name:find("^Fuse")) and input:IsA("Model")) then
		return true
	end
	return false
end

local function existsItemWorkspace()
	for _,v in pairs(workspace:GetChildren()) do
		if isItem(v) then
			return true
		end
	end
	return false
end

local function existsItemUserBackpack()
	for _,v in pairs(char():GetChildren()) do
		if isItem(v) then
			return true
		end
	end
	return false
end

local function existsItemPlayersBackpack()
	for _,v in pairs(players:GetPlayers()) do
		if v.Character and v ~= user then
			for _,b in pairs(v.Character:GetChildren()) do
				if isItem(b) then
					return true
				end
			end
		end
		if v.Backpack:FindFirstChildWhichIsA("Tool") then
			return true
		end
	end
	return false
end

local function existsItem()
	if existsItemWorkspace() or existsItemUserBackpack() or existsItemPlayersBackpack() then
		return true
	end
	return false
end

local waitToNotify = false
local farming = false
local function finishLevel()
	farming = true
	while wait() and GuiActive do
		if settings.coinFarm then
			for _,v in pairs(workspace:GetChildren()) do
				if isItem(v) then
					if v:FindFirstChild("TouchTrigger") then
						touch(v.TouchTrigger)
					end
				end
			end
			repeat
				touch(workspace.GroupBuildStructures:FindFirstChildOfClass("Model").Trigger)
				if existsItemUserBackpack() then char().Humanoid:UnequipTools() end
			until not user.Backpack:FindFirstChildWhichIsA("Tool") and not existsItemUserBackpack()
			if not existsItemWorkspace() then
				if not existsItemPlayersBackpack() then
					farming = false
				elseif not waitToNotify and GuiActive then
					spawn(function()
						waitToNotify = true
						notify("Waiting for player holding item.")
						wait(4)
						waitToNotify = false
					end)
				end
			end
		end
	end
end

local function coinFarmFunc(value)
	if value then
		spawn(function()
			while wait() and settings.coinFarm and GuiActive do
				if existsItem() and not farming then
					finishLevel()
				end
			end
		end)
		spawn(function()
			local oldBalance = user.PlayerGui.PermanentGUI.Shop.Shop.coinBalance.fill.value.Text:gsub(",", "")
			while wait(1) and settings.coinFarm and GuiActive do
				local newBalance = user.PlayerGui.PermanentGUI.Shop.Shop.coinBalance.fill.value.Text:gsub(",", "")
				if newBalance ~= oldBalance then
					if tonumber(newBalance) - tonumber(oldBalance) == 125 then
						TeleportService:Teleport(7991339063, user)
					else
						oldBalance = newBalance
					end
				end
			end
		end)
	end
end

--> monster chams
local function chamMonsters()
	spawn(function()
		while wait() do
			if not workspace.Monsters:FindFirstChild("Blue") then repeat if not settings.monsterChams or not GuiActive then return end wait() until workspace.Monsters:FindFirstChild("Blue") end
			for _,v in pairs(workspace.Monsters:GetChildren()) do
				if not v:FindFirstChild("Highlight") then
					local highlight = Instance.new("Highlight", v)
					highlight.Adornee = v
					highlight.FillColor = Color3.new(255, 0, 0)
					highlight.FillTransparency = 0.75
					highlight.OutlineTransparency = 1
				end
			end
			if not GuiActive or not settings.monsterChams then
				for _,v in pairs(workspace.Monsters:GetChildren()) do
					if v:FindFirstChild("Highlight") then
						v.Highlight:Destroy()
					end
				end
				break
			end
		end
	end)
end

--> item chams
local function chamItems()
	spawn(function()
		while wait() do
			for _,v in pairs(workspace:GetChildren()) do
				if isItem(v) and not v:FindFirstChild("Highlight") then
					local highlight = Instance.new("Highlight", v)
					highlight.Adornee = v
					highlight.FillColor = Color3.new(255, 255, 255)
					highlight.FillTransparency = 0.75
					highlight.OutlineTransparency = 1
				end
			end
			if not GuiActive or not settings.itemChams then
				for _,v in pairs (workspace:GetChildren()) do
					if isItem(v) and v:FindFirstChild("Highlight") then
						v.Highlight:Destroy()
					end
				end
				break
			end
		end
	end)
end

--> teleports
local locations = {
	Spawn = {x = 189, y = 32, z = 272, place = "In-Map"},
	Showers = {x = 310, y = 31, z = 15, place = "In-Map"},
	Theater = {x = 371, y = 45, z = 155, place = "In-Map"},
	Basement = {x = 376, y = 9, z = 152, place = "In-Map"},
	Office = {x = 318, y = 32, z = 36, place = "In-Map"},
	Museum = {x = 304, y = 38, z = 251, place = "In-Map"},
	Mineshaft = {x = 388, y = 32, z = -7, place = "In-Map"},
	Ladder = {x = 288, y = 32, z = 194, place = "In-Map"},
	Farm = {x = 337, y = 45, z = 206, place = "In-Map"},
	Castle = {x = 483, y = 76, z = 121, place = "In-Map"},
	Ending = {x = -376, y = 18, z = 636, place = "Out-Map"}
}

locations["Waiting Room"] = {x = 20, y = 8, z = 333, place = "Out-Map"}
locations["Security Outpost"] = {x = 295, y = 13, z = 115, place = "In-Map"}
locations["Orange's Hideout"] = {x = 469, y = 60, z = -26, place = "In-Map"}
locations["Security Room"] = {x = 482, y = 60, z = 13, place = "In-Map"}
locations["Woodworking Room"] = {x = 429, y = 51, z = 202, place = "In-Map"}
locations["End Room"] = {x = -1, y = -4, z = 501, place = "Out-Map"}

local function teleport(pos, spot)
	if spot ~= nil and spot ~= "Security Outpost" then
		for _,v in pairs(workspace.Monsters:GetChildren()) do
			if v:FindFirstChild("HumanoidRootPart") then
				if (v.HumanoidRootPart.Position.X - pos.x)^2 + (v.HumanoidRootPart.Position.Y - pos.y)^2 + (v.HumanoidRootPart.Position.Z - pos.z)^2 < 2500 then
					notify("Teleport Failed - Monster near location.")
					return
				end
			end
		end
	end
	if char():FindFirstChild("HumanoidRootPart") then
		char().HumanoidRootPart.CFrame = CFrame.new(pos.x, pos.y, pos.z)
	end
end

--> auto box
local function isBoxed()
	if char():FindFirstChildWhichIsA("Model")["active_box"].root.Weld.Part0.Name == "HumanoidRootPart" then
		return true
	end
	return false
end

local boxing = false
local waitToTP = false
spawn(function()
	while wait() and GuiActive do
		repeat wait() until char()
		if char():FindFirstChildWhichIsA("Model") and settings.autoBox then
			for _,v in pairs(workspace.Monsters:GetChildren()) do
				if v:FindFirstChild("HumanoidRootPart") then
					if (char().HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= settings.boxDistance and not isBoxed() and not boxing then
						spawn(function()
							boxing = true
							firesignal(user.PlayerGui.SurvivorHud.buttons.BoxButton.MouseButton1Down)
							if not isBoxed() then repeat wait() until isBoxed() end
							boxing = false
						end)
					end
					if v.Name == "Blue" or v.Name == "Orange" then
						if v.HumanoidRootPart.ChaseTargetName.Value == user.Name and not waitToTP then
							waitToTP = true
							char().HumanoidRootPart.CFrame = teleport(locations["Security Outpost"])
							notify("TP'd away for protection.")
							spawn(function()
								repeat wait() until v.HumanoidRootPart.ChaseTargetName.Value ~= user.Name
								waitToTP = false
							end)
						end
					end
				end
			end
		end
	end
end)

--> GUI
local Window = OrionLib:MakeWindow({Name = "Rainbow Friends", HidePremium = true, IntroEnabled = false, CloseCallback = function()
	GuiActive = false
	CoreGui.Orion:Destroy()
end})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

local Farms = Main:AddSection({Name = "Farms"})

Farms:AddToggle({
	Name = "Coin Farm",
	Default = settings.coinFarm,
	Callback = function(value)
		settings.coinFarm = value
		coinFarmFunc(value)
		rewrite(settings)
	end
})

local General = Main:AddSection({Name = "General"})

General:AddToggle({
	Name = "Auto Box",
	Default = settings.autoBox,
	Callback = function(value)
		settings.autoBox = value
		rewrite(settings)
	end
})

General:AddSlider({
	Name = "Auto Box Range",
	Min = 0,
	Max = 200,
	Default = settings.boxDistance,
	Color = Color3.fromRGB(0, 0, 0),
	Increment = 1,
	ValueName = "studs",
	Callback = function(value)
		settings.boxDistance = value
		rewrite(settings)
	end    
})

local Credits = Main:AddSection({Name = "Script made by AmericanDisgrace"})

Credits:AddButton({
	Name = "Copy Discord Link",
	Callback = function()
		setclipboard("https://discord.gg/F52PJez25B")
		notify("Copied Discord Link")
	end
})

local Visuals = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

local Chams = Visuals:AddSection({Name = "Chams"})

Chams:AddToggle({
	Name = "Player Chams",
	Default = settings.playerChams,
	Callback = function(value)
		settings.playerChams = value
		rewrite(settings)
		--> player chams
		if value then
			for _,v in pairs(players:GetPlayers()) do
				if v ~= user then
					if not v.Character then repeat wait() until v.Character end
					if not v:FindFirstChild("Highlight") then
						local highlight = Instance.new("Highlight", v.Character)
						highlight.Adornee = v.Character
						highlight.FillColor = Color3.new(0, 0, 255)
						highlight.FillTransparency = 0.75
						highlight.OutlineTransparency = 1
					end
				end
			end
			spawn(function()
				while wait() do
					if not settings.playerChams or not GuiActive then
						for _,v in pairs(players:GetPlayers()) do
							if v.Character then
								if v.Character:FindFirstChild("Highlight") then
									v.Character.Highlight:Destroy()
								end
							end
						end
						return
					end
				end
			end)
		end
	end
})

Chams:AddToggle({
	Name = "Monster Chams",
	Default = settings.monsterChams,
	Callback = function(value)
		settings.monsterChams = value
		rewrite(settings)
		if value then chamMonsters() end
	end
})

Chams:AddToggle({
	Name = "Item Chams",
	Default = settings.itemChams,
	Callback = function(value)
		settings.itemChams = value
		rewrite(settings)
		if value then chamItems() end
	end
})

local teleportsWindow = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

local In_MapTP = teleportsWindow:AddSection({Name = "Inside Map Teleports"})
local Out_MapTP = teleportsWindow:AddSection({Name = "Outside Map Teleports"})

for i,v in pairs(locations) do
	if v.place == "In-Map" then
		In_MapTP:AddButton({Name = i, Callback = function() teleport(v, i) end})
	elseif v.place == "Out-Map" then
		Out_MapTP:AddButton({Name = i, Callback = function() teleport(v, i) end})
	end
end

OrionLib:Init()