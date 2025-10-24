levels={}
levelsLDTK = {
	{
	  identifier = "Room_7",
	  uniqueIdentifer = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
	  ["x"] = 400,
	  ["y"] = 240,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "nw"
	  }, 
	  {
		  levelIid= "abdd36b0-ac70-11f0-998c-673887a050e6",
		  dir ="<"
	  },{
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "n"
	  }, {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "ne"
	  }, {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "w"
	  }, {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "e"
	  }, {
		levelIid = "68b425c0-ac70-11f0-997a-7732cd72a5cc",
		dir = "sw"
	  }, {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "s"
	  }, {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "se"
	  } },
	  customFields = {
		shadow = false,
		light = 0,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 2,
		roomNumber = 7,
		tile = 2,
		play = nil,
		DoorsConnection = { "Top", "Lower" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Player = { {
		  id = "Player",
		  iid = "cf8f2162-ac70-11f0-997a-7beb907c527d",
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
		  iid = "cf8f2164-ac70-11f0-997a-67bafd75316c",
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
		  iid = "cf8f2166-ac70-11f0-997a-7bd6b4bce539",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = "call",
			script = "brocomess"
		  }
		} },
		Lamp = { {
		  id = "Lamp",
		  iid = "cf8f2168-ac70-11f0-997a-570b040636d4",
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
		  iid = "cf8f2169-ac70-11f0-997a-df722732cea5",
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
		  iid = "cf8f4870-ac70-11f0-997a-f75573ee449c",
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
		  iid = "cf8f4871-ac70-11f0-997a-d9facfa78f64",
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
		  iid = "cf8f4872-ac70-11f0-997a-5545090c8fb5",
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
		  iid = "cf8f4873-ac70-11f0-997a-1592da4de157",
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
		  iid = "cf8f4875-ac70-11f0-997a-1720191df15b",
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
		  iid = "cf8f4876-ac70-11f0-997a-2b0ec3566adf",
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
		  iid = "cf8f4878-ac70-11f0-997a-cb312c7b4b96",
		  layer = "Props",
		  ["x"] = 32,
		  ["y"] = 40,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "holeLeft"
		  }
		}, {
		  id = "Chair",
		  iid = "cf8f4879-ac70-11f0-997a-1305c33c044c",
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
		  iid = "cf8f487a-ac70-11f0-997a-6d7440a08e11",
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
		  iid = "cf8f487b-ac70-11f0-997a-6d3c3b197b72",
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
		  iid = "cf8f487c-ac70-11f0-997a-a95bedf2394a",
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
		  iid = "cf8f487d-ac70-11f0-997a-9f6e71f73f50",
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
		  iid = "cf8f487e-ac70-11f0-997a-99ae20c700c3",
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
	},
	{
	  identifier = "Room_2",
	  uniqueIdentifer = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
	  ["x"] = 400,
	  ["y"] = 0,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "w"
	  }, {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "e"
	  }, {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "sw"
	  }, {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "s"
	  }, {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "se"
	  } },
	  customFields = {
		shadow = false,
		light = 0,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 2,
		roomNumber = 2,
		tile = 1,
		play = nil,
		DoorsConnection = { "Down", "Right" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Player = { {
		  id = "Player",
		  iid = "bab17c72-ac70-11f0-997a-e117e47196c4",
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
		  iid = "bab17c74-ac70-11f0-997a-dd33edce7439",
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
		  iid = "bab17c76-ac70-11f0-997a-99c48a284d8c",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = "call",
			script = "brocomess"
		  }
		} },
		Lamp = { {
		  id = "Lamp",
		  iid = "bab17c78-ac70-11f0-997a-33a4078cc5c4",
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
		  iid = "bab17c79-ac70-11f0-997a-e1f88c1b58fa",
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
		  iid = "bab17c7a-ac70-11f0-997a-31b2e0274520",
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
		  iid = "bab17c7b-ac70-11f0-997a-45261276d932",
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
		  iid = "bab17c7c-ac70-11f0-997a-133568f215ef",
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
		  iid = "bab17c7d-ac70-11f0-997a-f1ff554c1328",
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
		  iid = "bab1a381-ac70-11f0-997a-0d5bdfe8584a",
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
		  iid = "bab1a382-ac70-11f0-997a-1f6bc9992b11",
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
		  iid = "bab1a384-ac70-11f0-997a-8bd6fba6e3d5",
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
		  iid = "bab1a385-ac70-11f0-997a-09e772007b3b",
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
		  iid = "bab1a386-ac70-11f0-997a-ad6d6ae44ed8",
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
		  iid = "bab1a387-ac70-11f0-997a-c90c934fe305",
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
		  iid = "bab1a388-ac70-11f0-997a-4b41c79a51c2",
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
		  iid = "bab1a389-ac70-11f0-997a-9d388dadc3db",
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
		  iid = "bab1a38a-ac70-11f0-997a-ad958217d02b",
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
	},
	{
	  identifier = "Room_8",
	  uniqueIdentifer = "d8b90440-ac70-11f0-997a-77d867841568",
	  ["x"] = 800,
	  ["y"] = 240,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "nw"
	  }, {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "n"
	  }, {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "ne"
	  }, {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "w"
	  }, {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "e"
	  }, {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "sw"
	  }, {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "s"
	  }, {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "se"
	  } },
	  customFields = {
		shadow = false,
		light = 0,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 2,
		roomNumber = 8,
		tile = 2,
		play = nil,
		DoorsConnection = { "Top", "Down" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Player = { {
		  id = "Player",
		  iid = "d8b90442-ac70-11f0-997a-253f27ff2bb6",
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
		  iid = "d8b90444-ac70-11f0-997a-89c5f0b44124",
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
		  iid = "d8b90446-ac70-11f0-997a-0dd30dd828cd",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = "call",
			script = "brocomess"
		  }
		} },
		Lamp = { {
		  id = "Lamp",
		  iid = "d8b90448-ac70-11f0-997a-afeb8111f4e3",
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
		  iid = "d8b90449-ac70-11f0-997a-1d92da0f9bb3",
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
		  iid = "d8b9044a-ac70-11f0-997a-1b04cae65943",
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
		  iid = "d8b9044b-ac70-11f0-997a-336c22eb477c",
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
		  iid = "d8b9044c-ac70-11f0-997a-e3b61aec3150",
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
		  iid = "d8b9044d-ac70-11f0-997a-0da8f29d8cd1",
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
		  iid = "d8b9044f-ac70-11f0-997a-cd8a6e0a8267",
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
		  iid = "d8b90450-ac70-11f0-997a-5ff030f18dc5",
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
		  iid = "d8b90452-ac70-11f0-997a-bd3d72bb4763",
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
		  iid = "d8b90453-ac70-11f0-997a-afd33acf4526",
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
		  iid = "d8b90454-ac70-11f0-997a-7bd113eb6fab",
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
		  iid = "d8b90455-ac70-11f0-997a-e161ecc0c91b",
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
		  iid = "d8b90456-ac70-11f0-997a-8f0956dc2a6e",
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
		  iid = "d8b90457-ac70-11f0-997a-bf7e3785844b",
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
		  iid = "d8b90458-ac70-11f0-997a-5b5545a2180d",
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
	},
	{
	  identifier = "Room_17",
	  uniqueIdentifer = "abdd36b0-ac70-11f0-998c-673887a050e6",
	  ["x"] = 400,
	  ["y"] = 240,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = ">"
	  }, {
		levelIid = "ae5a31c0-ac70-11f0-9560-a1abd660ccf1",
		dir = "nw"
	  } },
	  customFields = {
		shadow = false,
		light = 0,
		visited = false,
		comic_name = nil,
		comic_wasPlayed = false,
		level = 1,
		roomNumber = 7,
		tile = 2,
		play = nil,
		DoorsConnection = { "Top" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Player = { {
		  id = "Player",
		  iid = "abdd36b2-ac70-11f0-998c-2f462fb465d2",
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
		  iid = "abdd36b4-ac70-11f0-998c-417abe0c32f3",
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
		  iid = "abdd36b6-ac70-11f0-998c-ab19d3f3d52f",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = "call",
			script = "brocomess"
		  }
		} },
		Lamp = { {
		  id = "Lamp",
		  iid = "abdd36b8-ac70-11f0-998c-1347fa9e207b",
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
		  iid = "abdd36b9-ac70-11f0-998c-db7c45953ada",
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
		  iid = "abdd36ba-ac70-11f0-998c-7313017dac12",
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
		  iid = "abdd36bb-ac70-11f0-998c-c9b3fd64b70f",
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
		  iid = "abdd36bc-ac70-11f0-998c-5988a0925395",
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
		  iid = "abdd36bd-ac70-11f0-998c-7f54d9b25a7a",
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
		  iid = "abdd5dc0-ac70-11f0-998c-3150eb96d279",
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
		  iid = "abdd5dc1-ac70-11f0-998c-3b0f3e615ae1",
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
		  iid = "abdd5dc3-ac70-11f0-998c-5daadb4bd9e6",
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
		  iid = "abdd5dc4-ac70-11f0-998c-5d953a563862",
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
		  iid = "abdd5dc5-ac70-11f0-998c-316df1f3c1a4",
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
		  iid = "abdd5dc6-ac70-11f0-998c-817631c3b6e7",
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
		  iid = "abdd5dc7-ac70-11f0-998c-03d4e18db245",
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
		  iid = "abdd5dc8-ac70-11f0-998c-d1d05a2b14fe",
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
		  iid = "abdd5dc9-ac70-11f0-998c-a77ca2666eb9",
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