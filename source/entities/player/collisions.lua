function Player:collisionResponse(other)
  
  if other:isa(Enemy) then
    if other:isa(Brocorat) then -- validate candance also
      PlayerData.lastEnemyTouched.type = "Brocorat"
      PlayerData.lastEnemyTouched.id = other.id
      PlayerData.lastEnemyTouched.x = other.x
      PlayerData.lastEnemyTouched.y = other.y
      self:fight()
      return 'overlap'
      
    end
    
  elseif other:isa(CrewMember) then
    -- Validate having the capture bag
    if PlayerData.CrewMemberData.amountTaken == 0 then
      self.dialogUI:addScreen("gotcha",other.sourceFeed)
    end
    other:taken() 
    
  elseif other:isa(Box) then
    return 'freeze' 
    
  elseif other:isa(Trigger) then
  if other.type == "Cutscene" then
      -- Cutscenes trigger automatically
      PlayerData.isGaming = false
      PlayerData.isCutscene = true
      other:returnScript()
      printDebug("🔍 Verificando trigger después de usar:")
      local roomData = levelsLDTK[PlayerData.floor]
      for _, t in ipairs(roomData.entities.Triggers) do
          if t.iid == other.iid then
              printDebug("   usedTrigger:", t.customFields.usedTrigger)
              break
          end
      end
      other:remove()
      Utilities.grantAchievementIfNeeded(other.script)
  elseif other.type == "Search" then
      self.currentTrigger = other
  elseif other.type == "Call" then
      self.currentTrigger = other
  elseif other.type == "Story" then
      PlayerData.isGaming = false
      self.dialogUI:addScreen(other:returnScript(),other.sourceFeed)
  elseif other.type == nil then
      self.currentTrigger = other
  elseif other.type == "Counter" then
      PlayerData.storyCounter += 1
      other:remove()
  end
  return 'overlap'
  
  elseif other:isa(Items) and other.type == 'keycard' then
    local keyNumber = other.keyNumber or 1  -- Get key number from item
    other:removeAll()
    self:grabKey(keyNumber)
    return 'overlap'
    
  elseif other:isa(Items) and other.type == 'lamp' then
    other:removeAll()
    self:grabLamp()
    return 'overlap'
    
  elseif other:isa(Items) and other.type == 'radio' then
    other:removeAll()
    self:grabRadio()
    return 'overlap'
    
  elseif other:isa(Items) and other.type == 'notes' then
    other:removeAll()
    self:grabNotes()
    return 'overlap'
    
  elseif other:isa(Items) and other.type == 'bag' then
    other:removeAll()
    self:grabBag()
    return 'overlap'
    
  elseif other:isa(Items) and other.type == 'honk' then
    other:removeAll()
    self:grabBag()
  return 'overlap'
  
  elseif other:isa(Items) and other.type == 'tools' then
    other:removeAll()
    self:grabTools()
  return 'overlap'
    
  elseif other:isa(PropItem) and other.isHole then
  -- ⭐ Handle ALL hole types
  
  -- If player has boots with battery, can walk over the hole
  if PlayerData.hasBoots == true and PlayerData.battery > 0 then
      self:drainBattery(1)
      return 'overlap'
  else
      -- Without boots or without battery = fall
      self:fallBelow()
      return 'overlap'
  end
  elseif other:isa(PropItem) then
  return 'overlap'
  elseif other:isa(Door) then
    
    if other.status == 'open' then
      -- Door is open, allow passage
      other:prevRoom(other.direction)
      other:goTo()
      return 'overlap'
    elseif other.status == 'closed' then
      -- Door is closed, check if player has the required key
      local requiredKey = other.keyNumber or 1  -- Default to key 1 if not specified
      
      if PlayerData.keys[requiredKey] == true then
        -- Player has the correct key
        printDebug("🔓 Door unlocked with key", requiredKey)
        other:prevRoom(other.direction)
        other:goTo()
        return 'overlap'
      else
        -- Player doesn't have the required key
        printDebug("🔒 Door locked, requires key", requiredKey)
        self.dialogUI:addScreen("nokeys")
        return 'freeze'
      end
    end
  
  end
  
end