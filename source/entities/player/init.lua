Player = {}
class('Player').extends(NobleSprite)
import "entities/UI/dialog/dialogScreen"

import "entities/player/animations"
import "entities/player/collisions"
import "entities/player/movement"
import "entities/player/sanity"
import "entities/player/items"
import "entities/player/state"
local dialogUI = nil

function Player:init(x, y, speed, Zindex)
  Player.super.init(self,'assets/images/player/player', true)
  self:initAnimations()
  -- Mark: basic properties
  self:setSize(48, 52)
  self:setZIndex(Zindex)
  self:moveTo(x,y)
  self:setCollideRect(10, 24, 30, 24)
  self:setCollidesWithGroups(
    {
      CollideGroups.enemy,
      CollideGroups.props,
      CollideGroups.items,
      CollideGroups.wall
    })
  self:setGroups(CollideGroups.player)
  
  -- Mark: Custom properties
  self.initialSpeed = speed
  self.speed = speed
  self.initialSanity = PlayerData.sanity
  self.initialBattery = PlayerData.battery
  self.sanityLoss = 1
  self.sanity = PlayerData.sanity
  
  PlayerData.isActive = false
  self.loadingPower = false
  self.isAlive = true
  
  -- Mark: Custom items properties
  PlayerData.battery = PlayerData.battery
  self.hasKey = false
  PlayerData.hasLamp = PlayerData.hasLamp
  PlayerData.isInDarkness = PlayerData.isInDarkness
  
  -- Mark: add to scene
  self.dialogUI = dialogScreen()
  self:sanityCheck()
  self:add(x, y)   
  
end 

