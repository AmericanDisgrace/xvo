--[[
script made by AmericanDisgrace (xvo)
https://www.roblox.com/games/4951858512
]]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 4951858512 then
	game:GetService("Players").LocalPlayer:Kick('Executed script intended to run on "Victory Race".') end
end

--> variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local workspace = game:GetService("Workspace")
local user = game:GetService("Players").LocalPlayer
local function char() return user.Character end

local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local GuiActive = true

local function notify(text, time)
	OrionLib:MakeNotification({
		Name = "Victory Race",
		Content = text,
		Image = "rbxassetid://4483345998",
		Time = time or 4
	})
end

--> settings
local settings = {
    winFarm = false
}

if not isfolder("xvo") then makefolder("xvo") end

local function rewrite(input)
	writefile("xvo/Victory Race.txt", HttpService:JSONEncode(input))
end

local function checkFile()
	if isfile("xvo/Victory Race.txt") then
		tempSettings = HttpService:JSONDecode(readfile("xvo/Victory Race.txt"))
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

--> win farm
spawn(function()
    while wait() and GuiActive do
        if settings.winFarm then
            for _,v in pairs(workspace:GetChildren()) do
                if v:FindFirstChild("TouchInterest") then
                    spawn(function()
                        firetouchinterest(v, char().HumanoidRootPart, 1)
                        wait()
                        firetouchinterest(v, char().HumanoidRootPart, 0)
                    end)
                end
            end
        end
    end
end)

--> GUI
local Window = OrionLib:MakeWindow({Name = "Victory Race", HidePremium = true, IntroEnabled = false, CloseCallback = function()
	GuiActive = false
	CoreGui.Orion:Destroy()
end})

local Main = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

local Features = Main:AddSection({Name = "Features"})

Features:AddToggle({
	Name = "Win Farm",
	Default = settings.winFarm,
	Callback = function(value)
		settings.winFarm = value
		rewrite(settings)
	end
})

local Credits = Main:AddSection({Name = "Script made by AmericanDisgrace"})

Credits:AddButton({
	Name = "Copy Discord Link",
	Callback = function()
		setclipboard("https://discord.gg/F52PJez25B")
		notify("Copied discord link.")
	end
})

OrionLib:Init()