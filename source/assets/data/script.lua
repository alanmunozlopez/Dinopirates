script = {
	{
		name = "no_door_key",
		-- no door key 1
		dialog = {
			{
				video = 'player',
				text = Graphics.getLocalizedText("door", "en")
			},
			{
				video = 'radio',
				text = Graphics.getLocalizedText("door2", "en")
			},
			{
				video = 'radio',
				text = Graphics.getLocalizedText("door3", "en")
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("door4", "en")
			},
			{
				video = 'radiopocket',
				text = Graphics.getLocalizedText("door5", "en")
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("door6", "en")
			},
		}
	},
	{
		name = "the chair",
		-- trigger the chair
		dialog = {
			{
		video = 'playerWorry',
		text = Graphics.getLocalizedText("the-chair-01", "en"),
	},
					{
		video = 'playerSurprise',
		text = Graphics.getLocalizedText("the-chair-02", "en"),
	},
					{
		video = 'radio',
		text = Graphics.getLocalizedText("the-chair-03", "en"),
	}
			
		}
	},
	{
		-- trigger mess
		name = "test",
		dialog = {
			
			script = {
				{
				video = 'radio',
				text = Graphics.getLocalizedText("test1", "en"),
	}
			}
		}
	},
	{
		name = "mess",
		-- trigger mess
		dialog = {
			{
				video = 'player',
				text = Graphics.getLocalizedText("mess", "en"),
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("mess2", "en"),
			},
			
		}
	},
	{
		name = "the final test",
		-- trigger the final test
		dialog = {
			{
		video = 'player',
		text = Graphics.getLocalizedText("the final test_tft", "en"),
	},
					{
		video = 'playerWorry',
		text = Graphics.getLocalizedText("the final test_tft", "en"),
	},
					{
		video = 'playerSurprise',
		text = Graphics.getLocalizedText("the final test_tft", "en"),
	},
					{
		video = 'radio',
		text = Graphics.getLocalizedText("the final test_tft", "en"),
	}
			
		}
	},
	{
		name = "trigger_chairs",
		-- trigger mess
		dialog = {
			{
				video = 'player',
				text = Graphics.getLocalizedText("chairs", "en")
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("chairs1", "en")
			},
			{
				video = 'playerSurprise',
				text = Graphics.getLocalizedText("chairs2", "en")
			},
			
		}
	},
	{
		name = "pickup_radio",
		-- trigger pickup radio
		dialog = {
			{
				video = 'notes',
				text = Graphics.getLocalizedText("welcome", "en")
			},
			{
				video = 'playerWorry',
				text = Graphics.getLocalizedText("welcome1", "en"),
				--screen = Graphics.image.new('assets/images/ui/dialog/img/spaceship.png'),
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("welcome2", "en"),
				screen = Graphics.image.new('assets/images/ui/dialog/img/spaceship.png'), -- here goes the picture
			},
			{
				video = 'notes',
				text = Graphics.getLocalizedText("welcome3", "en")
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("welcome4", "en")
			},
		}
	},
	{
		name = "kitchen",
		-- Kitchen
		dialog = {
			{
				video = 'player',
				text = Graphics.getLocalizedText("kitchen", "en")
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("kitchen2", "en"),
				screen = Graphics.image.new('assets/images/ui/dialog/img/cristal.png'),
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("kitchen3", "en"),
				screen = Graphics.image.new('assets/images/ui/dialog/img/cristal.png'),
			},
			{
				video = 'player',
				text = Graphics.getLocalizedText("kitchen4", "en"),
			},
			
		}
	},
	
}