inGameMenu = {}
class('inGameMenu').extends(Graphics.sprite)

function inGameMenu:init()
    
end

function inGameMenu:displayMenu()
    PlayerData.isGaming = false
    PlayerData.isEquiping = true
    print("imma menu")
end