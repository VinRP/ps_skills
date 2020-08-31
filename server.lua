--[[
█▀▀█ █░░█ █▀▀█ █▀▀ █▀▀▄ ░▀░ █░█   █▀▀ ▀▀█▀▀ █░░█ █▀▀▄ ░▀░ █▀▀█
█░░█ █▀▀█ █░░█ █▀▀ █░░█ ▀█▀ ▄▀▄   ▀▀█ ░░█░░ █░░█ █░░█ ▀█▀ █░░█
█▀▀▀ ▀░░▀ ▀▀▀▀ ▀▀▀ ▀░░▀ ▀▀▀ ▀░▀   ▀▀▀ ░░▀░░ ░▀▀▀ ▀▀▀░ ▀▀▀ ▀▀▀▀

              PROGRAMADOR: BYBLACKDEATH 
]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('esx:playerLoaded', function(source) 
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('ps_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].shooting)
			else
				MySQL.Async.execute('INSERT INTO `ps_skills` (`identifier`, `strength`, `stamina`, `shooting`) VALUES (@identifier, @strength, @stamina, @shooting);',
				{
				['@identifier'] = xPlayer.identifier,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@shooting'] = 0
				}, function ()
				end)
		end
	end)
end)

function updatePlayerInfo(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('ps_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].shooting)
		end
	end)
end

RegisterServerEvent("ps_skills:addStamina")
AddEventHandler("ps_skills:addStamina", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `ps_skills` SET `stamina` = @stamina WHERE `identifier` = @identifier',
			{
			['@stamina'] = (skillInfo[1].stamina + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("ps_skills:addStrength")
AddEventHandler("ps_skills:addStrength", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `ps_skills` SET `strength` = @strength WHERE `identifier` = @identifier',
			{
			['@strength'] = (skillInfo[1].strength + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

print("ps_skills starting successfully")
print("ps_skills developed by ByBlackDeath")
print("github.com/IOxeOfficial")

RegisterServerEvent("ps_skills:addShooting")
AddEventHandler("ps_skills:addShooting", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `ps_skills` SET `shooting` = @shooting WHERE `identifier` = @identifier',
			{
			['@shooting'] = (skillInfo[1].shooting + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

ESX.RegisterServerCallback('ps_skills:getSkills', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `ps_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		cb(skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].shooting)
	end)
end)