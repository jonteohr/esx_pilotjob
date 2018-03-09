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

local PlayerData			= {}
local CurrentAction			= nil
local CurrentActionMsg		= nil
local CurrentActionData		= nil
ESX							= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx_pilotjob:hasEnteredMarker', function(marker)
	if marker == 'clothes' then
		CurrentAction = 'clothes_menu'
		CurrentActionMsg = _U('clothes_hint')
	end
	if marker == 'vehicle' then
		CurrentAction = 'vehicle_menu'
		CurrentActionMsg = _U('vehicle_hint')
	end
	if marker == 'job' then
		CurrentAction = 'job_menu'
		CurrentActionMsg = _U('job_hint')
	end

	CurrentActionData = {}
end)

AddEventHandler('esx_pilotjob:hasExitedMarker', function()
	CurrentAction = nil
	CurrentActionMsg = nil
	CurrentActionData = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create blips for the airports
Citizen.CreateThread(function()
	for k,v in pairs(Config.Airports) do
		local blip = AddBlipForCoord(v.Blips.Pos.x, v.Blips.Pos.y, v.Blips.Pos.z)

		SetBlipSprite(blip, v.Blips.Sprite)
		SetBlipDisplay(blip, v.Blips.Display)
		SetBlipScale(blip, v.Blips.Scale)
		SetBlipColour(blip, v.Blips.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(k)
		EndTextCommandSetBlipName(blip)
	end
end)

-- Create markers for the pilots
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name == 'pilot' then

			local coords = GetEntityCoords(GetPlayerPed(-1))

			-- Clothes
			for k,v in pairs(Config.Clothes) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 100, false, true, 2, false, false, false, false)
				end
			end

			-- Jobmenu
			for k,v in pairs(Config.Airports) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.Drawdistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 100, false, true, 2, false, false, false, false)
				end
			end

			-- Vehicle spawner (garage)
			for k,v in pairs(Config.Vehicles) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 100, false, true, 2, false, false, false, false)
				end
			end

		end
	end
end)

-- Enter/Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords		= GetEntityCoords(GetPlayerPed(-1))
		local isInMarker	= false

		if PlayerData.job ~= nil and PlayerData.job.name == 'pilot' then
			for k,v in pairs(Config.Airports) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					jobMarker = true
					CurrentActionData = {airport = k}
				end
			end

			for k,v in pairs(Config.Clothes) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					clothesMarker = true
					CurrentActionData = {airport = k}
				end
			end

			for k,v in pairs(Config.Vehicles) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker = true
					vehicleMarker = true
					CurrentActionData = {airport = k}
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) then
				HasAlreadyEnteredMarker = true

				if jobMarker then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'job')
				elseif clothesMarker then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'clothes')
				elseif vehicleMarker then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'vehicle')
				end
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_pilotjob:hasExitedMarker')
			end
		end
	end
end)

-- Key listeners for markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'job_menu' then
					OpenJobMenu()
				elseif CurrentAction == 'vehicle_menu' then
					OpenVehicleSpawner(CurrentActionData.airport)
				elseif CurrentAction == 'clothes_menu' then
					OpenClothesMenu()
				end
			end
		end
	end
end)