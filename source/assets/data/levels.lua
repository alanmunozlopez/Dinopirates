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
				leadsTo = 108
			}
			},
			comic = {
					
			},
			items = {
			{
				type = 'crewmember',
				x = 87,
				y = 68,
	  		  taken = false,
	  		  crewId = "100"
			},
			{
				type = 'keycard',
				x = 70,
				y = 154
			},
			{
				type = 'bag',
				x = 197,
				y = 34
			},
			{
				type = 'tools',
				x = 51,
				y = 100
			}
			},
			triggers = {
	
			},
			enemies = {
			{
				name = "brocorat",
				x = 301,
				y = 71,
				speed = 1.0,
				id = "2FE144E4-0CF0-4658-9E72-84B68864D8CD"
			},
			{
				name = "brocorat",
				x = 301,
				y = 121,
				speed = 1.0,
				id = "567584D3-46EE-4619-A156-EECE842132F6"
			},
			{
				name = "brocorat",
				x = 304,
				y = 175,
				speed = 1.0,
				id = "1501CD68-22CF-4020-91AF-FBB5BE1BE0AF"
			}
			},
			props = {
			{
				type = "table",
				x = 242,
				y = 31
			},
			{
				type = "table",
				x = 241,
				y = 75
			},
			{
				type = "table",
				x = 243,
				y = 124
			},
			{
				type = "table",
				x = 242,
				y = 176
			},
			{
				type = "holeTop",
				x = 150,
				y = 63
			},
			{
				type = "holeLeft",
				x = 132,
				y = 76
			},
			{
				type = "holeRight",
				x = 164,
				y = 79
			},
			{
				type = "holeLeft",
				x = 131,
				y = 108
			},
			{
				type = "holeRight",
				x = 163,
				y = 108
			},
			{
				type = "holeDown",
				x = 143,
				y = 122
			},
			{
				type = "holeDown",
				x = 150,
				y = 123
			}
			}
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
		shadow = true,
		light = 0.2,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 1,
		roomNumber = 20,
		tile = 2
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
		  iid = "846b54c0-ac70-11f0-9560-61581de3b74a",
		  layer = "CrewMembers",
		  ["x"] = 232,
		  ["y"] = 96,
		  width = 48,
		  height = 48,
		  color = 14984818,
		  customFields = {
			isTaken = false,
			crewID = nil
		  }
		} },
		Triggers = { {
		  id = "Triggers",
		  iid = "de47bed0-ac70-11f0-9560-316b244cc13c",
		  layer = "Triggers",
		  ["x"] = 264,
		  ["y"] = 64,
		  width = 72,
		  height = 32,
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
		Brocorat = { {
		  id = "Brocorat",
		  iid = "56bc30e0-ac70-11f0-9560-d934ba0d0ba8",
		  layer = "Enemies",
		  ["x"] = 160,
		  ["y"] = 72,
		  width = 32,
		  height = 32,
		  color = 14120515,
		  customFields = {
			speed = 1.05
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
			nocollider = true,
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
		} }
	  }
	}
		--
}