inGameMenu = {}
class('inGameMenu').extends(Graphics.sprite)
import "entities/UI/itemMenu"
import 'utilities/MapDrawer'

local shadow = Graphics.image.new(400,240)
local menuImage = Graphics.image.new('assets/images/ui/menu/ingame-menu')
local menuSprite = nil 

function inGameMenu:init()
  self.activeItem = PlayerData.activeItem 
  
  self:moveTo(200,120)
  self:setZIndex(ZIndex.ui)
  self:setImage(shadow)
  
  
  -- Crear sprite para el menú
  menuSprite = Graphics.sprite.new()
  menuSprite:setImage(menuImage)
  menuSprite:setCenter(0.5, 0.5)
  menuSprite:moveTo(200, 120)
  menuSprite:setZIndex(ZIndex.ui + 2)
  
  lampItem = itemMenu("lamp",ZIndex.ui+3)
  bootItem = itemMenu("boot",ZIndex.ui+3)
  self:add()
end

function inGameMenu:displayMenu(__x,__y)
    PlayerData.isGaming = false
    PlayerData.isEquiping = true
    self.playerX = __x
    self.playerY = __y
    self:drawMapOnMenu()
    
end

function inGameMenu:drawMapOnMenu()
    -- Draw the map on the menu image
    MapDrawer.drawMap(menuImage)
end

-- function inGameMenu:shadow()
  -- 
  --   Graphics.pushContext(shadow)
  --     Graphics.setColor(Graphics.kColorBlack)
  --     Graphics.setDitherPattern(0.4, Graphics.image.kDitherTypeBayer8x8)
  --     Graphics.fillRect(0, 0, shadow:getSize()) -- Full screen darkness
  --   Graphics.popContext()
-- end

function inGameMenu:closeMenu()
    shadow:clear(Graphics.kColorClear)
    lampItem:remove()
    bootItem:remove()
    if menuSprite then
        menuSprite:remove()
    end
    print('closing menu')
    -- remove all the icons also
end

function inGameMenu:prevItem()
    PlayerData.activeItem -= 1
end

function inGameMenu:nextItem()
    PlayerData.activeItem += 1
end

function inGameMenu:selectItem()
    print("Item selected: " .. PlayerData.activeItem)
    -- Aquí puedes agregar la lógica específica para cada item
    if PlayerData.activeItem == 1 and PlayerData.items.hasLamp == true then
        print("Lamp selected!")
        -- Acción para la lámpara
    elseif PlayerData.activeItem == 2 and PlayerData.items.hasBoots == true then
        print("Boot selected!")
        -- Acción para las botas
    end
end

function inGameMenu:update()
  drawStatusText(menuImage)
  if table.getSize(PlayerData.items) > 0 then
    
      if PlayerData.activeItem < 1 then
        PlayerData.activeItem = table.getSize(PlayerData.items) 
      end
      if PlayerData.activeItem > table.getSize(PlayerData.items) then
        PlayerData.activeItem = 1
      end
      if PlayerData.isEquiping == true then  
        -- self:shadow()
        if menuSprite then
            menuSprite:add()
        end
        if PlayerData.items.hasLamp == true then
          lampItem:show(18, 151)
        end
        if PlayerData.items.hasBoots == true then
          bootItem:show(48, 153)
        end
        
        
      end
  end
  
end