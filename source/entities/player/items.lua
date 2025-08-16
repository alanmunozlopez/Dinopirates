
function Player:grabBoots()
  PlayerData.hasBoots = true
  table.insert(PlayerData.items,"boots")
end

function Player:grabBag()
  PlayerData.hasBag = true
  table.insert(PlayerData.items,"bag")
end

function Player:grabTools()
  PlayerData.hasTools = true
  table.insert(PlayerData.items,"tools")
end

function Player:grabKey()
  PlayerData.hasKey = true
end

function Player:grabLamp()
  PlayerData.hasLamp = true
  table.insert(PlayerData.items,"lamp")
  self:fillBattery()
end

function Player:grabRadio()
  
  PlayerData.hasRadio = true
end

function Player:grabNotes()
  PlayerData.hasNotes = true
  Utilities.grantAchievementIfNeeded("notebook")
end


