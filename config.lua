Config					= {}
Config.DrawDistance		= 100.0
Config.MaxInService		= -1 -- Set to -1 to disable this
Config.Locale			= 'sv'

Config.Airports = {
	LSX = {
		Pos		= { x = -1031.268, y = -2741.703, z = 12.796 },
		Size	= { x = 1.5, y = 1.5, z = 1.0 },
		Colour	= { r = 204, g = 204, b = 0 },
		Marker	= 1,
		Blips	= {
			Pos		= { x = -1031.268, y = -2741.703, z = 12.796 },
			Sprite	= 90,
			Colour	= 5,
			Scale	= 1.2,
			Display	= 4
		},
	},
}

Config.Clothes = {
	LSX = {
		Pos		= { x = -1142.651, y = -2703.666, z = 12.957 },
		Size	= { x = 1.5, y = 1.5, z = 1.0 },
		Colour	= { r = 204, g = 204, b = 0 },
		Marker	= 1
	},
}

Config.Vehicles = {
	LSX = {
		Pos		= { x = -1154.058, y = -2715.184, z = 18.887 },
		Size	= { x = 1.5, y = 1.5, z = 1.0 },
		Colour	= { r = 204, g = 204, b = 0 },
		Marker	= 1,
		SpawnPoint = {
			Pos		= { x = -1359.840, y = -2719.073, z = 13.944 },
			Heading	= 90.0
		},
	},
}

Config.GradeVehicles = {
	hobbypilot = {
		mammatus = {
			label = 'Mammatus',
			value = 'mammatus'
		},
		dodo = {
			label = 'Dodo',
			value = 'dodo'
		},
	},

	freightpilot = {
		mammatus = {
			label = 'Mammatus',
			value = 'mammatus'
		},
		dodo = {
			label = 'Dodo',
			value = 'dodo'
		},
		velum = {
			label = 'Velum',
			value = 'velum2'
		},
		cuban = {
			label = 'Cuban 800',
			value = 'cuban800'
		},
	},

	airlinepilot = {
		mammatus = {
			label = 'Mammatus',
			value = 'mammatus'
		},
		dodo = {
			label = 'Dodo',
			value = 'dodo'
		},
		velum = {
			label = 'Velum',
			value = 'velum2'
		},
		cuban = {
			label = 'Cuban 800',
			value = 'cuban800'
		},
		shamal = {
			label = 'Shamal',
			value = 'shamal'
		},
		miljet = {
			label = 'Miljet',
			value = 'miljet'
		},
		airbus = { -- This is from a mod, you should probably remove this or change it to avoid issues!
			label = 'Airbus A350',
			value = 'a350'
		},
	},
	
}