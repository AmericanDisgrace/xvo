--[[
made by AmericanDisgrace (xvo)
https://www.roblox.com/games/9285238704
]]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 9285238704 then
	game:GetService("Players").LocalPlayer:Kick('Executed script intended to run on "Race Clicker".') end
end

--> variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local workspace = game:GetService("Workspace")
local user = game:GetService("Players").LocalPlayer
local function char() return user.Character end

local GuiActive = true
local count = 0
local winFarm = false

local function notify(text, time)
	OrionLib:MakeNotification({
		Name = "Race Clicker",
		Content = text,
		Image = "rbxassetid://4483345998",
		Time = time or 4
	})
end

--> win farm
local function getWins()
	for _,v in pairs(user.leaderstats:GetChildren()) do
		if v.Name:sub(5,8) == "Wins" then
			return v.Value
		end
	end
end

spawn(function()
	while wait() and GuiActive do
		if winFarm then
			local wins = getWins()
			for _,v in pairs(workspace.Environment:GetChildren()) do
				spawn(function()
					firetouchinterest(v.Sign, char().HumanoidRootPart, 1)
					wait()
					firetouchinterest(v.Sign, char().HumanoidRootPart, 0)
				end)
			end
			if wins == getWins() then
				count = count + 1
			else
				count = 0
			end
			if count >= 50 then
				repeat wait() until char():FindFirstChild("HumanoidRootPart")
				wait(1)
				repeat wait() until char():FindFirstChild("HumanoidRootPart")
				char().HumanoidRootPart.CFrame = CFrame.new(Vector3.new(workspace.Lobby.SpawnLocation.SpawnLocation.Position))
				wait(29)
				count = 0
			end
		end
	end
end)

--> GUI
local Window = OrionLib:MakeWindow({Name = "Race Clicker", HidePremium = true, IntroEnabled = false, CloseCallback = function()
	GuiActive = false
	game:GetService("CoreGui").Orion:Destroy()
end})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

local MainSec = Main:AddSection({Name = "Features"})

MainSec:AddToggle({
	Name = "Win Farm",
	Default = winFarm,
	Callback = function(value)
		winFarm = value
		if not value then
			repeat wait() until char():FindFirstChild("HumanoidRootPart")
			char().HumanoidRootPart.CFrame = CFrame.new(Vector3.new(workspace.Lobby.SpawnLocation.SpawnLocation.Position))
		end
	end
})

OrionLib:Init()