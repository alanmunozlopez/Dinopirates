Trigger = {}
class('Trigger').extends(Graphics.sprite)

function Trigger:init(x, y, width, height, script, iid, room, type)
    self.script = script
    self.iid = iid  -- ⭐ CORREGIDO: Ahora recibe el iid correctamente
    self.room = room
    self.type = type
    
    self:setCollideRect(0, 0, width, height)
    self:setZIndex(3)
    self:moveTo(x - width / 2, y - height / 2)
    self:setGroups(3)
    self:add()
    
    print("🎯 Trigger creado - iid:", self.iid, "type:", self.type, "script:", self.script)
end

function Trigger:returnScript()
    self:clearCollideRect()
    
    local roomData = levelsLDTK[self.room]
    if not roomData or not roomData.entities or not roomData.entities.Triggers then
        print("⚠️ No trigger data found for room:", self.room)
        return self.script
    end
    
    -- Marcar como usado
    for _, triggerData in ipairs(roomData.entities.Triggers) do
        if triggerData.iid == self.iid then
            local cf = triggerData.customFields or {}
            cf.usedTrigger = true  -- ⭐ Usar usedTrigger (como está en tu levelsLDTK)
            print("✅ Trigger marcado como usado:", triggerData.iid)
            break
        end
    end
    
    return self.script
end

-- ⭐ Función alternativa para marcar como usado sin clearCollideRect
function Trigger:markAsUsed()
    local roomData = levelsLDTK[self.room]
    
    if not roomData or not roomData.entities or not roomData.entities.Triggers then
        print("⚠️ No trigger data found for room:", self.room)
        return
    end
    
    for _, triggerData in ipairs(roomData.entities.Triggers) do
        if triggerData.iid == self.iid then
            local cf = triggerData.customFields or {}
            cf.usedTrigger = true
            print("✅ Trigger marcado como usado:", triggerData.iid)
            break
        end
    end
end