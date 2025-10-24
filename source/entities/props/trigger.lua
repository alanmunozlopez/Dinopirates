Trigger = {}
class('Trigger').extends(Graphics.sprite)

function Trigger:init(x, y, width, height, script, position, room, type)
    self.script = script
    self.position = position
    self.room = room
    self.type = type
    self.iid = nil -- será asignado después en scene:enter()
    self:setCollideRect(0, 0, width, height)
    self:setZIndex(3)
    self:moveTo(x - width / 2, y - height / 2)
    self:setGroups(3)
    self:add()
end

function Trigger:returnScript()
  self:clearCollideRect()

  local roomData = levelsLDTK[self.room]
  if not roomData or not roomData.entities or not roomData.entities.Triggers then
    print("⚠️ No trigger data found for room:", self.room)
    return self.script
  end

  for _, triggerData in ipairs(roomData.entities.Triggers) do
    -- Buscar el trigger correspondiente por su IID único
    if triggerData.iid == self.iid then
      local cf = triggerData.customFields or {}
      cf.usedTrigger = true
      print("🎬 Trigger marked as used:", triggerData.iid)
      break
    end
  end

  return self.script
end

function Trigger:markAsUsed()
    local entities = levelsLDTK[self.room].entities
    
    if entities and entities.Triggers then
        for _, trigger in ipairs(entities.Triggers) do
            if trigger.iid == self.id then  -- Ahora self.id es el iid
                trigger.customFields.used = true
                print("✅ Trigger marcado como usado:", self.id)
                return
            end
        end
    end
end