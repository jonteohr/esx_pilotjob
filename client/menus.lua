function OpenJobMenu()
	local elements = {}

	table.insert(elements, { label = _U('create_invoice'), value = 'invoice' })

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'pilotjob_job',
		{
			title		= _U('jobmenu_title')
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
							ESX.ShowNotification(_U('invoice_amount'))
						else
							menu.close()

							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

							if closestPlayer == -1 or closestDistance > 3.0 then
								ESX.ShowNotification(_U('invoice_amount'))
							else
								TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'pilotjob', _U('airline'), tonumber(data2.value))
							end
						end
					end,
					function(data2, menu2)
						menu.close()
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
	local vehicles = Config.Vehicles.airport
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
	if PlayerData.job.grade_name == 'airlinepilot' then
		for k,v in pairs(Config.GradeVehicles.airlinepilot) do
			table.insert(elements, {
				label = v.label,
				value = v.value
			})
		end
	end

	ESX.Menu.CloseAll()

	ESX.Menu.Open(
		'default', GetCurrentResourceName(), 'pilot_vehicle_spawner',
		{
			title		= _U('vehicle_spawner')
			elements	= elements
		},
		function(data, menu)
			
			menu.close()

			local model = data.current.value
			local vehicle = GetClosestVehicle(vehicle.SpawnPoint.Pos.x, vehicle.SpawnPoint.Pos.y, vehicle.SpawnPoint.Pos.z, 3.0, 0, 71)

			if not DoesEntityExist(vehicle) then
				local playerPed = GetPlayerPed(-1)

				ESX.Game.SpawnVehicle(model, {
					x = vehicle.SpawnPoint.Pos.x,
					y = vehicle.SpawnPoint.Pos.y,
					z = vehicle.SpawnPoint.Pos.z
				}, vehicle.SpawnPoint.Heading, function(vehicle)
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

	ESX.Menu.CloseAll()

	ESX.Menu.Open(
		'default', GetCurrentResourceName(), 'pilot_clothes_menu',
		{
			title		= _U('clothes_menu')
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