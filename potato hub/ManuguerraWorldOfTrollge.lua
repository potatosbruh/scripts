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
getgenv().killnight = false
getgenv().killcrazy = false

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
			easyTP(game:GetService("Workspace").oil.Handle.CFrame)
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

function autokillNight()
	spawn(function()
		while getgenv().killnight == true do
			game:GetService("Workspace")["night crawler"].Humanoid.Health = 0
			wait(1)
		end
	end)
end

function autokillCrazy()
	spawn(function()
		while getgenv().killcrazy == true do
			game:GetService("Workspace")["crazy trollge"].Humanoid.Health = 0
			wait(1)
		end
	end)
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/rodus", true))() -- put this first above everything (important!)

CreateMain("World of Trollge (old autofarms)") -- example main

CreateTab("autos") -- example tab
CreateTab("tps")
CreateTab("auto kill bosses")

CreateToggle(tabs['autos'], "autofarm oil", "This button is toggleable!",function() -- example toggle
            getgenv().oilfarm = toggled
        while toggled == true do
            oilCup()
		wait(.3)
	end
end)

CreateToggle(tabs['autos'], "autofarm blood", "This button is toggleable!",function() -- example toggle
            getgenv().bloodfarm = toggled
        while toggled == true do
            bloodCup()
		wait(.3)
	end
end)

CreateToggle(tabs['autos'], "autofarm mysterious cup", "This button is toggleable!",function() -- example toggle
            getgenv().mystfarm = toggled
        while toggled == true do
            mystCup()
		wait(.3)
	end
end)

CreateToggle(tabs['autos'], "autofarm sorrow cup", "This button is toggleable!",function() -- example toggle
            getgenv().sorrowfarm = toggled
        while toggled == true do
            sorrowCup()
		wait(.3)
	end
end)

CreateToggle(tabs['autos'], "autofarm night essence", "This button is toggleable!",function() -- example toggle
            getgenv().nightfarm = toggled
        while toggled == true do
            nightEssence()
		wait(.3)
	end
end)

CreateButton(tabs['tps'], "Forge", "This button is clickable!",function() -- example button
    tpForge()
end)

CreateButton(tabs['tps'],"Heart River", "teleports to the hearty river", function()
	tpRiver()
end)

CreateButton(tabs['tps'],"Upgrader", "teleports to the upgrader", function()
	tpUpgrade()
end)

CreateButton(tabs['tps'],"Trade Center", "teleports to the trade center", function()
	tradeCenter()
end)

CreateButton(tabs['tps'],"Dark Orb Creator", "teleports to the dark orb creator", function()
	darkOrb()
end)

CreateButton(tabs['tps'],"Night Essence Creator", "teleports to the night essence creator", function()
	tpNight()
end)

CreateButton(tabs['tps'],"Useless Hole", "teleports to the useless hole", function()
	uselessHole()
end)

CreateButton(tabs['tps'],"Trader (Tree)", "teleports to the tree trader place", function()
	trader()
end)

CreateToggle(tabs['auto kill bosses'], "auto kill night crawler", "This button is toggleable!",function() -- example toggle
            getgenv().killnight = toggled
        while toggled == true do
            autokillNight()
		wait(1)
	end
end)

CreateToggle(tabs['auto kill bosses'], "auto kill crazy trollge", "This button is toggleable!",function() -- example toggle
            getgenv().killcrazy = toggled
        while toggled == true do
            autokillCrazy()
		wait(1)
	end
end)
