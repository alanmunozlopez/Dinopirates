
function Player:grabBoots()
  PlayerData.items.hasBoots = true
  table.insert(PlayerData.items,"boots")
end

function Player:grabBag()
  PlayerData.items.hasBag = true
  table.insert(PlayerData.items,"bag")
end

function Player:grabTools()
  PlayerData.items.hasTools = true
  table.insert(PlayerData.items,"tools")
end

function Player:grabKey(keyNumber)
  keyNumber = keyNumber or 1  -- Default to key 1 if no number provided
  PlayerData.keys[keyNumber] = true
  printDebug("🔑 Key collected:", keyNumber)
end

function Player:grabLamp()
  PlayerData.items.hasLamp = true
  table.insert(PlayerData.items,"lamp")
  self:fillBattery()
end

function Player:grabRadio()
  
  PlayerData.items.hasRadio = true
end

function Player:grabNotes()
  PlayerData.items.hasNotes = true
  Utilities.grantAchievementIfNeeded("notebook")
end


