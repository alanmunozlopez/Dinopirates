class("videoFeed").extends(NobleSprite)

function videoFeed:init(x,y, sourceFeed,Zindex)
	videoFeed.super.init(self,'assets/images/ui/dialog/videoFeed.png', true)
	-- Mark: animation states
	self.animation:addState('player', 1, 1)
	self.animation.player.frameDuration = 12
	self.animation:addState('radioHand', 2, 2)
	self.animation.radioHand.frameDuration = 12
	self.animation:addState('radioPocket', 3, 3)
	self.animation.radioPocket.frameDuration = 12
	self.animation:addState('radioRing', 4, 5)
	self.animation.radioRing.frameDuration = 12
	self.animation:addState('notesHand', 6, 6)
	self.animation.notesHand.frameDuration = 12
	self.animation:addState('playerWorry', 7, 7)
	self.animation.playerWorry.frameDuration = 12
	self.animation:addState('playerSurprise', 8, 8)
	self.animation.playerSurprise.frameDuration = 12
	self.animation:addState('playerHappy', 9, 9)
	self.animation.playerHappy.frameDuration = 12
	self.animation:addState('playerAngry', 10, 10)
	self.animation.playerAngry.frameDuration = 12
	self.animation:addState('playerSleepy', 11, 11)
	self.animation.playerSleepy.frameDuration = 12
	self.animation:addState('playerScared', 12, 12)
	self.animation.playerScared.frameDuration = 12
	self.animation:addState('playerCry', 12, 12)
	self.animation.playerCry.frameDuration = 12
	self.animation:setState(sourceFeed)
	
	self:setSize(118*2,94*2) -- this is cuz is not a table
	self:setZIndex(Zindex)
	self:add(x,y)
end



