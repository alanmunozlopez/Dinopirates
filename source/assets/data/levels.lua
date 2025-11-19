levels={}
levelsLDTK = {
{
	identifier = "Room_1",
	uniqueIdentifer = "69eb2d80-ac70-11f0-989f-95306126bd74",
	x = 0,
	y = 0,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "ae5a31c0-ac70-11f0-9560-a1abd660ccf1",
		dir = "<"
	  },
	  {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "e"
	  },
	  {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "s"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 1,
	  tile = 1,
	  DoorsConnection = {
		"Down"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_2",
	uniqueIdentifer = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
	x = 400,
	y = 0,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "abdd36b0-ac70-11f0-998c-673887a050e6",
		dir = "<"
	  },
	  {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "w"
	  },
	  {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "e"
	  },
	  {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "sw"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "s"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 2,
	  tile = 2,
	  DoorsConnection = {
		"Down",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  Triggers = {
		{
		  id = "Triggers",
		  iid = "04803a80-ac70-11f0-ae64-7fad2120052d",
		  layer = "Triggers",
		  x = 172,
		  y = 100,
		  width = 40,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "giftFor100",
			usedTrigger = false,
			type = "Search"
		  }
		},
		{
		  id = "Triggers",
		  iid = "0f48b230-ac70-11f0-ae64-49bfdc9ab6ce",
		  layer = "Triggers",
		  x = 220,
		  y = 92,
		  width = 40,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "giftFor233",
			usedTrigger = false,
			type = "Search"
		  }
		},
		{
		  id = "Triggers",
		  iid = "2f45fa10-ac70-11f0-ae64-251f699f3ce2",
		  layer = "Triggers",
		  x = 180,
		  y = 148,
		  width = 176,
		  height = 48,
		  color = 16711748,
		  customFields = {
			script = "notesLook",
			usedTrigger = false,
			type = "Story"
		  }
		},
		{
		  id = "Triggers",
		  iid = "537f8180-ac70-11f0-ae64-49446dfe4c17",
		  layer = "Triggers",
		  x = 76,
		  y = 100,
		  width = 48,
		  height = 48,
		  color = 16711748,
		  customFields = {
			script = "notesPickup",
			usedTrigger = false,
			type = "Story"
		  }
		},
		{
		  id = "Triggers",
		  iid = "7d672b30-ac70-11f0-ae64-79d729daa857",
		  layer = "Triggers",
		  x = 316,
		  y = 180,
		  width = 88,
		  height = 88,
		  color = 16711748,
		  customFields = {
			script = "entranceMess",
			usedTrigger = false,
			type = "Search"
		  }
		}
	  },
	  Notes = {
		{
		  id = "Notes",
		  iid = "44544bf0-ac70-11f0-ae64-63dd0bc57344",
		  layer = "Items",
		  x = 76,
		  y = 100,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "notes"
		  }
		}
	  },
	  Xtree1 = {
		{
		  id = "Xtree1",
		  iid = "0b24fca0-ac70-11f0-985a-61d94463d05b",
		  layer = "Props",
		  x = 164,
		  y = 44,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "xtree-1",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Xtree2 = {
		{
		  id = "Xtree2",
		  iid = "0cc60270-ac70-11f0-985a-1d1e859d73df",
		  layer = "Props",
		  x = 196,
		  y = 44,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "xtree-2",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Xtree3 = {
		{
		  id = "Xtree3",
		  iid = "0ec1f980-ac70-11f0-985a-a3051c196f4b",
		  layer = "Props",
		  x = 164,
		  y = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "xtree-3",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Xtree4 = {
		{
		  id = "Xtree4",
		  iid = "1072ddd0-ac70-11f0-985a-077e223da91c",
		  layer = "Props",
		  x = 196,
		  y = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "xtree-4",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Gifts = {
		{
		  id = "Gifts",
		  iid = "13ad2140-ac70-11f0-985a-d1b75f9e1484",
		  layer = "Props",
		  x = 140,
		  y = 84,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "gifts",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Gifts",
		  iid = "1693c670-ac70-11f0-985a-51430b780b06",
		  layer = "Props",
		  x = 220,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "gifts",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Gift = {
		{
		  id = "Gift",
		  iid = "1afcecf0-ac70-11f0-985a-01e2a66cb28c",
		  layer = "Props",
		  x = 172,
		  y = 100,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "gift",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Blood2 = {
		{
		  id = "Blood2",
		  iid = "2652d790-ac70-11f0-985a-25b699999ba6",
		  layer = "Props",
		  x = 108,
		  y = 100,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood2",
		  iid = "2929ec60-ac70-11f0-985a-4126f85ddd1f",
		  layer = "Props",
		  x = 252,
		  y = 84,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  Blood = {
		{
		  id = "Blood",
		  iid = "2c1b18e0-ac70-11f0-985a-63cff1c9be3d",
		  layer = "Props",
		  x = 212,
		  y = 124,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "2dcb39e0-ac70-11f0-985a-45f325c18dbd",
		  layer = "Props",
		  x = 84,
		  y = 52,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "2f6c18a0-ac70-11f0-985a-a1f4b58b53d7",
		  layer = "Props",
		  x = 300,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "31637bd0-ac70-11f0-985a-7b97c4a1ea96",
		  layer = "Props",
		  x = 140,
		  y = 132,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  Table = {
		{
		  id = "Table",
		  iid = "46dec050-ac70-11f0-985a-132726764f8b",
		  layer = "Props",
		  x = 36,
		  y = 100,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "table",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Table",
		  iid = "487d5520-ac70-11f0-985a-cd8cc298fdae",
		  layer = "Props",
		  x = 356,
		  y = 68,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "table",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Table",
		  iid = "6d93cec0-ac70-11f0-ae64-1be5800770cc",
		  layer = "Props",
		  x = 300,
		  y = 172,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "table",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  FellTable = {
		{
		  id = "FellTable",
		  iid = "4abbfa80-ac70-11f0-985a-7319d2beaa22",
		  layer = "Props",
		  x = 324,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "4c9c0520-ac70-11f0-985a-e99f3d0bf46f",
		  layer = "Props",
		  x = 36,
		  y = 180,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "4db452f0-ac70-11f0-985a-cfe8262e92fe",
		  layer = "Props",
		  x = 364,
		  y = 204,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "4fdbc6d0-ac70-11f0-985a-a5601f3ccd47",
		  layer = "Props",
		  x = 92,
		  y = 204,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "6ed6af00-ac70-11f0-ae64-f7bb28f9916d",
		  layer = "Props",
		  x = 340,
		  y = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Fellchair = {
		{
		  id = "Fellchair",
		  iid = "518e7fe0-ac70-11f0-985a-93391a2015c0",
		  layer = "Props",
		  x = 316,
		  y = 204,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		},
		{
		  id = "Fellchair",
		  iid = "53f63110-ac70-11f0-985a-d350bb30470b",
		  layer = "Props",
		  x = 348,
		  y = 164,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		},
		{
		  id = "Fellchair",
		  iid = "54ba1d50-ac70-11f0-985a-27fb7aa5ea82",
		  layer = "Props",
		  x = 252,
		  y = 188,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		},
		{
		  id = "Fellchair",
		  iid = "722d2d00-ac70-11f0-ae64-d9f2ef5111fe",
		  layer = "Props",
		  x = 324,
		  y = 164,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		}
	  },
	  Chair = {
		{
		  id = "Chair",
		  iid = "7626a1c0-ac70-11f0-ae64-a5338e4e288e",
		  layer = "Props",
		  x = 364,
		  y = 164,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "chair"
		  }
		}
	  }
	}
  },
{
	identifier = "Room_3",
	uniqueIdentifer = "bf654080-ac70-11f0-997a-e578ba2da2ac",
	x = 800,
	y = 0,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "2dc4bd30-ac70-11f0-998c-2ba6c3750080",
		dir = "<"
	  },
	  {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "w"
	  },
	  {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "e"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "sw"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "s"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 3,
	  tile = 3,
	  DoorsConnection = {
		"Left",
		"Down"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  Triggers = {
		{
		  id = "Triggers",
		  iid = "c9660040-ac70-11f0-ae64-094e17987f94",
		  layer = "Triggers",
		  x = 100,
		  y = 60,
		  width = 56,
		  height = 32,
		  color = 16711748,
		  customFields = {
			script = "microwaveBurn",
			usedTrigger = false,
			type = "Search"
		  }
		},
		{
		  id = "Triggers",
		  iid = "f2317670-ac70-11f0-ae64-133829c2c353",
		  layer = "Triggers",
		  x = 244,
		  y = 108,
		  width = 32,
		  height = 32,
		  color = 16711748,
		  customFields = {
			script = "kitchenWeapons",
			usedTrigger = false,
			type = "Search"
		  }
		},
		{
		  id = "Triggers",
		  iid = "3a47bf50-ac70-11f0-ae64-474c236a6fd7",
		  layer = "Triggers",
		  x = 332,
		  y = 100,
		  width = 56,
		  height = 48,
		  color = 16711748,
		  customFields = {
			script = "inneficientCutting",
			usedTrigger = false,
			type = "Story"
		  }
		},
		{
		  id = "Triggers",
		  iid = "a059dac0-ac70-11f0-ae64-f1ee9dff56d1",
		  layer = "Triggers",
		  x = 44,
		  y = 196,
		  width = 48,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "justBoxes",
			usedTrigger = false,
			type = "Search"
		  }
		}
	  },
	  FellTable = {
		{
		  id = "FellTable",
		  iid = "bf46c0e0-ac70-11f0-ae64-597ec6fe672b",
		  layer = "Props",
		  x = 36,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Blood = {
		{
		  id = "Blood",
		  iid = "c2442260-ac70-11f0-ae64-a5f7b1f853f5",
		  layer = "Props",
		  x = 68,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "01ef6b90-ac70-11f0-ae64-292bbea86898",
		  layer = "Props",
		  x = 324,
		  y = 132,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "0601e690-ac70-11f0-ae64-8778a1292c62",
		  layer = "Props",
		  x = 348,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "0ed1c290-ac70-11f0-ae64-95329b483a8a",
		  layer = "Props",
		  x = 268,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  Microwave = {
		{
		  id = "Microwave",
		  iid = "c7345330-ac70-11f0-ae64-3f2b938fe6d4",
		  layer = "Props",
		  x = 100,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "microwave",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  DeadRat = {
		{
		  id = "DeadRat",
		  iid = "f4bef490-ac70-11f0-ae64-d96e07439f33",
		  layer = "Props",
		  x = 332,
		  y = 100,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "deadrat",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Blood2 = {
		{
		  id = "Blood2",
		  iid = "fb5b9ce0-ac70-11f0-ae64-c17f4252e798",
		  layer = "Props",
		  x = 292,
		  y = 84,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  KnifeKettle = {
		{
		  id = "KnifeKettle",
		  iid = "ed4c9040-ac70-11f0-ae64-57af9b96ac8a",
		  layer = "Props",
		  x = 244,
		  y = 108,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "knifeKettle",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Box = {
		{
		  id = "Box",
		  iid = "9d998240-ac70-11f0-ae64-fffc401f9f95",
		  layer = "Props",
		  x = 44,
		  y = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "box"
		  }
		}
	  }
	}
  },
{
	identifier = "Room_4",
	uniqueIdentifer = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
	x = 1200,
	y = 0,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "310fc980-ac70-11f0-998c-05b91a46387d",
		dir = "<"
	  },
	  {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "w"
	  },
	  {
		levelIid = "c2b4e0b0-ac70-11f0-997a-09fdc7fc6323",
		dir = "e"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "sw"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "s"
	  },
	  {
		levelIid = "672c4d40-ac70-11f0-997a-7b0342bedabe",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 4,
	  tile = 4,
	  DoorsConnection = {
		"Right",
		"Down"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_5",
	uniqueIdentifer = "c2b4e0b0-ac70-11f0-997a-09fdc7fc6323",
	x = 1600,
	y = 0,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "35082cd0-ac70-11f0-998c-d16d78429f5c",
		dir = "<"
	  },
	  {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "w"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "sw"
	  },
	  {
		levelIid = "672c4d40-ac70-11f0-997a-7b0342bedabe",
		dir = "s"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 5,
	  tile = 5,
	  DoorsConnection = {
		"Left",
		"Down"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_6",
	uniqueIdentifer = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
	x = 0,
	y = 240,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "37dad4d0-ac70-11f0-998c-e3c63970ecdd",
		dir = "<"
	  },
	  {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "n"
	  },
	  {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "ne"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "e"
	  },
	  {
		levelIid = "68b425c0-ac70-11f0-997a-7732cd72a5cc",
		dir = "s"
	  },
	  {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 6,
	  tile = 6,
	  DoorsConnection = {
		"Top",
		"Down"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  HoleTopLeft = {
		{
		  id = "HoleTopLeft",
		  iid = "d281ad50-ac70-11f0-985a-8d55a21a42da",
		  layer = "Holes",
		  x = 68,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTopLeft",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  HoleTopRight = {
		{
		  id = "HoleTopRight",
		  iid = "d9a95790-ac70-11f0-985a-7bf73bcd5f63",
		  layer = "Holes",
		  x = 364,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTopRight",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  HoleTop = {
		{
		  id = "HoleTop",
		  iid = "2b6e91d0-ac70-11f0-985a-e7c4fb1c6c67",
		  layer = "Holes",
		  x = 292,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "3cce0c80-ac70-11f0-985a-217e7a8b41a2",
		  layer = "Holes",
		  x = 100,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "3deb1540-ac70-11f0-985a-9f2af8af8514",
		  layer = "Holes",
		  x = 132,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "3ec87cf0-ac70-11f0-985a-8199c4b6c240",
		  layer = "Holes",
		  x = 164,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "3f8c9040-ac70-11f0-985a-75524d26705a",
		  layer = "Holes",
		  x = 196,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "40488d40-ac70-11f0-985a-892c3e91b4f1",
		  layer = "Holes",
		  x = 260,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "4127f0c0-ac70-11f0-985a-218621763ac2",
		  layer = "Holes",
		  x = 228,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "5034a1d0-ac70-11f0-985a-41b1605bb05f",
		  layer = "Holes",
		  x = 340,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleTop",
		  iid = "50af2900-ac70-11f0-985a-732af353cbf8",
		  layer = "Holes",
		  x = 316,
		  y = 60,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeTop",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  HoleBottomRight = {
		{
		  id = "HoleBottomRight",
		  iid = "595de870-ac70-11f0-985a-2d25546b1cd8",
		  layer = "Holes",
		  x = 364,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottomRight",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  HoleBottomLeft = {
		{
		  id = "HoleBottomLeft",
		  iid = "5bbd5c40-ac70-11f0-985a-2f416591a689",
		  layer = "Holes",
		  x = 68,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottomLeft",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  HoleBottom = {
		{
		  id = "HoleBottom",
		  iid = "5ebda3f0-ac70-11f0-985a-4b1e408b98f3",
		  layer = "Holes",
		  x = 100,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "5f657cb0-ac70-11f0-985a-61bc6c9d4c83",
		  layer = "Holes",
		  x = 132,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "60005d20-ac70-11f0-985a-9d8a6c76864b",
		  layer = "Holes",
		  x = 164,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "60e7fe00-ac70-11f0-985a-654310f66003",
		  layer = "Holes",
		  x = 196,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "619c80f0-ac70-11f0-985a-33411fe66a93",
		  layer = "Holes",
		  x = 228,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "625dfc30-ac70-11f0-985a-95c27ed761ec",
		  layer = "Holes",
		  x = 260,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "6384c8f0-ac70-11f0-985a-3383191a9fa5",
		  layer = "Holes",
		  x = 332,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "649a3090-ac70-11f0-985a-6727346c45ed",
		  layer = "Holes",
		  x = 300,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "HoleBottom",
		  iid = "656325e0-ac70-11f0-985a-05a85471feda",
		  layer = "Holes",
		  x = 284,
		  y = 92,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "holeBottom",
			nocollider = false,
			destroyed = false
		  }
		}
	  }
	}
  },
{
	identifier = "Room_7",
	uniqueIdentifer = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
	x = 400,
	y = 240,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "3b081ff0-ac70-11f0-998c-67e6b510262c",
		dir = "<"
	  },
	  {
		levelIid = "69eb2d80-ac70-11f0-989f-95306126bd74",
		dir = "nw"
	  },
	  {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "n"
	  },
	  {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "ne"
	  },
	  {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "w"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "e"
	  },
	  {
		levelIid = "68b425c0-ac70-11f0-997a-7732cd72a5cc",
		dir = "sw"
	  },
	  {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "s"
	  },
	  {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = "intro",
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 7,
	  tile = 7,
	  DoorsConnection = {
		"Top"
	  },
	  play = "Enter"
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  Triggers = {
		{
		  id = "Triggers",
		  iid = "c7870a30-ac70-11f0-998c-2944db77c3b4",
		  layer = "Triggers",
		  x = 204,
		  y = 132,
		  width = 88,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "wakeup",
			usedTrigger = false,
			type = "Story"
		  }
		},
		{
		  id = "Triggers",
		  iid = "cc4b57d0-ac70-11f0-ae64-f1a43cc2526b",
		  layer = "Triggers",
		  x = 292,
		  y = 140,
		  width = 40,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "someTrash",
			usedTrigger = false,
			type = "Search"
		  }
		},
		{
		  id = "Triggers",
		  iid = "04397810-ac70-11f0-ae64-891aa0cc0d18",
		  layer = "Triggers",
		  x = 36,
		  y = 140,
		  width = 48,
		  height = 40,
		  color = 16711748,
		  customFields = {
			script = "justBoxes",
			usedTrigger = false,
			type = "Search"
		  }
		}
	  },
	  Smalltable = {
		{
		  id = "Smalltable",
		  iid = "76ab7410-ac70-11f0-998c-33dc7dd62999",
		  layer = "Props",
		  x = 252,
		  y = 204,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Smalltable",
		  iid = "7828ec50-ac70-11f0-998c-e578b281f438",
		  layer = "Props",
		  x = 148,
		  y = 204,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Smalltable",
		  iid = "7c36d370-ac70-11f0-998c-27835b3ae957",
		  layer = "Props",
		  x = 148,
		  y = 188,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Smalltable",
		  iid = "7e6b3fa0-ac70-11f0-998c-83ad0a5e8378",
		  layer = "Props",
		  x = 252,
		  y = 188,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Smalltable",
		  iid = "a99b3a10-ac70-11f0-ae64-bbea47082fb4",
		  layer = "Props",
		  x = 36,
		  y = 44,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "smallTable",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  FellTable = {
		{
		  id = "FellTable",
		  iid = "850b9170-ac70-11f0-998c-afc1a9873d1e",
		  layer = "Props",
		  x = 156,
		  y = 172,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "87335370-ac70-11f0-998c-972d0c2d0afa",
		  layer = "Props",
		  x = 244,
		  y = 164,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "FellTable",
		  iid = "9a8dc5b0-ac70-11f0-ae64-330b96106ce8",
		  layer = "Props",
		  x = 92,
		  y = 44,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "fellTable",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Trash = {
		{
		  id = "Trash",
		  iid = "9019c4b0-ac70-11f0-998c-d97a85026dbd",
		  layer = "Props",
		  x = 164,
		  y = 148,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "trash"
		  }
		},
		{
		  id = "Trash",
		  iid = "91764770-ac70-11f0-998c-ab2da21d72a7",
		  layer = "Props",
		  x = 292,
		  y = 140,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "trash"
		  }
		}
	  },
	  Blood = {
		{
		  id = "Blood",
		  iid = "93028cc0-ac70-11f0-998c-e7d639f7f96f",
		  layer = "Props",
		  x = 52,
		  y = 196,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "9d6f61d0-ac70-11f0-ae64-e33789cc7e0e",
		  layer = "Props",
		  x = 76,
		  y = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		},
		{
		  id = "Blood",
		  iid = "f186f080-ac70-11f0-ae64-a96276b15936",
		  layer = "Props",
		  x = 148,
		  y = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  Blood2 = {
		{
		  id = "Blood2",
		  iid = "945f3690-ac70-11f0-998c-c1bfd067cd84",
		  layer = "Props",
		  x = 356,
		  y = 188,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "Blood2",
		  iid = "ee1103a0-ac70-11f0-ae64-453fe6771b29",
		  layer = "Props",
		  x = 260,
		  y = 68,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "blood2",
			nocollider = true,
			destroyed = false
		  }
		}
	  },
	  KitchenStorage = {
		{
		  id = "KitchenStorage",
		  iid = "a331c4d0-ac70-11f0-998c-f77cabc0329c",
		  layer = "Props",
		  x = 252,
		  y = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "KitchenStorage",
		  iid = "a3bffb10-ac70-11f0-998c-2bdf4a768139",
		  layer = "Props",
		  x = 284,
		  y = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		},
		{
		  id = "KitchenStorage",
		  iid = "a474f330-ac70-11f0-998c-efbe99831fb3",
		  layer = "Props",
		  x = 316,
		  y = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			type = "kitchenStorage",
			nocollider = false,
			destroyed = false
		  }
		}
	  },
	  Box = {
		{
		  id = "Box",
		  iid = "a87f1450-ac70-11f0-998c-2d12bf7a5583",
		  layer = "Props",
		  x = 36,
		  y = 140,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "box"
		  }
		},
		{
		  id = "Box",
		  iid = "aa01bcb0-ac70-11f0-998c-dffc56ebfc22",
		  layer = "Props",
		  x = 364,
		  y = 132,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "box"
		  }
		}
	  },
	  Fellchair = {
		{
		  id = "Fellchair",
		  iid = "0d7905b0-ac70-11f0-985a-d1c872a5fc59",
		  layer = "Props",
		  x = 164,
		  y = 36,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		},
		{
		  id = "Fellchair",
		  iid = "1022f000-ac70-11f0-985a-9b3988f2af57",
		  layer = "Props",
		  x = 364,
		  y = 28,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "fellchair"
		  }
		}
	  }
	}
  },
{
	identifier = "Room_8",
	uniqueIdentifer = "d8b90440-ac70-11f0-997a-77d867841568",
	x = 800,
	y = 240,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "3d752854-ac70-11f0-998c-5dddbfac239d",
		dir = "<"
	  },
	  {
		levelIid = "bab17c70-ac70-11f0-997a-85b3d3c5d229",
		dir = "nw"
	  },
	  {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "n"
	  },
	  {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "ne"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "w"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "e"
	  },
	  {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "sw"
	  },
	  {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "s"
	  },
	  {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = "pick-the-device",
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 8,
	  tile = 8,
	  DoorsConnection = {
		"Top",
		"Down"
	  },
	  play = "Cutscene"
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  CrewMember = {
		{
		  id = "CrewMember",
		  iid = "d6d0d0e0-ac70-11f0-9378-29a879421f4b",
		  layer = "CrewMembers",
		  x = 140,
		  y = 92,
		  width = 48,
		  height = 48,
		  color = 14984818,
		  customFields = {
			isTaken = false,
			crewID = "100"
		  }
		},
		{
		  id = "CrewMember",
		  iid = "dc0ab4e0-ac70-11f0-9378-055897bc85a0",
		  layer = "CrewMembers",
		  x = 260,
		  y = 148,
		  width = 48,
		  height = 48,
		  color = 14984818,
		  customFields = {
			isTaken = false,
			crewID = "100"
		  }
		}
	  },
	  Triggers = {
		{
		  id = "Triggers",
		  iid = "2f05dea0-ac70-11f0-8398-8b03b2d23bdf",
		  layer = "Triggers",
		  x = 324,
		  y = 116,
		  width = 48,
		  height = 48,
		  color = 16711748,
		  customFields = {
			script = nil,
			usedTrigger = false,
			type = "Cutscene"
		  }
		}
	  },
	  Radio = {
		{
		  id = "Radio",
		  iid = "27526f20-ac70-11f0-8398-eb0a7d3547d7",
		  layer = "Items",
		  x = 324,
		  y = 116,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "radio"
		  }
		}
	  }
	}
  },
		--
{
	identifier = "Room_9",
	uniqueIdentifer = "dab87dc0-ac70-11f0-997a-63497867517d",
	x = 1200,
	y = 240,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "40386700-ac70-11f0-998c-e53e1b32800c",
		dir = "<"
	  },
	  {
		levelIid = "bf654080-ac70-11f0-997a-e578ba2da2ac",
		dir = "nw"
	  },
	  {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "n"
	  },
	  {
		levelIid = "c2b4e0b0-ac70-11f0-997a-09fdc7fc6323",
		dir = "ne"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "w"
	  },
	  {
		levelIid = "672c4d40-ac70-11f0-997a-7b0342bedabe",
		dir = "e"
	  },
	  {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "sw"
	  },
	  {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "s"
	  },
	  {
		levelIid = "708f7320-ac70-11f0-998c-737ddc0c343a",
		dir = "se"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 9,
	  tile = 2,
	  DoorsConnection = {
		"Top"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_10",
	uniqueIdentifer = "672c4d40-ac70-11f0-997a-7b0342bedabe",
	x = 1600,
	y = 240,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "43980cc0-ac70-11f0-998c-a70f320b4eb0",
		dir = "<"
	  },
	  {
		levelIid = "c118e3f0-ac70-11f0-997a-a35ec59b96eb",
		dir = "nw"
	  },
	  {
		levelIid = "c2b4e0b0-ac70-11f0-997a-09fdc7fc6323",
		dir = "n"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "w"
	  },
	  {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "sw"
	  },
	  {
		levelIid = "708f7320-ac70-11f0-998c-737ddc0c343a",
		dir = "s"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 10,
	  tile = 2,
	  DoorsConnection = {
		"Down",
		"Top"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_11",
	uniqueIdentifer = "68b425c0-ac70-11f0-997a-7732cd72a5cc",
	x = 0,
	y = 480,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "46b2e150-ac70-11f0-998c-232538b976f9",
		dir = "<"
	  },
	  {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "n"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "ne"
	  },
	  {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "e"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 11,
	  tile = 2,
	  DoorsConnection = {
		"Top",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_12",
	uniqueIdentifer = "6cc9d510-ac70-11f0-997a-191299f9209c",
	x = 400,
	y = 480,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "4a0bd050-ac70-11f0-998c-b14d359446e6",
		dir = "<"
	  },
	  {
		levelIid = "cb0db7f0-ac70-11f0-997a-b9923cff9cbf",
		dir = "nw"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "n"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "ne"
	  },
	  {
		levelIid = "68b425c0-ac70-11f0-997a-7732cd72a5cc",
		dir = "w"
	  },
	  {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "e"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 12,
	  tile = 2,
	  DoorsConnection = {
		"Left",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_13",
	uniqueIdentifer = "715b4410-ac70-11f0-997a-156adb22b715",
	x = 800,
	y = 480,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "4cf534a4-ac70-11f0-998c-6712312c62dc",
		dir = "<"
	  },
	  {
		levelIid = "cf8f2160-ac70-11f0-997a-c71a3a3308ed",
		dir = "nw"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "n"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "ne"
	  },
	  {
		levelIid = "6cc9d510-ac70-11f0-997a-191299f9209c",
		dir = "w"
	  },
	  {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "e"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 13,
	  tile = 2,
	  DoorsConnection = {
		"Top",
		"Left",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_14",
	uniqueIdentifer = "6de95960-ac70-11f0-998c-e3108c5f25c9",
	x = 1200,
	y = 480,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "50a125a0-ac70-11f0-998c-f3b70b95a9ac",
		dir = "<"
	  },
	  {
		levelIid = "d8b90440-ac70-11f0-997a-77d867841568",
		dir = "nw"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "n"
	  },
	  {
		levelIid = "672c4d40-ac70-11f0-997a-7b0342bedabe",
		dir = "ne"
	  },
	  {
		levelIid = "715b4410-ac70-11f0-997a-156adb22b715",
		dir = "w"
	  },
	  {
		levelIid = "708f7320-ac70-11f0-998c-737ddc0c343a",
		dir = "e"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 14,
	  tile = 2,
	  DoorsConnection = {
		"Left",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  },
{
	identifier = "Room_15",
	uniqueIdentifer = "708f7320-ac70-11f0-998c-737ddc0c343a",
	x = 1600,
	y = 480,
	width = 400,
	height = 240,
	bgColor = "#696A79",
	neighbourLevels = {
	  {
		levelIid = "53674a87-ac70-11f0-998c-83aa3940da82",
		dir = "<"
	  },
	  {
		levelIid = "dab87dc0-ac70-11f0-997a-63497867517d",
		dir = "nw"
	  },
	  {
		levelIid = "672c4d40-ac70-11f0-997a-7b0342bedabe",
		dir = "n"
	  },
	  {
		levelIid = "6de95960-ac70-11f0-998c-e3108c5f25c9",
		dir = "w"
	  }
	},
	customFields = {
	  shadow = false,
	  light = 0,
	  visited = false,
	  comic_name = nil,
	  comic_wasPlayed = false,
	  level = 4,
	  roomNumber = 15,
	  tile = 15,
	  DoorsConnection = {
		"Top",
		"Left"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {}
  }
		--
}