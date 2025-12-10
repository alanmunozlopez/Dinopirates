Player = {}
class('Player').extends(NobleSprite)
import "entities/UI/dialog/dialogScreen"
import "entities/UI/UIHud"

import "entities/player/animations"
import "entities/player/collisions"
import "entities/player/movement"
import "entities/player/sanity"
import "entities/player/items"
import "entities/player/state"
import "entities/player/dash"
import "entities/player/abilities"
local dialogUI = nil
local uiHud = nil

function Player:init(x, y, speed, Zindex)
  Player.super.init(self,'assets/images/player/player', true)
  self:initAnimations()
  -- MARK: Basic properties
  self:setSize(48, 52)
  self:setZIndex(Zindex)
  self:moveTo(x,y)
  self:setCollideRect(8, 24, 30, 24)
  self:setCollidesWithGroups(
    {
      CollideGroups.enemy,
      CollideGroups.props,
      CollideGroups.items,
      CollideGroups.wall
    })
  self:setGroups(CollideGroups.player)
  
  -- MARK: Custom properties
  self.initialSpeed = speed
  self.speed = speed
  self.initialSanity = PlayerData.sanity
  self.initialBattery = PlayerData.battery
  self.sanityLoss = 1
  self.sanity = PlayerData.sanity
  self.playerUIX = 30
  self.playerUIY = 30
  self.isBehind = false
  self.triggerEnteredOnce = false
  
  -- Performance: Cache for optimization
  self.lastZIndexY = y
  self.lastCheckX = x
  self.lastCheckY = y
  
  PlayerData.isActive = false
  self.loadingPower = false
  self.isAlive = true
  self.dashCooldown = 0  -- Cooldown timer for dash attack
  
  -- MARK: Custom items properties
  PlayerData.battery = PlayerData.battery
  self.hasKey = false
  PlayerData.hasLamp = PlayerData.hasLamp
  PlayerData.isInDarkness = PlayerData.isInDarkness
  
  -- MARK: Add to scene
  self.dialogUI = dialogScreen()
  self.uiHud = UIHud(x,y)
  self:sanityCheck()
  self:add(x, y)   
  
end 

