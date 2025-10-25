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
    -- validar tener la bolsa de captura
    other:taken() 
    
  elseif other:isa(Box) then
    return 'freeze' 
    
  elseif other:isa(Trigger) then
  if other.type == "cutscene" then
      -- Cutscenes trigger automatically
      PlayerData.isGaming = false
      PlayerData.isCutscene = true
      other:returnScript()
      -- ⭐ DEBUG: Verificar que se marcó como usado
      print("🔍 Verificando trigger después de usar:")
      local roomData = levelsLDTK[PlayerData.floor]
      for _, t in ipairs(roomData.entities.Triggers) do
          if t.iid == other.iid then
              print("   usedTrigger:", t.customFields.usedTrigger)
              break
          end
      end
      other:remove()
      Utilities.grantAchievementIfNeeded(other.script)
  elseif other.type == "search" then
      self.currentTrigger = other
  elseif other.type == "call" then
      self.currentTrigger = other
  elseif other.type == "story" then
      PlayerData.isGaming = false
      PlayerData.isTalking = true
      self.dialogUI:addScreen(other:returnScript(),other.sourceFeed)
  elseif other.type == nil then
      self.currentTrigger = other
  elseif other.type == "counter" then
      PlayerData.storyCounter += 1
      other:remove()
  end
  return 'overlap'
  
  elseif other:isa(Items) and other.type == 'keycard' then
    other:removeAll()
    self:grabKey()
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
    
  elseif other:isa(PropItem) and (other.type == 'holeLeft' or other.type == 'holeRight')then
    
    if (PlayerData.hasBoots == true and PlayerData.battery == 0) or PlayerData.hasBoots == false  then
      self:fallBelow()
      return 'overlap'
    elseif PlayerData.hasBoots == true then
      
      self:drainBattery(1)
    return 'overlap'
    end
  elseif other:isa(PropItem) then
  return 'overlap'
  elseif other:isa(Door) then
    
    if (PlayerData.hasKey == true and other.status == 'closed') or other.status =='open' then
      other:prevRoom(other.direction)
      other:goTo()
      return 'overlap'
    else
      PlayerData.isTalking = true
      self.dialogUI:addScreen("nokeys")
      return 'freeze'
    end
  
  end
  
end