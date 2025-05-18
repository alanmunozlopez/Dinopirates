local achievementData = {
	iconPath = "assets/launcher/icon",
	cardPath = "assets/images/achievements/card",
	achievements = {
		{
			id = "wakeup",
			name = "What a nap captn",
			descriptionLocked = "Just a little nap and I continue working",
			description = "Wakey wakey eggs and Brocolli",
			icon = "assets/images/achievements/nap",
			scoreValue = 2
		},
		{
			id = "notebook",
			name = "Dear diary",
			description = "Its easier to navigate with a map",
			descriptionLocked = "How can I track this?",
			icon = "assets/images/achievements/notebook"
		},
		{
			id = "comms",
			name = "Moshi moshi",
			description = "Achievement 1 Description",
			isSecret = true,
		},
		{
			id = "sanityloss1",
			name = "afraid of the dark?",
			description = "too much time alone and in the darkness can make you crazy",
			isSecret = true,
		},
		{
			id = "sanityloss2",
			name = "Hello darkness...",
			description = "this is the first step into the abbyss",
			isSecret = true,
		},
		{
			id = "microwaveBurn",
			name = "Was my mom's microwave",
			description = "How are we gonna make tacos now?",
			isSecret = true,
		},
		
	}
}

return achievementData
