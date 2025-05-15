Trigger = {}
class('Trigger').extends(Graphics.sprite)

function Trigger:init(x, y, width, height, script, position, room, type)
  self.script = script
  self.position = position
  self.room = room
  self.type = type
  self:setCollideRect(0, 0, width,height)
  --self:setCenter(0.5, 0.5)
  self:setZIndex(3)
  self:moveTo(x-width/2, y-height/2)
  self:setGroups(3)
  self:add()
end

function Trigger:returnScript()
    self:clearCollideRect()
    levels[self.room].floor.triggers[self.position].usedTrigger = true
    return self.script
end
