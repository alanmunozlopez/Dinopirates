levels={}
levelsLDTK = {
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
	  shadow = true,
	  light = 0.5,
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
	  Doors = {
		{
		  id = "Doors",
		  iid = "07b70f50-ac70-11f0-8539-35ff95bfdbdf",
		  layer = "Doors",
		  x = 200,
		  y = 232,
		  width = 48,
		  height = 16,
		  color = 7552569,
		  customFields = {
			NeedsKey = false,
			DoorsConnection = "Down",
			KeyNumber = nil
		  }
		}
	  },
	  PlayerSpawnPoints = {
		{
		  id = "PlayerSpawnPoints",
		  iid = "c8f4e8d0-ac70-11f0-aeab-7787f16bcbb3",
		  layer = "PSpawnPoints",
		  x = 196,
		  y = 196,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		},
		{
		  id = "PlayerSpawnPoints",
		  iid = "d3da1040-ac70-11f0-aeab-e9fbfa179061",
		  layer = "PSpawnPoints",
		  x = 204,
		  y = 36,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		}
	  },
	  Lamp = {
		{
		  id = "Lamp",
		  iid = "16280d40-ac70-11f0-aeab-878c73817b92",
		  layer = "Items",
		  x = 308,
		  y = 148,
		  width = 48,
		  height = 48,
		  color = 15389866,
		  customFields = {
			type = "lamp"
		  }
		}
	  },
	  Brocorat = {
		{
		  id = "Brocorat",
		  iid = "547cdf30-ac70-11f0-8539-afad52eb2b26",
		  layer = "Enemies",
		  x = 84,
		  y = 172,
		  width = 32,
		  height = 32,
		  color = 14120515,
		  customFields = {
			speed = 0.5,
			dead = false
		  }
		},
		{
		  id = "Brocorat",
		  iid = "580605f0-ac70-11f0-8539-0d60ca94c541",
		  layer = "Enemies",
		  x = 268,
		  y = 180,
		  width = 32,
		  height = 32,
		  color = 14120515,
		  customFields = {
			speed = 0.5,
			dead = false
		  }
		}
	  },
	  Trash = {
		{
		  id = "Trash",
		  iid = "1fdca3f0-ac70-11f0-aeab-198f05b5bf5c",
		  layer = "Props",
		  x = 92,
		  y = 60,
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
		  iid = "22f5cad0-ac70-11f0-aeab-557ab8741066",
		  layer = "Props",
		  x = 52,
		  y = 124,
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
		  iid = "252024e0-ac70-11f0-aeab-e91d62eb17a6",
		  layer = "Props",
		  x = 132,
		  y = 172,
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
		  iid = "41bbe7b0-ac70-11f0-aeab-930a568dd8e7",
		  layer = "Props",
		  x = 236,
		  y = 212,
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
		  iid = "47f49e10-ac70-11f0-aeab-ed4a43faaf4a",
		  layer = "Props",
		  x = 164,
		  y = 52,
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
		  iid = "51f3ab40-ac70-11f0-aeab-4d4cbcd3e234",
		  layer = "Props",
		  x = 252,
		  y = 76,
		  width = 32,
		  height = 32,
		  color = 12470831,
		  customFields = {
			nocollider = false,
			destroyed = false,
			type = "trash"
		  }
		}
	  }
	}
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
	  tile = 12,
	  DoorsConnection = {
		"Left",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  Keys = {
		{
		  id = "Keys",
		  iid = "d07a6090-ac70-11f0-8539-4d96faa29ca7",
		  layer = "Keys",
		  x = 184,
		  y = 40,
		  width = 48,
		  height = 48,
		  color = 4073265,
		  customFields = {
			keyNumber = 2
		  }
		}
	  },
	  Doors = {
		{
		  id = "Doors",
		  iid = "c6e3d930-ac70-11f0-8539-e78eb22c7faf",
		  layer = "Doors",
		  x = 392,
		  y = 120,
		  width = 16,
		  height = 48,
		  color = 7552569,
		  customFields = {
			NeedsKey = true,
			DoorsConnection = "Right",
			KeyNumber = 2
		  }
		}
	  },
	  PlayerSpawnPoints = {
		{
		  id = "PlayerSpawnPoints",
		  iid = "d3cd7b30-ac70-11f0-aeab-5594f181cfe1",
		  layer = "PSpawnPoints",
		  x = 364,
		  y = 116,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		},
		{
		  id = "PlayerSpawnPoints",
		  iid = "d980d4f0-ac70-11f0-aeab-29e22f526775",
		  layer = "PSpawnPoints",
		  x = 34,
		  y = 116,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		}
	  }
	}
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
	  tile = 13,
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
	entities = {
	  Keys = {
		{
		  id = "Keys",
		  iid = "60200480-ac70-11f0-8539-b975221d06b8",
		  layer = "Keys",
		  x = 88,
		  y = 56,
		  width = 48,
		  height = 48,
		  color = 4073265,
		  customFields = {
			keyNumber = 1
		  }
		}
	  },
	  Doors = {
		{
		  id = "Doors",
		  iid = "e35e4010-ac70-11f0-8539-cfa071292c9d",
		  layer = "Doors",
		  x = 8,
		  y = 120,
		  width = 16,
		  height = 48,
		  color = 7552569,
		  customFields = {
			NeedsKey = false,
			DoorsConnection = "Left",
			KeyNumber = nil
		  }
		},
		{
		  id = "Doors",
		  iid = "f2cac460-ac70-11f0-8539-f32c05a0c6fe",
		  layer = "Doors",
		  x = 200,
		  y = 8,
		  width = 48,
		  height = 16,
		  color = 7552569,
		  customFields = {
			NeedsKey = false,
			DoorsConnection = "Top",
			KeyNumber = nil
		  }
		},
		{
		  id = "Doors",
		  iid = "f5938150-ac70-11f0-8539-2555dd027d3e",
		  layer = "Doors",
		  x = 392,
		  y = 120,
		  width = 16,
		  height = 48,
		  color = 7552569,
		  customFields = {
			NeedsKey = true,
			DoorsConnection = "Right",
			KeyNumber = 1
		  }
		}
	  },
	  PlayerSpawnPoints = {
		{
		  id = "PlayerSpawnPoints",
		  iid = "5c1a52c0-ac70-11f0-aeab-5dec0ea534cd",
		  layer = "PSpawnPoints",
		  x = 196,
		  y = 32,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		},
		{
		  id = "PlayerSpawnPoints",
		  iid = "7a12e670-ac70-11f0-aeab-bd94f6a5fe5a",
		  layer = "PSpawnPoints",
		  x = 36,
		  y = 116,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		},
		{
		  id = "PlayerSpawnPoints",
		  iid = "c18e4ee0-ac70-11f0-aeab-61d47ecd3507",
		  layer = "PSpawnPoints",
		  x = 364,
		  y = 120,
		  width = 48,
		  height = 48,
		  color = 16705377,
		  customFields = {}
		}
	  }
	}
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
	  tile = 14,
	  DoorsConnection = {
		"Left",
		"Right"
	  },
	  play = nil
	},
	layers = {
	  "Tilemap.png"
	},
	entities = {
	  Doors = {
		{
		  id = "Doors",
		  iid = "e9b65690-ac70-11f0-8539-3392c72a1b66",
		  layer = "Doors",
		  x = 8,
		  y = 120,
		  width = 16,
		  height = 48,
		  color = 7552569,
		  customFields = {
			NeedsKey = false,
			DoorsConnection = "Left",
			KeyNumber = nil
		  }
		}
	  }
	}
  }
		--
}