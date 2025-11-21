Door = {}
class('Door').extends(NobleSprite)

local animationStates = {
  normalClosed = 18,
  reverseClosed = 9,
  normalOpen = 10,
  reverseOpen = 1
}

local positions = { -- art
  right = {x = 393, y = 122},
  left = {x = 4, y = 122},
  down = {x = 203, y = 230},
  top = {x = 203, y = 0}
}

local function setRectValues(direction)
  local rectValues = {
    right = {0, 0, 16, 50},
    left = {0, 0, 14, 50},
    down = {0, 0, 50, 16},
    top = {0, 0, 50, 16},
  }
  return table.unpack(rectValues[direction])
end

function Door:init(direction, status, nextRoom, zIndex)
  
  self.nextRoom = RoomTranslate(nextRoom)
  self.direction = direction
  self.status = status
  
  local isHorizontal = direction == 'top' or direction == 'down'
  -- local asset = isHorizontal and 'assets/images/props/door-horizontal' or 'assets/images/props/door-vertical'
  local sizeX, sizeY = isHorizontal and 56 or 10, isHorizontal and 10 or 56
  local rectX, rectY, rectW, rectH = setRectValues(direction)

  Door.super.init(self, asset, true)
  self:setSize(sizeX, sizeY)
  self:setCollideRect(rectX, rectY, rectW, rectH)

  -- for state, frame in pairs(animationStates) do
  --   self.animation:addState(state, frame, frame)
  --   self.animation[state].frameDuration = 12
  -- end

  local isNormal = direction == 'top' or direction == 'right'
  local statePrefix = isNormal and 'normal' or 'reverse'
  -- self.animation:setState(statePrefix .. (status == 'closed' and 'Closed' or 'Open'))
  

  local position = positions[direction]
  self:setZIndex(zIndex)
  self:setGroups(3)
  self:add(position.x, position.y)
end

function Door:goTo()
  Noble.transition(self.nextRoom, 1.5, Noble.Transition.Default)

  -- Noble.transition(self.nextRoom, 1.5, Noble.Transition.Imagetable,
  --   {imagetableEnter = Graphics.imagetable.new('assets/images/screens/transitions/testTransition')
  -- })
    
end

function Door:prevRoom(direction)
    PlayerData.lastRoom = direction
    local spawnCoordinates = {
        top = {x = 196, y = 196},
        down = {x = 200, y = 32},
        right = {x = 34, y = 116},
        left = {x = 364, y = 116}
    }
    PlayerData.playerSpawn.x = spawnCoordinates[direction].x
    PlayerData.playerSpawn.y = spawnCoordinates[direction].y
end

function Door:collisionResponse(other)
  -- no use
	-- if other.type == "player" then
	-- 	if self.isOpen then
	-- 		-- Save current state before transition
	-- 		Noble.transition(MazeScene, {
	-- 			nextLevel = self.nextLevel,
	-- 			nextRoom = self.nextRoom,
	-- 			enterDoor = self.doorID,
	-- 			playerData = other:getPlayerData()
	-- 		},0.3, Noble.Transition.MetroNexus)  
	-- 	end
	-- end
	return "overlap"
end