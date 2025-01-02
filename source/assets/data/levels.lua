levels = {
	{
		floor = {
			level = 1,
			visited = false,
			roomNumber = 1,
			tile = 1,
			light = 0.5,
			shadow = false,
			doors = {
			{
				direction = 'right',
				open = 'open',
				leadsTo = 103
			},
			{
				direction = 'down',
				open = 'open',
				leadsTo = 107
			}
			},
			comic = {
					wasPlayed = false,
					name = "intro-comic",
					play = "enter"
			},
			items = {},
			triggers = {
	
			},
			enemies = {
	
			},
			props = {
				{
					type = "chair",
					x = 134,
					y = 178
				},
				{
					type = "chair",
					x = 104,
					y = 205
				},
				{
					type = "chair",
					x = 237,
					y = 206
				},
				{
					type = "chair",
					x = 278,
					y = 97
				}
			}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 7,
			light = 1,
			shadow = false,
			triggers = {
				{
					usedTrigger = false,
					x = 180,
					y = 165,
					width = 40,
					height = 10,
					script = 5
				},
				
			},
			enemies = {
				{
					name = "brocorat",
					x = 50,
					y = 160,
					speed = 0.7
				},
				{
					name = "brocorat",
					x = 350,
					y = 60,
					speed = 0.7
				},
				{
					name = "brocorat",
					x = 350,
					y = 100,
					speed = 0.7
				},
				{
					name = "brocorat",
					x = 250,
					y = 160,
					speed = 0.7
				},
				-- {
				-- 	name = "frogcolli",
				-- 	x = 200,
				-- 	y = 120,
				-- 	speed = 3
				-- },
				
			
			},
			doors = {
				{
					direction = 'down',
					open = 'open',
					leadsTo = 107,
				},
				{
					direction = 'right',
					open = 'open',
					leadsTo = 103,
				},
			},
			items = {
				{
					type = 'lamp',
					x = 200,
					y = 100
				}
			},
			props = {
				{
					type = 'blood',
					x = 80,
					y = 150,
					nocollide = true
				},
				{
					type = 'blood2',
					x = 160,
					y = 50,
					nocollide = true
				},
				{
					type = 'blood2',
					x = 90,
					y = 140,
					nocollide = true
				},
				{
					type = 'blood',
					x = 140,
					y = 40,
					nocollide = true
				}
			}
		}
	},
	-- repeat
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 3,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'left',
					open = 'open',
					leadsTo = 102,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 108,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 4,
			light = 0.4,
			shadow = true,
			comic = {
				wasPlayed = false,
				name = "intro-comic",
				play = "enter"
			},
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'right',
					open = 'open',
					leadsTo = 105,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 109,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 5,
			light = 0.4,
			shadow = true,
			comic = {
				wasPlayed = false,
				name = "comic-test",
			},
			enemies = {},
			triggers = {
				{
					usedTrigger = false,
					x = 170,
					y = 150,
					width = 60,
					height = 30,
					script = 2,
					type = "cutscene"
				},
			},
			doors = {
				{
					direction = 'left',
					open = 'open',
					leadsTo = 104,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 110,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 6,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 101,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 111,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			roomNumber = 2,
			tile = 2,
			light = 0.1,
			shadow = false,
			comic = {
				wasPlayed = false,
				name = "intro-comic",
				play = "enter"
			},
			triggers = {
				{
					usedTrigger = false,
					x = 170,
					y = 150,
					width = 60,
					height = 30,
					script = 2
				},
				{
					usedTrigger = false,
					x = 220,
					y = 100,
					width = 60,
					height = 30,
					script = 3
				},
				{
					usedTrigger = false,
					x = 200,
					y = 55,
					width = 60,
					height = 30,
					script = 4
				},
			},
			enemies = {
				{
					name = "brocorat",
					x = 128,
					y = 160,
					speed = 0.7
				},
				-- {
				-- 	name = "frogcolli",
				-- 	x = 200,
				-- 	y = 120,
				-- 	speed = 3
				-- },
				-- {
				-- 	name = "frogcolli",
				-- 	x = 200,
				-- 	y = 40,
				-- 	speed = 3
				-- }
			
			},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 102,
				}
			},
			items = {
				{
					type = 'notes',
					x = 230,
					y = 80
				}
			},
			props = {
				{
					type = 'chair',
					x = 140,
					y = 200,
				},
				{
					type = 'chair',
					x = 160,
					y = 160
				},
				{
					type = 'fellchair',
					x = 232,
					y = 192
				},
				{
					type = 'chair',
					x = 170,
					y = 120
				},
				{
					type = 'chair',
					x = 210,
					y = 124
				},
				{
					type = 'chair',
					x = 275,
					y = 170
				},
				{
					type = 'fellchair',
					x = 280,
					y = 124
				},
				{
					type = 'chair',
					x = 300,
					y = 20
				},
				{
					type = 'fellchair',
					x = 60,
					y = 35
				},
				{
					type = 'chair',
					x = 60,
					y = 135
				},
				{
					type = 'chair',
					x = 90,
					y = 210
				},
				{
					type = 'table',
					x = 360,
					y = 210
				},
				{
					type = 'table',
					x = 0,
					y = 90
				},
				{
					type = 'table',
					x = 145,
					y = 60
				},
				{
					type = 'xtree-1',
					x = 339,
					y = 72,
					nocollide = true
				},
				{
					type = 'xtree-2',
					x = 339,
					y = 72,
					nocollide = true
				},
				{
					type = 'xtree-3',
					x = 339,
					y = 105,
				},
				{
					type = 'xtree-4',
					x = 339,
					y = 105,
				},
			}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 8,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 103,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 113,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 9,
			shadow = false,
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 104,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 114,
				},
			},
			props = {
				{
					type = "table",
					x = 100,
					y = 100,
					
				},
				{
					type = "chair",
					x = 130,
					y = 100,
					
				},
				{
					type = "box",
					x = 300,
					y = 150,
					
				},
				{
					type = "box",
					x = 50,
					y = 50,
					
				}
			},
			items = {
				{
					type = "notes",
					x = 200,
					y = 100
				}
			},
			enemies = {
				{
					-- name = "brocorat",
					-- x = 250,
					-- y = 150,
					-- speed = 1
				}
			},
			triggers = {
				-- Add triggers if needed
			}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 10,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 105,
				},
				{
					direction = 'down',
					open = 'open',
					leadsTo = 115,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 11,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'right',
					open = 'open',
					leadsTo = 112,
				},
				{
					direction = 'top',
					open = 'open',
					leadsTo = 106,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 12,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'left',
					open = 'open',
					leadsTo = 111,
				},
				{
					direction = 'right',
					open = 'open',
					leadsTo = 113,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 13,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 108,
				},
				{
					direction = 'right',
					open = 'open',
					leadsTo = 114,
				},
				{
					direction = 'left',
					open = 'open',
					leadsTo = 112,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 14,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'left',
					open = 'open',
					leadsTo = 113,
				},
				{
					direction = 'top',
					open = 'open',
					leadsTo = 109,
				},
			},
			items = {},
			props = {}
		}
	},
	{
		floor = {
			level = 1,
			visited = false,
			tile = 2,
			roomNumber = 15,
			light = 0.4,
			shadow = false,
			enemies = {},
			triggers = {},
			doors = {
				{
					direction = 'top',
					open = 'open',
					leadsTo = 110,
				},
			},
			items = {},
			props = {}
		}
	},
	
}