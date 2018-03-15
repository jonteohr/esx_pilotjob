Config					= {}
Config.DrawDistance		= 100.0
Config.MaxInService		= -1 -- Set to -1 to disable this
Config.Locale			= 'en'

Config.Airports = {
	LSX = {
		Airline = true, -- Allow airline pilots to fly and spawn planes here? Not recommended on smaller airstrips..
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
	Airstrip = {
		Airline = false, -- Allow airline pilots to fly and spawn planes here? Not recommended on smaller airstrips..
		Pos		= { x = 1700.676, y = 3291.739, z = 47.922 },
		Size	= { x = 1.5, y = 1.5, z = 1.0 },
		Colour	= { r = 204, g = 204, b = 0 },
		Marker	= 1,
		Blips	= {
			Pos		= { x = 1700.676, y = 3291.739, z = 48.922 },
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
	Airstrip = {
		Pos		= { x = 1757.451, y = 3296.943, z = 40.150 },
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
			Heading	= 330.166
		},
		Deleter	= {
			Pos		= { x = -1359.840, y = -2719.073, z = 12.944 },
			Colour	= { r = 255, g = 0, b = 0 },
			Size	= { x = 5.0, y = 5.0, z = 2.0 }
		},
	},
	Airstrip = {
		Pos		= { x = 1716.331, y = 3280.057, z = 40.087 },
		Size	= { x = 1.5, y = 1.5, z = 1.0 },
		Colour	= { r = 204, g = 204, b = 0 },
		Marker	= 1,
		SpawnPoint = {
			Pos		= { x = 1721.433, y = 3270.458, z = 40.310 },
			Heading	= 119.404
		},
		Deleter	= {
			Pos		= { x = 1731.002, y = 3312.352, z = 40.223 },
			Colour	= { r = 255, g = 0, b = 0 },
			Size	= { x = 5.0, y = 5.0, z = 2.0 }
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