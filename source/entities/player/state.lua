-- Handles falling to a lower floor through holes or vertical passages
-- This function uses the neighbor-based connection system defined in levelsLDTK
-- 
-- How it works:
-- 1. Gets the current room index from PlayerData.floor
-- 2. Calls GetLowerRoom() which:
--    a) Checks if "Lower" exists in DoorsConnection (permission check)
--    b) Searches neighbourLevels for a neighbor with dir = "<"
--    c) Finds the actual room data using FindRoomByIid()
--    d) Calculates the full room number (level * 100 + roomNumber)
-- 3. Validates the lower room exists
-- 4. Translates room number to scene class (e.g., 308 -> Floor308)
-- 5. Preserves player X/Y position for seamless transition
-- 6. Transitions to the lower room with fall animation
--
-- Love2D Implementation Notes:
-- - Replace Noble.transition() with your own scene manager
-- - Use shaders or sprite-based animations for fall effect
-- - Consider using bump.lua or HC for collision detection with holes
-- - You can preload adjacent rooms for faster transitions
-- - Example: SceneManager:switchTo(nextScene, "fall", 1.5)
function Player:fallBelow()
  printDebug("💀 Player falling...")

  -- Get current room index (this is an index into the levelsLDTK array)
  -- Love2D: Same approach works, but you can also use hash tables for faster lookup
  local currentRoomIndex = PlayerData.floor
  
  -- Search for lower room using the neighbor connection system
  -- This validates: 1) DoorsConnection has "Lower", 2) neighbourLevels has dir="<"
  -- Love2D: Same function works perfectly, no changes needed
  local lowerRoomNumber, lowerRoomData = GetLowerRoom(currentRoomIndex)

  if not lowerRoomNumber then
    printDebug("⚠️  Cannot fall from this room")
    -- Optional: show message to player
    return
  end

  -- Translate room number to scene class (e.g., 308 -> Floor308)
  -- Love2D: You'll need to implement your own scene system
  -- Example: local nextScene = SceneRegistry["Floor" .. lowerRoomNumber]
  local nextScene = RoomTranslate(lowerRoomNumber)

  if nextScene then
    -- CRITICAL: Preserve player X and Y position for seamless transition
    -- This allows the player to fall through a hole and land at the same X/Y
    -- Love2D: Same approach works perfectly
    PlayerData.playerSpawn.x = self.x
    PlayerData.playerSpawn.y = self.y

    printDebug("✅ Transitioning to room:", lowerRoomNumber)

    -- Transition with fall animation (Playdate Noble framework)
    -- Love2D: Replace with your scene manager and custom transition
    -- Example shader-based fall effect:
    -- SceneManager:switchTo(nextScene, {
    --   type = "fall",
    --   duration = 1.5,
    --   shader = fallShader,  -- Vertical blur shader
    --   onComplete = function() self:spawn() end
    -- })
    Noble.transition(nextScene, 1.5, Noble.Transition.Imagetable, {
      imagetableEnter = Graphics.imagetable.new('assets/images/screens/transitions/transitionFallEnter'),
      imagetableExit = Graphics.imagetable.new('assets/images/screens/transitions/transitionFallOut'),
    })
  else
    printDebug("❌ Scene Floor" .. lowerRoomNumber .. " not found")
    -- Fallback: Player fell into the void, transition to DeadScene
    printDebug("💀 Transitioning to DeadScene (fell into void)")
    Noble.transition(DeadScene, 1.5, Noble.Transition.Default)
  end
end

-- Handles climbing to an upper floor through tubes, ladders, or vertical passages
-- This function uses the same neighbor-based connection system as fallBelow()
-- 
-- How it works:
-- 1. Gets the current room index from PlayerData.floor
-- 2. Calls GetUpperRoom() which:
--    a) Checks if "Upper" exists in DoorsConnection (permission check)
--    b) Searches neighbourLevels for a neighbor with dir = ">"
--    c) Finds the actual room data using FindRoomByIid()
--    d) Calculates the full room number (level * 100 + roomNumber)
-- 3. Validates the upper room exists
-- 4. Translates room number to scene class (e.g., 408 -> Floor408)
-- 5. Preserves player X/Y position for seamless transition
-- 6. Transitions to the upper room
--
-- Love2D Implementation Notes:
-- - Same as fallBelow() but with different transition animation
-- - Consider using a "climb" or "fade" transition instead of "fall"
-- - You can trigger this from collision with tubes/ladders
-- - Example collision detection with bump.lua:
--   local items = world:queryRect(self.x, self.y, self.width, self.height)
--   for i, item in ipairs(items) do
--     if item.type == "tube" then self:riseAbove() end
--   end
function Player:riseAbove()
  printDebug("🚀 Player climbing...")

  -- Get current room index (same as fallBelow)
  -- Love2D: Same approach works
  local currentRoomIndex = PlayerData.floor
  
  -- Search for upper room using the neighbor connection system
  -- This validates: 1) DoorsConnection has "Upper", 2) neighbourLevels has dir=">"
  -- Love2D: Same function works perfectly, no changes needed
  local upperRoomNumber, upperRoomData = GetUpperRoom(currentRoomIndex)

  if not upperRoomNumber then
    printDebug("⚠️  Cannot climb from this room")
    return
  end

  -- Translate room number to scene class (same as fallBelow)
  -- Love2D: Use your scene registry or scene manager
  local nextScene = RoomTranslate(upperRoomNumber)

  if nextScene then
    -- CRITICAL: Preserve player position (same as fallBelow)
    -- Love2D: Same approach works perfectly
    PlayerData.playerSpawn.x = self.x
    PlayerData.playerSpawn.y = self.y

    printDebug("✅ Transitioning to room:", upperRoomNumber)

    -- Transition with default animation (Playdate Noble framework)
    -- Love2D: Replace with your scene manager
    -- Example:
    -- SceneManager:switchTo(nextScene, {
    --   type = "fade",  -- or "climb" with upward motion
    --   duration = 1.5,
    --   onComplete = function() self:spawn() end
    -- })
    Noble.transition(nextScene, 1.5, Noble.Transition.Default)
  else
    printDebug("❌ Scene Floor" .. upperRoomNumber .. " not found")
    printDebug("⚠️  Cannot climb higher (no upper room)")
    -- Do nothing, player stays in current room
  end
end

function Player:displayDialog()
  self.dialogUI:nextDialog()
end

function Player:transformCycle()
    self.animation:setState('transformCycle')
end

function Player:startInvincibility(duration)
    self.isInvincible = true
    self.invincibilityTimer = duration
end

function Player:idle()
  if self.isAlive == true then
    if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
      self.animation:setState('lampIdle')
    else
      self.animation:setState('idle')
    end
    
    if PlayerData.isTiny == true then
      self.animation:setState('tinyIdle')
    end
    
    PlayerData.direction = 'idle'
  end
end

function Player:fight()
  PlayerData.amountDances += 1
  Noble.transition(DanceScene)
end

function Player:dead() -- unused
  self.isAlive = false
  local function deathScreen()

    Noble.transition(DeadScene)

  end
  playdate.timer.performAfterDelay(1000, deathScreen)
end

function Player:focus() -- unused
  if PlayerData.sanity > 20 then
    PlayerData.sanity -= 20
    PlayerData.isFocused = true
  end
end

function Player:shrink()
  PlayerData.isTiny = true
  self:setCollideRect(19, 32, 10, 10)
  self.animation:setState('transformTo')
end

function Player:grow()
    PlayerData.isTiny = false
    self:setCollideRect(8, 24, 30, 24)
    self:idle()
end

function Player:startMinifying()
    if not self.currentMinifier or PlayerData.isTalking or not PlayerData.isGaming then return end

    -- Lock player and center
    PlayerData.isGaming = false
    self.triggerEnteredOnce = true -- Stop trigger checks
    
    -- Auto center on minifier
    local targetX = self.currentMinifier.x
    local targetY = self.currentMinifier.y - 10
    self:moveTo(targetX, targetY)
    if shadow then shadow:moveTo(targetX, targetY) end

    -- Show crank prompt
    if not PlayerData.isTiny then
        self.uiHud:setCrankAntiClock()
    else
        self.uiHud:setCrankClock()
    end
    self:showUIHUD()

    -- Reset progress (size goes from playerSize to 0 or vice versa)
    PlayerData.actualPlayerSize = PlayerData.isTiny and 0 or PlayerData.playerSize
end

function Player:finishMinifying()
    PlayerData.isGaming = true
    self.triggerEnteredOnce = false
    self.uiHud:setVisible(false)
end
function Player:pedometer()
  PlayerData.steps += 0.5
  PlayerData.totalSteps += 0.5
  if PlayerData.steps >= 200 then
    PlayerData.steps = 0
    self:burnCalories(10)
  end
end
function Player:burnCalories(calories)
    PlayerData.calories -= calories
end

function Player:deFocus() -- unused
  if PlayerData.isFocused == true then
    PlayerData.isFocused = false
  end
end
function Player:showUIHUD()
  -- Base position above the player
  local hudX = self.x + self.playerUIX
  local hudYOffset = -40
  if PlayerData.isTiny then
    hudYOffset = -17
  end
  local hudY = self.y + hudYOffset -- normal default above player

  -- Adjust for top of screen
  if self.y < 60 then
    hudY = self.y + self.playerUIY / 2 -- move down instead of above
  end

  -- Adjust for right edge
  if self.x > 350 then
      hudX = self.x - self.playerUIX -- move to left of player
  end

  self.uiHud:moveTo(hudX, hudY)
  self.uiHud:setVisible(true)
end

function Player:checkMinifier()
    if self.currentMinifier then
        local stillInside = false
        for _, sprite in ipairs(self:overlappingSprites()) do
            if sprite == self.currentMinifier then
                stillInside = true
                break
            end
        end

        if not stillInside then
            self.uiHud:setVisible(false)
            self.currentMinifier = nil
            PlayerData.readyToShrink = false
        end
    end
end

function Player:checkTrigger()
    -- Check for dialog activation (A button)
    if self.currentTrigger and playdate.buttonJustPressed(playdate.kButtonA) then
        local trigger = self.currentTrigger

        PlayerData.isGaming = false
        PlayerData.isTalking = true
        self.dialogUI:addScreen(trigger:returnScript(), trigger.sourceFeed)

        Utilities.grantAchievementIfNeeded(trigger.script)
    end

    -- Performance: Only check overlapping sprites if player moved significantly
    local distanceMoved = math.abs(self.x - self.lastCheckX) + math.abs(self.y - self.lastCheckY)
    local shouldCheckOverlap = distanceMoved > 5 or self.currentTrigger ~= nil

    if shouldCheckOverlap then
      self.lastCheckX = self.x
      self.lastCheckY = self.y

      if self.currentTrigger then
        local stillInside = false
        for _, sprite in ipairs(self:overlappingSprites()) do
            if sprite == self.currentTrigger then
              stillInside = true

              self:showUIHUD()

              -- Solo se activa una vez cuando el jugador entra en el trigger
              if not self.triggerEnteredOnce then
                if self.currentTrigger.type == "Call" then
                  self.uiHud:setRing()
                elseif self.currentTrigger.type == "Search" then
                  self.uiHud:setInvestigate()
                elseif self.currentTrigger.type == nil then
                  self.uiHud:setPressA()
                end
                self.triggerEnteredOnce = true -- Marca que ya se ejecutó
              end

              break
            end
          end

          if not stillInside then
              self.uiHud:setVisible(false)
              self.currentTrigger = nil
              self.triggerEnteredOnce = false -- Reset para el próximo trigger
          end
      end
    end
end

function Player:update()
  -- Update dash movement if dashing
  self:updateDash()
  
  -- Update sliding movement if on slime
  self:updateSliding()

  -- Hide light cone after display time
  if self.lightConeHideTime and playdate.getCurrentTimeMilliseconds() >= self.lightConeHideTime then
    PlayerData.showLightCone = false
    self.lightConeHideTime = nil
  end

  self:setZIndex(self.y)
  
  self:checkTrigger()
  self:checkMinifier()

  -- if PlayerData.storyCounter == 4 then
  -- PlayerData.isRinging = true
  -- end

  -- Mark: save actual position
  PlayerData.x = self.x
  PlayerData.y = self.y
  -- Mark: battery bounds
  if PlayerData.battery < 0 then
    PlayerData.battery = 0
  elseif PlayerData.battery >= 100 then
    PlayerData.battery = 100
  end
  -- Mark: Reduce speed in the dark
  if PlayerData.items.hasLamp == true and PlayerData.isInDarkness == true then
    if PlayerData.battery < 20 then
      self.speed = 0.5 * self.initialSpeed
    elseif PlayerData.battery > 20 then
      self.speed = self.initialSpeed
    end
  end
  if PlayerData.isInDarkness == true and PlayerData.items.hasLamp == false then
    self.speed = 0.5 * self.initialSpeed
  end
  -- Mark: invincibility timer
  if self.isInvincible then
    local refreshRate = playdate.display.getRefreshRate() or 30
    self.invincibilityTimer -= 1000 / refreshRate
    
    -- Visual feedback: Flicker
    if math.floor(self.invincibilityTimer / 100) % 2 == 0 then
        self:setVisible(false)
    else
        self:setVisible(true)
    end
    
    if self.invincibilityTimer <= 0 then
      self.isInvincible = false
      self.invincibilityTimer = 0
      self:setVisible(true)
    end
  end

  PlayerData.isActive = false
  -- Performance: Achievement check removed from update loop (handled by events)
end
