
function Player:grabBoots()
  PlayerData.items.hasBoots = true
end

function Player:grabBag()
  PlayerData.items.hasBag = true
end

function Player:grabTools()
  PlayerData.items.hasTools = true
end

function Player:grabKey(keyNumber)
  keyNumber = keyNumber or 1  -- Default to key 1 if no number provided
  PlayerData.keys[keyNumber] = true
end

function Player:grabLamp()
  PlayerData.items.hasLamp = true
  self:fillBattery()
end

function Player:grabRadio()
  PlayerData.items.hasRadio = true
end

function Player:grabNotes()
  PlayerData.items.hasNotes = true
  Utilities.grantAchievementIfNeeded("notebook")
end


