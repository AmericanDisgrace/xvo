--[[
made by AmericanDisgrace (xvo)
https://www.roblox.com/games/9285238704
]]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 9285238704 then
	game:GetService("Players").LocalPlayer:Kick('Executed script intended to run on "Race Clicker".')
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
spawn(function()
	while wait() and GuiActive do
		if winFarm then
			for _,v in pairs(workspace.StageColliders:GetChildren()) do
				spawn(function()
					firetouchinterest(v, char().HumanoidRootPart, 1)
					wait()
					firetouchinterest(v, char().HumanoidRootPart, 0)
				end)
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
	end
})

OrionLib:Init()