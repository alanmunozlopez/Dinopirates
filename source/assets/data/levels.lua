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
		levelIid = "3b081ff0-ac70-11f0-998c-67e6b510262c",
		dir = "<"
	  }, {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "nw"
	  }, {
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
		level = 4,
		roomNumber = 7,
		tile = 2,
		play = nil,
		DoorsConnection = { "Top","lower" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		HoleTopLeft = { {
		  id = "HoleTopLeft",
		  iid = "bc6f8990-ac70-11f0-998c-1f2b878730b0",
		  layer = "Holes",
		  ["x"] = 156,
		  ["y"] = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTopLeft",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleLeft = { {
		  id = "HoleLeft",
		  iid = "bedbf5b0-ac70-11f0-998c-fd2fe3a93d81",
		  layer = "Holes",
		  ["x"] = 156,
		  ["y"] = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeLeft",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleBottomLeft = { {
		  id = "HoleBottomLeft",
		  iid = "c0aae950-ac70-11f0-998c-2744487d9220",
		  layer = "Holes",
		  ["x"] = 156,
		  ["y"] = 124,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottomLeft",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleBottom = { {
		  id = "HoleBottom",
		  iid = "c2a4bd80-ac70-11f0-998c-8185b9e2a7bf",
		  layer = "Holes",
		  ["x"] = 188,
		  ["y"] = 124,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleCenter = { {
		  id = "HoleCenter",
		  iid = "c4fd5380-ac70-11f0-998c-8d5c3a55cb24",
		  layer = "Holes",
		  ["x"] = 188,
		  ["y"] = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeCenter",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleTop = { {
		  id = "HoleTop",
		  iid = "c71ab540-ac70-11f0-998c-653b2784c09a",
		  layer = "Holes",
		  ["x"] = 188,
		  ["y"] = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleBottomRight = { {
		  id = "HoleBottomRight",
		  iid = "cb7758a0-ac70-11f0-998c-6bb559b30b1a",
		  layer = "Holes",
		  ["x"] = 220,
		  ["y"] = 124,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottomRight",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleRight = { {
		  id = "HoleRight",
		  iid = "ce92f080-ac70-11f0-998c-3f551206ddca",
		  layer = "Holes",
		  ["x"] = 220,
		  ["y"] = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeRight",
			nocollider = false,
			destroyed = false
		  }
		} },
		HoleTopRight = { {
		  id = "HoleTopRight",
		  iid = "eeb39450-ac70-11f0-998c-f7241128c000",
		  layer = "Holes",
		  ["x"] = 220,
		  ["y"] = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTopRight",
			nocollider = false,
			destroyed = false
		  }
		} },
		FellTable = { {
		  id = "FellTable",
		  iid = "531e0b20-ac70-11f0-998c-a53f87908c3b",
		  layer = "Props",
		  ["x"] = 28,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "FellTable",
		  iid = "850b9170-ac70-11f0-998c-afc1a9873d1e",
		  layer = "Props",
		  ["x"] = 156,
		  ["y"] = 180,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "FellTable",
		  iid = "87335370-ac70-11f0-998c-972d0c2d0afa",
		  layer = "Props",
		  ["x"] = 244,
		  ["y"] = 172,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		} },
		Blood2 = { {
		  id = "Blood2",
		  iid = "6499e770-ac70-11f0-998c-df9d2763bfd7",
		  layer = "Props",
		  ["x"] = 60,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "Blood2",
		  iid = "945f3690-ac70-11f0-998c-c1bfd067cd84",
		  layer = "Props",
		  ["x"] = 356,
		  ["y"] = 188,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = false,
			destroyed = false
		  }
		} },
		Microwave = { {
		  id = "Microwave",
		  iid = "68e6fa70-ac70-11f0-998c-b10c54278d00",
		  layer = "Props",
		  ["x"] = 92,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "microwave",
			nocollider = false,
			destroyed = false
		  }
		} },
		Smalltable = { {
		  id = "Smalltable",
		  iid = "76ab7410-ac70-11f0-998c-33dc7dd62999",
		  layer = "Props",
		  ["x"] = 252,
		  ["y"] = 212,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "Smalltable",
		  iid = "7828ec50-ac70-11f0-998c-e578b281f438",
		  layer = "Props",
		  ["x"] = 148,
		  ["y"] = 212,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "Smalltable",
		  iid = "7c36d370-ac70-11f0-998c-27835b3ae957",
		  layer = "Props",
		  ["x"] = 148,
		  ["y"] = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "Smalltable",
		  iid = "7e6b3fa0-ac70-11f0-998c-83ad0a5e8378",
		  layer = "Props",
		  ["x"] = 252,
		  ["y"] = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		} },
		Trash = { {
		  id = "Trash",
		  iid = "9019c4b0-ac70-11f0-998c-d97a85026dbd",
		  layer = "Props",
		  ["x"] = 164,
		  ["y"] = 148,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "trash"
		  }
		}, {
		  id = "Trash",
		  iid = "91764770-ac70-11f0-998c-ab2da21d72a7",
		  layer = "Props",
		  ["x"] = 292,
		  ["y"] = 140,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "trash"
		  }
		} },
		Blood = { {
		  id = "Blood",
		  iid = "93028cc0-ac70-11f0-998c-e7d639f7f96f",
		  layer = "Props",
		  ["x"] = 52,
		  ["y"] = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		} },
		KitchenStorage = { {
		  id = "KitchenStorage",
		  iid = "a331c4d0-ac70-11f0-998c-f77cabc0329c",
		  layer = "Props",
		  ["x"] = 252,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "KitchenStorage",
		  iid = "a3bffb10-ac70-11f0-998c-2bdf4a768139",
		  layer = "Props",
		  ["x"] = 284,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		}, {
		  id = "KitchenStorage",
		  iid = "a474f330-ac70-11f0-998c-efbe99831fb3",
		  layer = "Props",
		  ["x"] = 316,
		  ["y"] = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		} },
		Box = { {
		  id = "Box",
		  iid = "a87f1450-ac70-11f0-998c-2d12bf7a5583",
		  layer = "Props",
		  ["x"] = 36,
		  ["y"] = 140,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "box"
		  }
		}, {
		  id = "Box",
		  iid = "aa01bcb0-ac70-11f0-998c-dffc56ebfc22",
		  layer = "Props",
		  ["x"] = 356,
		  ["y"] = 132,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "box"
		  }
		} }
	  }
	},
	{
	  identifier = "Room_22",
	  uniqueIdentifer = "3b081ff0-ac70-11f0-998c-67e6b510262c",
	  ["x"] = 400,
	  ["y"] = 240,
	  width = 400,
	  height = 240,
	  bgColor = "#696A79",
	  neighbourLevels = { {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = ">"
	  }, {
		levelIid = "23b93777-ac70-11f0-998c-8fe9cae02b21",
		dir = "<"
	  }, {
		levelIid = "abdd36b0-ac70-11f0-998c-673887a050e6",
		dir = "n"
	  }, {
		levelIid = "2dc4bd30-ac70-11f0-998c-2ba6c3750080",
		dir = "ne"
	  }, {
		levelIid = "37dad4d0-ac70-11f0-998c-e3c63970ecdd",
		dir = "w"
	  }, {
		levelIid = "3d752854-ac70-11f0-998c-5dddbfac239d",
		dir = "e"
	  }, {
		levelIid = "46b2e150-ac70-11f0-998c-232538b976f9",
		dir = "sw"
	  }, {
		levelIid = "4a0bd050-ac70-11f0-998c-b14d359446e6",
		dir = "s"
	  }, {
		levelIid = "4cf534a4-ac70-11f0-998c-6712312c62dc",
		dir = "se"
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
		level = 3,
		roomNumber = 7,
		tile = 2,
		play = nil,
		DoorsConnection = { "Top" }
	  },
	  layers = { "Tilemap.png" },
	  entities = {
		Triggers = { {
		  id = "Triggers",
		  iid = "3b081ff4-ac70-11f0-998c-0974a63ecbb7",
		  layer = "Triggers",
		  ["x"] = 340,
		  ["y"] = 156,
		  width = 48,
		  height = 24,
		  color = 16711748,
		  customFields = {
			type = "call",
			script = "brocomess",
			usedTrigger = false
		  }
		} }
	  }
	}
		--
}