function Player:sanityCheck()

  local function checkSanity()
    local lastSanity = PlayerData.sanity 
    if PlayerData.battery < 20 and PlayerData.isInDarkness == true then 
      PlayerData.sanity -= 2 * self.sanityLoss
    elseif PlayerData.battery < 40 and PlayerData.isInDarkness == true then
      PlayerData.sanity -= self.sanityLoss
    end

    -- Check if sanity just reached zero
    if PlayerData.sanity <= 0 and lastSanity > 0 then
      PlayerData.sanityCounter += 1
      PlayerData.sanity = 0
    end

    if PlayerData.battery > 50 or PlayerData.isInDarkness == false then
      PlayerData.sanity += 2 * self.sanityLoss
    end

    if PlayerData.sanity >= 100 then
      PlayerData.sanity = 100
    end
    
    if PlayerData.sanity <= 0 then
      PlayerData.sanity = 0
    end

    -- Update lastSanity for the next check
    lastSanity = PlayerData.sanity
  end

  playdate.timer.keyRepeatTimerWithDelay(2000, 2000, checkSanity)
end

function Player:drainBattery(amount)
  PlayerData.battery -= amount
end

function Player:chargeBattery(amount)
  if PlayerData.battery < 100 and PlayerData.hasLamp == true then
    self.animation:setState('charge')
  elseif (PlayerData.hasLamp == true) then
    self.animation:setState('lampIdle')
  end
  PlayerData.battery += amount
  PlayerData.isActive = true
end

function Player:fillBattery()
    PlayerData.battery = 100
end
