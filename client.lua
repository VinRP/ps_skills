--[[
█▀▀█ █░░█ █▀▀█ █▀▀ █▀▀▄ ░▀░ █░█   █▀▀ ▀▀█▀▀ █░░█ █▀▀▄ ░▀░ █▀▀█
█░░█ █▀▀█ █░░█ █▀▀ █░░█ ▀█▀ ▄▀▄   ▀▀█ ░░█░░ █░░█ █░░█ ▀█▀ █░░█
█▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ ▀░░▀ ▀▀▀ ▀░▀   ▀▀▀ ░░▀░░ ░▀▀▀ ▀▀▀░ ▀▀▀ ▀▀▀▀

              PROGRAMADOR: BYBLACKDEATH 
]]--

local pedindex = {}

ESX                             = nil
staminaValue 					= nil
strengthValue 					= nil
shootingValue 					= nil
---------------------------------
------------- CONFIG ------------
---------------------------------

local openKey = 344 -- replace 142 with what button you want
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

---------------------------------
---------------------------------

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(2)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('ps_skills:sendPlayerSkills')
AddEventHandler('ps_skills:sendPlayerSkills', function(stamina, strength, shooting)
	strengthValue = strength
	staminaValue = stamina
	shootingValue = shooting

	StatSetInt("MP0_STRENGTH", round(strength), true)
	StatSetInt("MP0_STAMINA", round(stamina), true)
	StatSetInt('MP0_LUNG_CAPACITY', round(stamina), true)
end)

--===============================================
--==                 VARIABLES                 ==
--===============================================
function EnableGui(enable)
	if staminaValue == nil or strengthValue == nil or shootingValue == nil then
		ESX.TriggerServerCallback('ps_skills:getSkills', function(stamina, strength, shooting)
				strengthValue = strength
				staminaValue = stamina
				shootingValue = shooting

			SendNUIMessage({
				type = "enableui",
				enable = enable,
				strength = strengthValue,
				stamina = staminaValue,
				shooting = shootingValue
			})
		end)
	else
		SetNuiFocus(enable)
		guiEnabled = enable

		SendNUIMessage({
			type = "enableui",
			enable = enable,
			strength = strengthValue,
			stamina = staminaValue,
			shooting = shootingValue
		})
	end
end

--===============================================
--==              Close GUI                    ==
--===============================================
RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

Faketimer = 0

Citizen.CreateThread(function()
	while true do
		if IsControlPressed(1, openKey) then
			EnableGui(true)
			Citizen.Wait(1000)
			IsControlJustReleased(1, openKey)
			EnableGui(false)
		end
        if Faketimer >= 180 then
          Faketimer = 0
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
    Faketimer = Faketimer + 1 
	end 
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if guiEnabled then
			local playerPed = PlayerPedId()
			DisableControlAction(0, 288, true)
			DisableControlAction(0, 289, true)
			DisableControlAction(0, 309, true)
			DisableControlAction(0, 19, true)
			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)