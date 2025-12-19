inGameMenu = {}
class('inGameMenu').extends(Graphics.sprite)
import "entities/UI/itemMenu"
import "entities/props/hats"
import 'utilities/MapDrawer'

local shadow = Graphics.image.new(400,240)
local menuImage = Graphics.image.new('assets/images/ui/menu/ingame-menu')
local menuSprite = nil

-- Crew member hat images
local hatImages = {}
local hatSpriteSheet = Graphics.imagetable.new('assets/images/props/hats') 

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

function inGameMenu:displayMenu()
    print("📋 displayMenu called!")
    PlayerData.isGaming = false
    PlayerData.isEquiping = true
    
    self:drawMapOnMenu()
    
    -- Create hat sprites when menu opens
    print("📋 Checking if crew members captured:", PlayerData.CrewMemberData.amountTaken)
    if PlayerData.CrewMemberData.amountTaken > 0 then
        print("📋 Calling drawCrewHats...")
        self:drawCrewHats()
    else
        print("📋 No crew members captured yet")
    end
end

function inGameMenu:drawMapOnMenu()
    -- Draw the map on the menu image
    MapDrawer.drawMap(menuImage)
end

function inGameMenu:drawCrewHats()
    -- Create sprites for captured crew member hats in the menu
    print("🎩 drawCrewHats called!")
    print("🎩 amountTaken:", PlayerData.CrewMemberData.amountTaken)
    
    local hatX = 232  -- Starting X position for hats (center of screen)
    local hatY = 13  -- Y position for hats (center of screen)
    local hatSpacing = 20  -- Space between hats
    local hatIndex = 0
    
    -- Remove any existing hat sprites first
    if self.hatSprites then
        for _, hatSprite in ipairs(self.hatSprites) do
            if hatSprite then
                hatSprite:remove()
            end
        end
    end
    self.hatSprites = {}
    
    -- Check each crew member and create a sprite for their hat if captured
    if PlayerData.CrewMemberData and PlayerData.CrewMemberData.idNumbers then
        print("🎩 Checking crew members...")
        for crewId, isCaptured in pairs(PlayerData.CrewMemberData.idNumbers) do
            print("🎩 CrewID:", crewId, "Captured:", isCaptured)
            if isCaptured then
                -- Get the hat image based on crew ID
                local hatFrameIndex = 1  -- Default to first frame
                if crewId == "CM001" then
                    hatFrameIndex = 1
                elseif crewId == "CM002" then
                    hatFrameIndex = 2
                elseif crewId == "CM003" then
                    hatFrameIndex = 3
                end
                
                print("🎩 Creating hat sprite for", crewId, "frame:", hatFrameIndex)
                
                -- Create a sprite for this hat
                local hatImage = hatSpriteSheet:getImage(hatFrameIndex)
                if hatImage then
                    print("🎩 Hat image loaded, size:", hatImage:getSize())
                    local hatSprite = Graphics.sprite.new(hatImage)
                    hatSprite:setCenter(0, 0)
                    hatSprite:moveTo(hatX + (hatIndex * hatSpacing), hatY)
                    hatSprite:setZIndex(ZIndex.ui + 9)
                    hatSprite:add()
                    table.insert(self.hatSprites, hatSprite)
                    print("🎩 Hat sprite created at:", hatX + (hatIndex * hatSpacing), hatY, "zIndex:", ZIndex.ui + 9)
                    hatIndex += 1
                else
                    print("🎩 ERROR: Could not load hat image for frame", hatFrameIndex)
                end
            end
        end
        print("🎩 Total hats created:", hatIndex)
    else
        print("🎩 ERROR: CrewMemberData or idNumbers is nil")
    end
end

function inGameMenu:closeMenu()
    shadow:clear(Graphics.kColorClear)
    lampItem:remove()
    bootItem:remove()
    if menuSprite then
        menuSprite:remove()
    end
    -- Remove hat sprites
    if self.hatSprites then
        for _, hatSprite in ipairs(self.hatSprites) do
            if hatSprite then
                hatSprite:remove()
            end
        end
        self.hatSprites = nil
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