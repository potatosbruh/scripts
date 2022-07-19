getgenv().oilfarm = false
getgenv().bloodfarm = false
getgenv().mystfarm = false
getgenv().sorrowfarm = false
getgenv().nightfarm = false
getgenv().relicfarm = false
getgenv().flamingsteal = false
getgenv().mechanicalsteal = false
getgenv().heartysteal = false
getgenv().holysteal = false
getgenv().donatesteal = false

function easyTPF(placeCFrame)
	local player = game.Players.LocalPlayer;
	if player.Character then
		player.Character.Head.CFrame = placeCFrame
	end
end

function easyTP(placeCFrame)
	local player = game.Players.LocalPlayer;
	if player.Character then
		player.Character.HumanoidRootPart.CFrame = placeCFrame
	end
end

function flamingOil()
	spawn(function()
		while flamingsteal == true do
			easyTP(game:GetService("Workspace")["flaming oil"].Handle.CFrame)
				wait()
		end
	end)
end

function mechanicalCup()
	spawn(function()
		while mechanicalsteal == true do
			easyTP(game:GetService("Workspace")["mechanical cup"].Handle.CFrame)
				wait()
		end
	end)
end

function heartyCup()
	spawn(function()
		while heartysteal == true do
			easyTP(game:GetService("Workspace")["hearty cup"].Handle.CFrame)
				wait()
		end
	end)
end

function holyCup()
	spawn(function()
		while holysteal == true do
			easyTP(game:GetService("Workspace")["holy cup"].Handle.CFrame)
				wait()
		end
	end)
end

function lagCup()
	spawn(function()
		while lagsteal == true do
			easyTP(game:GetService("Workspace")["lag commander cup"].Handle.CFrame)
				wait()
		end
	end)
end

function donaterCup()
	spawn(function()
		while donatesteal == true do
			easyTP(game:GetService("Workspace").donatercup.Handle.CFrame)
				wait()
		end
	end)
end

function oilCup()
	spawn (function()
		while oilfarm == true do
			easyTPF(game:GetService("Workspace").oil.Handle.CFrame)
				wait()
		end
	end)
end

function bloodCup()
	spawn (function()
		while bloodfarm == true do
			easyTP(game:GetService("Workspace").blood.Handle.CFrame)
				wait()
		end
	end)
end

function mystCup()
	spawn (function()
		while mystfarm == true do
			easyTP(game:GetService("Workspace")["mysterious cup"].Handle.CFrame)
				wait()
		end
	end)
end

function nightEssence()
	spawn (function()
		while nightfarm == true do
			easyTP(game:GetService("Workspace")["nights essence"].Handle.CFrame)
				wait()
		end
	end)
end

function sorrowCup()
	spawn (function()
		while sorrowfarm == true do
			easyTP(game:GetService("Workspace")["sorrow cup"].Handle.CFrame)
				wait()
		end
	end)
end

function relicFarm()
	spawn(function()
		while relicfarm == true do
			easyTP(game:GetService("Workspace")["bday_relic"].Handle.CFrame)
			wait()
			easyTP(game:GetService("Workspace")["mout_relic"].Handle.CFrame)
			wait()
			easyTP(game:GetService("Workspace")["dev relic"].Handle.CFrame)
			wait()
			easyTP(game:GetService("Workspace")["streetfighting_relic"].Handle.CFrame)
			wait()
			easyTP(game:GetService("Workspace")["thevoices_relic"].Handle.CFrame)
			wait()
		end
	end)
end

function tpForge()
    easyTP(game:GetService("Workspace").Forging.anvil.Part.CFrame)
end

function tpNight()
	easyTP(game:GetService("Workspace")["Night's anvil plate"].Part.CFrame)
end

function tpRiver()
	easyTP(game:GetService("Workspace")["Red dimension"].HeartyFall.Red2.CFrame)
end

function tpUpgrade()
	easyTP(game:GetService("Workspace").upgrader.blood.a.CFrame)
end

function tradeCenter()
	easyTP(game:GetService("Workspace")["Reworked_Trade_Center"].Teleport.CFrame)
end

function darkOrb()
	easyTP(game:GetService("Workspace").orb.Part.CFrame)
end

function uselessHole()
	easyTP(game:GetService("Workspace")["The hole"].Part.CFrame)
end

function trader()
	easyTP(game:GetService("Workspace")["Red Tree"].RedTreePortal.CFrame)
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("KiroHub", "GrapeTheme")
local Home = Window:NewTab("Home")
local Tab = Window:NewTab("Autos")
local Tab2 = Window:NewTab("TP's")
local Tab3 = Window:NewTab("Kill Bosses")
local Tab4 = Window:NewTab("Stealing")
local Tab5 = Window:NewTab("Others")

local home = Home:NewSection("Home")
local sec1 = Tab:NewSection("Autos")
local sec2 = Tab2:NewSection("TP's")
local sec3 = Tab3:NewSection("Bosses")
local sec4 = Tab4:NewSection("Stealing Autos")
local sec5 = Tab5:NewSection("Others")


home:NewLabel("do not use dio while using this autos, tps dont work")




--------------------------------------------------------------------------------------- tab 1

sec1:NewToggle("Relic Farm", "This farms RELICS (self explanatory)", function(state)
        getgenv().relicfarm = state
        while state == true do
            relicFarm()
		wait(.3)
    end
end)

sec1:NewToggle("Oil Farm", "farms oil what else do i say", function(state)
        getgenv().oilfarm = state
        while state == true do
            oilCup()
		wait(.3)
    end
end)

sec1:NewToggle("Blood Farm", "farms blood", function(state)
		getgenv().bloodfarm = state
		while state == true do
			bloodCup()
		wait(.3)
	end
end)

sec1:NewToggle("Mysterious Cup Farm", "farms mysterious cups", function(state)
		getgenv().mystfarm = state
		while state == true do
			mystCup()
		wait(.3)
	end
end)

sec1:NewToggle("Sorrow Cup Farm", "farms sorrow cups", function(state)
		getgenv().sorrowfarm = state
		while state == true do
			sorrowCup()
		wait(.3)
	end
end)

sec1:NewToggle("Night Essence Farm", "do i even gotta say it", function(state)
		getgenv().nightfarm = state
		while state == true do
			nightEssence()
		wait(.3)
	end
end)

sec1:NewToggle("adding for scroll on mobile", "omg", function(state)
		while state == true do
			print("omg")
		wait(.3)
	end
end)

------------------------------------------------- tab 2

sec2:NewButton("Forge", "teleports to the forge", function()
    tpForge()
end)

sec2:NewButton("Heart River", "teleports to the hearty river", function()
	tpRiver()
end)

sec2:NewButton("Upgrader", "teleports to the upgrader", function()
	tpUpgrade()
end)

sec2:NewButton("Trade Center", "teleports to the trade center", function()
	tradeCenter()
end)

sec2:NewButton("Dark Orb Creator", "teleports to the dark orb creator", function()
	darkOrb()
end)

sec2:NewButton("Night Essence Creator", "teleports to the night essence creator", function()
	tpNight()
end)

sec2:NewButton("Useless Hole", "teleports to the useless hole", function()
	uselessHole()
end)

sec2:NewButton("Trader (Tree)", "teleports to the tree trader place", function()
	trader()
end)
---------------------------------------------------------------------------------------------------- tab 3

sec3:NewButton("Kill Night Crawler (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace")["night crawler"].Humanoid then
        game:GetService("Workspace")["night crawler"].Humanoid.Health = 0
    end
end)

sec3:NewButton("Kill Crazy Trollge (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace")["crazy trollge"].Humanoid then
        game:GetService("Workspace")["crazy trollge"].Humanoid.Health = 0
    end
end)

sec3:NewButton("Kill Tech Boss (only works in private server)", "kills the boss that is in your private server", function()
    if game:GetService("Workspace").tech.Humanoid then
        game:GetService("Workspace").tech.Humanoid.Health = 0
    end
end)

---------------------------------------------------------------------------------------------------------------------------------------steal tab

sec4:NewToggle("flaming oil steal", "omg", function(state)
		getgenv().flamingsteal = state
		while state == true do
			flamingOil()
		wait(.1)
	end
end)

sec4:NewToggle("mechanical cup steal", "omg", function(state)
		getgenv().mechanicalsteal = state
		while state == true do
			mechanicalCup()
		wait(.1)
	end
end)

sec4:NewToggle("hearty cup steal", "omg", function(state)
		getgenv().heartysteal = state
		while state == true do
			heartyCup()
		wait(.1)
	end
end)

sec4:NewToggle("holy cup steal", "omg", function(state)
		getgenv().holysteal = state
		while state == true do
			holyCup()
		wait(.1)
	end
end)

sec4:NewToggle("donator cup steal", "omg", function(state)
		getgenv().donatesteal = state
		while state == true do
			donaterCup()
		wait(.1)
	end
end)

sec4:NewToggle("lag cup steal", "omg", function(state)
		getgenv().lagsteal = state
		while state == true do
			lagCup()
		wait(.1)
	end
end)

---------------------------------------------------------------------- tab 5

sec5:NewKeybind("Hide UI", "KeybindInfo", Enum.KeyCode.M, function()
	Library:ToggleUI()
end)

sec5:NewButton("Fates Admin", "Injects Fates Admin", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()
end)

sec5:NewButton("Dark Dex", "Injects Dark Dex", function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/potatosbruh/scripts/main/dex%20cuz%20i%20cant%20find%20online/darkdex.lua', true))()
end)

sec5:NewSlider("Walkspeed", "changes ur walkspeed", 200, 5, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

sec5:NewSlider("JumpPower", "changes ur jump power", 500, 25, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
