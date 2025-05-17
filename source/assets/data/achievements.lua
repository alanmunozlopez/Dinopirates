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
			isSecret = false,
		},
		{
			id = "sanityloss2",
			name = "cucu",
			description = "too much time alone and in the darkness can make you crazy",
			isSecret = false,
		},
		
	}
}

return achievementData
