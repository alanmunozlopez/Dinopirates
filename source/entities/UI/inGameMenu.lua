inGameMenu = {}
class('inGameMenu').extends(Graphics.sprite)
import "entities/UI/itemMenu"
local shadow = Graphics.image.new(400,240) 

function inGameMenu:init()
  self.activeItem = PlayerData.activeItem 
  self:moveTo(200,120)
  self:setZIndex(ZIndex.ui)
  self:setImage(shadow)
  if PlayerData.items == nil then
    
  end
  lampItem = itemMenu("lamp",ZIndex.ui+1)
  bootItem = itemMenu("boot",ZIndex.ui+1)
  self:add()
end

function inGameMenu:displayMenu()
    PlayerData.isGaming = false
    PlayerData.isEquiping = true
    
    print("imma menu")
end

function inGameMenu:shadow()
  
    Graphics.pushContext(shadow)
      Graphics.setColor(Graphics.kColorBlack)
      Graphics.setDitherPattern(0.5, Graphics.image.kDitherTypeBayer8x8)
      Graphics.fillRect(0, 0, shadow:getSize()) -- Full screen darkness
    Graphics.popContext()
end
function inGameMenu:closeMenu()
    shadow:clear(Graphics.kColorClear)
    lampItem:remove()
    bootItem:remove()
    print('closing menu')
    -- remove all the icons also
end

function inGameMenu:prevItem()
    PlayerData.activeItem -= 1
end

function inGameMenu:nextItem()
    PlayerData.activeItem += 1
end

function inGameMenu:update()
  if table.getSize(PlayerData.items) > 0 then
      if PlayerData.activeItem < 1 then
        PlayerData.activeItem = table.getSize(PlayerData.items) 
      end
      if PlayerData.activeItem > table.getSize(PlayerData.items) then
        PlayerData.activeItem = 1
      end
      if PlayerData.isEquiping == true then  
        self:shadow()
        
        lampItem:show(30, 30)
        bootItem:show(64, 30)
        
      end
  end
  
end