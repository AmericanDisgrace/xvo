--[[
made by AmericanDisgrace (xvo)
https://www.roblox.com/games/9571238478
]]--

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 9660733037 and game.PlaceId ~= 9571238478 then
	game:GetService("Players").LocalPlayer:Kick('Executed script intended to run on "Raise A Peter".') end
end

--> variables
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local workspace = game:GetService("Workspace")
local user = game:GetService("Players").LocalPlayer
local function char() return user.Character end

local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

local GuiActive = true
local interactables = workspace.Interactables
local peter = interactables.Peter.Peter
local onSpeakers = false
local noHold = false

local function notify(text, time)
	OrionLib:MakeNotification({
		Name = "Raise a Peter",
		Content = text,
		Image = "rbxassetid://4483345998",
		Time = time or 4
	})
end

--> settings
if not isfolder("xvo") then makefolder("xvo") end

local function rewrite(input)
	writefile("xvo/Raise a Peter.txt", HttpService:JSONEncode(input))
end

local settings = {
	moneyFarm = false,
	autoSpeakers = false
}

local function checkFile()
	if isfile("xvo/Raise a Peter.txt") then
		tempSettings = HttpService:JSONDecode(readfile("xvo/Raise a Peter.txt"))
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

--> more load requirements
user.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.Started then
		if syn then
			syn.queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/AmericanDisgrace/xvo/master/Raise%20a%20Peter.lua"))()')
		elseif queue_on_teleport then
			queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/AmericanDisgrace/xvo/master/Raise%20a%20Peter.lua"))()')
		else
			notify("[queue_on_teleport Not Supported] Some features may not work as intended.", 8)
		end
	end
end)

--> money farm
spawn(function()
	while wait() and GuiActive do
		if settings.moneyFarm and not onSpeakers and char():FindFirstChild("HumanoidRootPart") then
			char().HumanoidRootPart.CFrame = peter.Clickable.CFrame
			fireclickdetector(peter.Clickable.DropMoney)
		end
	end
end)

spawn(function()
	while GuiActive do
		if moneyFarm  and char():FindFirstChild("HumanoidRootPart") then
			for _,v in pairs(interactables.MoneyBills:GetChildren()) do
				firetouchinterest(v, char().HumanoidRootPart, 0)
			end
			for _,v in pairs(interactables.BagFolder:GetChildren()) do
				if v.Name == "Bag" then
					firetouchinterest(v, char().HumanoidRootPart, 0)
				end
			end
		end
		wait(3)
	end
end)

--> auto speakers
spawn(function()
	while wait() and GuiActive do
		if settings.autoSpeakers and interactables.Purchasable:FindFirstChild("Speakers") then
			if not interactables.Purchasable.Speakers.OnCooldown.Value then
				onSpeakers = true
				repeat wait() until char():FindFirstChild("HumanoidRootPart")
				repeat
					wait()
					char().HumanoidRootPart.CFrame = CFrame.new(Vector3.new(136, 3, 12))
					fireproximityprompt(interactables.Purchasable.Speakers["Buttons_Screen"].PlayButton.ProximityPrompt, 5)
				until interactables.Purchasable.Speakers.OnCooldown.Value
				onSpeakers = false
			end
		end
	end
end)

--> no hold duration
spawn(function()
	while wait() and GuiActive do
		if noHold then
			for _,v in pairs(workspace:GetDescendants()) do
				if v.ClassName == "ProximityPrompt" then
					if v.HoldDuration ~= 0 then v.HoldDuration = 0 end
				end
			end
		end
	end
end)

--> teleports
local teleports = {
	LivingRoom = {x = 125.135742, y = 3.72332239, z = 50.3492584},
	Kitchen = {x = 105.81398, y = 3.72332239, z = 23.3217278},
	Store = {x = 126.572403, y = 3.49999881, z = 121.62722},
	Cave = {x = -146.77626, y = 3.049999, z = -73.3736954},
	Basement = {x = 172.936, y = -163.669, z = 11},
	MilitaryTent = {x = 154.68, y = 3.2, z = -64.779},
	Garden = {x = 223.869, y = 3.282, z = -21.175},
	Dock = {x = 222.708, y = 3.085, z = 182.033},
	Phone = {x = 113.936, y = 3.723, z = 41.85},
	Computer = {x = 71.264, y = 3.723, z = 14.122}
}

local function teleport(pos)
	if char():FindFirstChild("HumanoidRootPart") then
		char().HumanoidRootPart.CFrame = CFrame.new(pos.x, pos.y, pos.z)
	end
end

--> GUI
local Window = OrionLib:MakeWindow({Name = "Raise a Peter", HidePremium = true, IntroEnabled = false, CloseCallback = function()
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
	Name = "Money Farm",
	Default = settings.moneyFarm,
	Callback = function(value)
		settings.moneyFarm = value
		rewrite(settings)
	end
})

Farms:AddToggle({
	Name = "Auto Speakers",
	Default = settings.autoSpeakers,
	Callback = function(value)
		settings.autoSpeakers = value
		rewrite(settings)
		if value and not interactables.Purchasable:FindFirstChild("Speakers") then
			notify("You need to purchase the speakers upgrade to use this feature.")
		end
	end
})

local Miscellaneous = Main:AddSection({Name = "Miscellaneous"})

Miscellaneous:AddButton({
	Name = "No Hold Duration",
	Callback = function()
		noHold = true
	end
})

local credits = Main:AddSection({Name = "Script made by AmericanDisgrace"})

credits:AddButton({
	Name = "Copy Discord Link",
	Callback = function()
		setclipboard("https://discord.gg/F52PJez25B")
		notify("Copied Discord Link")
	end
})

local Teleports = Window:MakeTab({
	Name = "Teleports",
	Icon = "rbxassetid://5012544693",
	PremiumOnly = false
})

--> create teleport buttons
for i,v in pairs(teleports) do
	if i == "LivingRoom" then 
		Teleports:AddButton({Name = "Living Room", Callback = function() teleport(v) end})
	elseif i == "MilitaryTent" then
		Teleports:AddButton({Name = "Military Tent", Callback = function() teleport(v) end})
	else
		Teleports:AddButton({Name = i, Callback = function() teleport(v) end})
	end
end

OrionLib:Init()