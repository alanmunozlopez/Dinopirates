PlayerData = {
	x = 200,
	y = 200, 
	speed = 1.5,
	battery = 0, 
	sanity = 100,
	calories = 100, -- top 500
	steps = 0,
	totalSteps = 1000,
	sanityCounter = 0, -- top 100
	mapPercent = 0, -- Percentage of map explored (0-100)
	keys = {}, -- Table to store collected keys by number: {[1] = true, [2] = true, ...}
	canDance = false,
	readyToShrink = false,
	isTiny = false,
	isBig = false,
	playerSize = 10 ,
	actualPlayerSize = 25,
	activeItem = 0,
	sonarActive = false,
	storyCounter = 0,
	isActive = false, -- makes npc moves while charges the battery
	isTalking = false,
	isCutscene = false,
	isFocused = false,
	isCharging = false,
	isEquiping = false,
	floor = 1,
	room = 1,
	isGaming = false,
	isDancing = false,
	amountDances = 0,
	isInDarkness = false,
	showLightCone = false,
	direction = "idle",
	lastRoom = nil,
	actualLevel = nil,
	actualRoom = nil,
	actualTilemap = nil,
	saveLevel= nil,
	playerSpawn ={
		x = 200,
		y = 200,
	},
	playerExit ={
		x = nil,
		y = nil,
	},
	lastEnemyTouched ={
		type = nil,
		id = nil,
		x = nil,
		y = nil
	},
	items={
		hasLamp = false,
		hasRadio = true,
		hasNotes = true,
		hasBoots = false,
		hasBag = false,
		hasTools = false,
	},
	skills ={
		canFlash = false,
		canDash = false,
	
	},
	EnemiesData ={
		powerLevel = 1, -- max 20
		sightRadius = 50, -- min 50
		isEvolved = false,
	},
	CrewMemberData ={
		amountTaken = 0,
		idNumbers={
			CM001 = false,
			CM002 = false,
			CM003 = false
		}
	}
}

PlayerDataOriginal = {
	x = 200,
	y = 200, 
	speed = 1.5,
	battery = 0, 
	sanity = 100,
	calories = 100, -- top 500
	steps = 0,
	totalSteps = 1000,
	sanityCounter = 0, -- top 100
	mapPercent = 0, -- Percentage of map explored (0-100)
	keys = {}, -- Table to store collected keys by number: {[1] = true, [2] = true, ...}
	canDance = false,
	readyToShrink = false,
	isTiny = false,
	isBig = false,
	playerSize = 10 ,
	actualPlayerSize = 25,
	activeItem = 0,
	sonarActive = false,
	storyCounter = 0,
	isActive = false, -- makes npc moves while charges the battery
	isTalking = false,
	isCutscene = false,
	isFocused = false,
	isCharging = false,
	isEquiping = false,
	floor = 1,
	room = 1,
	isGaming = false,
	isDancing = false,
	amountDances = 0,
	isInDarkness = false,
	showLightCone = false,
	direction = "idle",
	lastRoom = nil,
	actualLevel = nil,
	actualRoom = nil,
	actualTilemap = nil,
	saveLevel= nil,
	playerSpawn ={
		x = 200,
		y = 200,
	},
	playerExit ={
		x = nil,
		y = nil,
	},
	lastEnemyTouched ={
		type = nil,
		id = nil,
		x = nil,
		y = nil
	},
	items={
		hasLamp = false,
		hasRadio = true,
		hasNotes = true,
		hasBoots = false,
		hasBag = false,
		hasTools = false,
	},
	skills ={
		canFlash = false,
		canDash = false,
	
	},
	EnemiesData ={
		powerLevel = 1, -- max 20
		sightRadius = 50, -- min 50
		isEvolved = false,
	},
	CrewMemberData ={
		amountTaken = 0,
		idNumbers={
			CM001 = false,
			CM002 = false,
			CM003 = false
		}
	}
}
