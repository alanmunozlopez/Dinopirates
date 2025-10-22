levels = {
	-- test levels
	{
		floor = {
			level = 1,
			visited = false,
			roomNumber = 20,
			tile = 1,
			light = 0.5,
			shadow = false,
			doors = {
			{
				direction = 'left',
				open = 'open',
				leadsTo = 120
			}
			},
			comic = {
					
			},
			items = {},
			triggers = {},
			enemies = {},
			props = {}
		}
	},
}

levelsLDTK = {
	{
	  identifier = "Room_20",
	  uniqueIdentifer = "69eb2d80-ac70-11f0-989f-95306126bd74",
	  ["x"] = 0,
	  ["y"] = 256,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { },
	  customFields = {
		shadow = false,
		light = 0.2,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 1,
		roomNumber = 20,
		tile = 2,
		play = nil
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Player = { {
		  id = "Player",
		  iid = "63fed7e0-ac70-11f0-9560-570a2c91b15d",
		  layer = "Player",
		  ["x"] = 192,
		  ["y"] = 200,
		  width = 48,
		  height = 48,
		  color = 7552569,
		  customFields = { }
		} },
		CrewMember = { {
		  id = "CrewMember",
		  iid = "658c1c40-ac70-11f0-997a-b986e024e071",
		  layer = "CrewMembers",
		  ["x"] = 148,
		  ["y"] = 36,
		  width = 48,
		  height = 48,
		  color = 14984818,
		  customFields = {
			isTaken = false,
			crewID = "100"
		  }
		} },
		Triggers = { {
		  id = "Triggers",
		  iid = "6cc79ca0-ac70-11f0-997a-113babec8821",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = nil
		  }
		} },
		Lamp = { {
		  id = "Lamp",
		  iid = "6c2668f0-ac70-11f0-9560-39f1165592dd",
		  layer = "Items",
		  ["x"] = 48,
		  ["y"] = 128,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "lamp"
		  }
		} },
		Keycard = { {
		  id = "Keycard",
		  iid = "dbf52030-ac70-11f0-997a-a95f91f12fca",
		  layer = "Items",
		  ["x"] = 104,
		  ["y"] = 200,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "keycard"
		  }
		} },
		Radio = { {
		  id = "Radio",
		  iid = "ddd83810-ac70-11f0-997a-4d88dfc739ac",
		  layer = "Items",
		  ["x"] = 40,
		  ["y"] = 192,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "radio"
		  }
		} },
		Notes = { {
		  id = "Notes",
		  iid = "df6a70d0-ac70-11f0-997a-7d5fa2803000",
		  layer = "Items",
		  ["x"] = 80,
		  ["y"] = 72,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "notes"
		  }
		} },
		Tools = { {
		  id = "Tools",
		  iid = "e25b4f30-ac70-11f0-997a-17c1369da218",
		  layer = "Items",
		  ["x"] = 144,
		  ["y"] = 128,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "tools"
		  }
		} },
		Bag = { {
		  id = "Bag",
		  iid = "9ad22e50-ac70-11f0-997a-d162f0474b38",
		  layer = "Items",
		  ["x"] = 140,
		  ["y"] = 172,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "bag"
		  }
		} },
		Brocorat = { {
		  id = "Brocorat",
		  iid = "56bc30e0-ac70-11f0-9560-d934ba0d0ba8",
		  layer = "Enemies",
		  ["x"] = 264,
		  ["y"] = 40,
		  width = 32,
		  height = 32,
		  color = 14120515,
		  customFields = {
			speed = 1.05,
			dead = false
		  }
		}, {
		  id = "Brocorat",
		  iid = "d7d16a50-ac70-11f0-997a-ab7ad2c74c17",
		  layer = "Enemies",
		  ["x"] = 340,
		  ["y"] = 36,
		  width = 32,
		  height = 32,
		  color = 14120515,
		  customFields = {
			speed = 0.5,
			dead = false
		  }
		} },
		Chair = { {
		  id = "Chair",
		  iid = "9ad79de0-ac70-11f0-afce-6922c5553078",
		  layer = "Props",
		  ["x"] = 32,
		  ["y"] = 40,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "a7545540-ac70-11f0-afce-512b93f6d1f2",
		  layer = "Props",
		  ["x"] = 192,
		  ["y"] = 96,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "a8526450-ac70-11f0-afce-05e65d8c3b92",
		  layer = "Props",
		  ["x"] = 80,
		  ["y"] = 144,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "e0d7c0a0-ac70-11f0-997a-5d92b65ab084",
		  layer = "Props",
		  ["x"] = 368,
		  ["y"] = 192,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "ef3b3960-ac70-11f0-997a-fd7a5fa0a644",
		  layer = "Props",
		  ["x"] = 104,
		  ["y"] = 56,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "68d10e10-ac70-11f0-997a-29034fba84bb",
		  layer = "Props",
		  ["x"] = 244,
		  ["y"] = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}, {
		  id = "Chair",
		  iid = "69670c80-ac70-11f0-997a-adc433a419e5",
		  layer = "Props",
		  ["x"] = 284,
		  ["y"] = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		} }
	  }
	}
		--
}