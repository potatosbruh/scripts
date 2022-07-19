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

loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/rodus", true))() -- put this first above everything (important!)

CreateMain("MANUGUERRA") -- example main

CreateTab("autos") -- example tab

CreateToggle(tabs['autos'], "autofarm oil", "This button is toggleable!",function(state) -- example toggle
            getgenv().oilfarm = state
        while state == true do
            oilCup()
		wait(.3)
	end
end)
