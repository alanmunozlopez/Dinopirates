class("videoFeed").extends(NobleSprite)

function videoFeed:init(x,y, sourceFeed,Zindex)
	videoFeed.super.init(self,'assets/images/ui/dialog/videoFeed.png', true)
	-- Mark: animation states
	self.animation:addState('player', 1, 1)
	self.animation.player.frameDuration = 12
	self.animation:addState('radio', 2, 2)
	self.animation.radio.frameDuration = 12
	self.animation:addState('radiopocket', 3, 3)
	self.animation.radiopocket.frameDuration = 12
	self.animation:addState('radioring', 4, 5)
	self.animation.radioring.frameDuration = 12
	self.animation:addState('notes', 6, 6)
	self.animation.notes.frameDuration = 12
	self.animation:addState('playerWorry', 7, 7)
	self.animation.playerWorry.frameDuration = 12
	self.animation:addState('playerSurprise', 8, 8)
	self.animation.playerSurprise.frameDuration = 12
	self.animation:addState('playerHappy', 9, 9)
	self.animation.playerSurprise.frameDuration = 12
	self.animation:setState(sourceFeed)
	
	self:setSize(118*2,94*2) -- this is cuz is not a table
	self:setZIndex(Zindex)
	self:add(x,y)
end



