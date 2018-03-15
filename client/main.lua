--[[
	
		[ESX] Pilot Job
		By: Hypr/Condolent

--]]

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
	if marker == 'deleter' then
		CurrentAction = 'vehicle_deleter'
		CurrentActionMsg = _U('deleter_hint')
	end

	CurrentActionData = {}
end)

AddEventHandler('esx_pilotjob:hasExitedMarker', function()
	CurrentAction = nil
	CurrentActionMsg = nil
	CurrentActionData = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_pilotjob:startDeliveryJob')
AddEventHandler('esx_pilotjob:startDeliveryJob', function()
	-- TODO
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
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 100, false, true, 2, false, false, false, false)
				end
			end

			-- Vehicles (garage)
			for k,v in pairs(Config.Vehicles) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Colour.r, v.Colour.g, v.Colour.b, 100, false, true, 2, false, false, false, false)
				end
				if (GetDistanceBetweenCoords(coords, v.Deleter.Pos.x, v.Deleter.Pos.y, v.Deleter.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Marker, v.Deleter.Pos.x, v.Deleter.Pos.y, v.Deleter.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Deleter.Size.x, v.Deleter.Size.y, v.Deleter.Size.z, v.Deleter.Colour.r, v.Deleter.Colour.g, v.Deleter.Colour.b, 100, false, true, 2, false, false, false, false)
				end
			end

		end
	end
end)

-- Enter/Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed			= GetPlayerPed(-1)
		local coords			= GetEntityCoords(playerPed)
		local isInMarker		= false
		local jobMarker			= false
		local clothesMarker		= false
		local vehicleSpawner	= false
		local vehicleDeleter	= false

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
					vehicleSpawner = true
					CurrentActionData = {airport = k}
				end

				if (GetDistanceBetweenCoords(coords, v.Deleter.Pos.x, v.Deleter.Pos.y, v.Deleter.Pos.z, true) < v.Deleter.Size.x) then
					if IsPedInAnyPlane(playerPed) then
						local plane = GetVehiclePedIsIn(playerPed, false)
						if DoesEntityExist(plane) then
							isInMarker = true
							vehicleDeleter = true
							CurrentActionData = {airport = k, vehicle = plane}
						end
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) then
				HasAlreadyEnteredMarker = true

				if jobMarker then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'job')
				elseif clothesMarker then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'clothes')
				elseif vehicleSpawner then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'vehicle')
				elseif vehicleDeleter then
					TriggerEvent('esx_pilotjob:hasEnteredMarker', 'deleter')
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
				elseif CurrentAction == 'vehicle_deleter' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end
			end
		end
	end
end)

function OpenJobMenu()
	local elements = {}

	table.insert(elements, { label = _U('create_invoice'), value = 'invoice' })

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'pilotjob_job',
		{
			title		= _U('jobmenu_title'),
			elements	= elements
		},
		function(data, menu)
			if data.current.value == 'invoice' then

				ESX.UI.Menu.Open(
					'dialog', GetCurrentResourceName(), 'pilot_set_invoice_amount',
					{
						title = _U('invoice_amount')
					},
					function(data2, menu2)
						local amount = tonumber(data2.value)

						if amount == nil then
							ESX.ShowNotification(_U('no_nil_invoice'))
						else
							menu2.close()

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('no_player_nearby'))
							else
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'pilotjob', _U('airline'), tonumber(data2.value))
							end
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)

			end
		end,
		function(data, menu)
			menu.close()

			CurrentAction		= 'job_menu'
			CurrentActionMsg	= _U('job_hint')
		end
	)
end

function OpenVehicleSpawner(airport)
	local vehicles = Config.Vehicles[airport]
	local elements = {}

	if PlayerData.job.grade_name == 'hobbypilot' then
		for k,v in pairs(Config.GradeVehicles.hobbypilot) do
			table.insert(elements, {
				label = v.label,
				value = v.value
			})
		end
	end
	if PlayerData.job.grade_name == 'freightpilot' then
		for k,v in pairs(Config.GradeVehicles.freightpilot) do
			table.insert(elements, {
				label = v.label,
				value = v.value
			})
		end
	end
	if PlayerData.job.grade_name == 'airlinepilot' and Config.Airports[airport].Airline then
		for k,v in pairs(Config.GradeVehicles.airlinepilot) do
			table.insert(elements, {
				label = v.label,
				value = v.value
			})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'pilot_vehicle_spawner',
		{
			title		= _U('vehicle_spawner'),
			elements	= elements
		},
		function(data, menu)
			
			menu.close()

			local model = data.current.value
			local vehicle = GetClosestVehicle(vehicles.SpawnPoint.Pos.x, vehicles.SpawnPoint.Pos.y, vehicles.SpawnPoint.Pos.z, 3.0, 0, 71)

			if not DoesEntityExist(vehicle) then
				local playerPed = GetPlayerPed(-1)

				ESX.Game.SpawnVehicle(model, {
					x = vehicles.SpawnPoint.Pos.x,
					y = vehicles.SpawnPoint.Pos.y,
					z = vehicles.SpawnPoint.Pos.z
				}, vehicles.SpawnPoint.Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				end)

				TriggerEvent('esx_pilotjob:startDeliveryJob')
			else
				ESX.ShowNotification(_U('too_many_planes'))
			end

		end,
		function(data, menu)
			menu.close()

			CurrentAction		= 'vehicle_menu'
			CurrentActionMsg	= _U('vehicle_hint')
		end
	)
end

function OpenClothesMenu()

	local elements = {}

	table.insert(elements, { label = _U('civ_clothes'), value = 'civ_clothes' })
	table.insert(elements, { label = _U('pilot_uniform'), value = 'work_clothes' })

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'pilot_clothes_menu',
		{
			title		= _U('clothes_menu'),
			elements	= elements
		},
		function(data, menu)
			cleanPlayer(GetPlayerPed(-1))

			if data.current.value == 'civ_clothes' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local model = nil

					if skin.sex == 0 then
						model = GetHashKey("mp_m_freemode_01")
					else
						model = GetHashKey("mp_f_freemode_01")
					end

					RequestModel(model)
					while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					end

					SetPlayerModel(PlayerId(), model)
					SetModelAsNoLongerNeeded(model)

					TriggerEvent('skinchanger:loadSkin', skin)
					TriggerEvent('esx:restoreLoadout')
				end)
			end

			if data.current.value == 'work_clothes' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
					end
				end)
			end
		end,
		function(data, menu)
			menu.close()

			CurrentAction		= 'clothes_menu'
			CurrentActionMsg	= _U('clothes_hint')
		end
	)
end