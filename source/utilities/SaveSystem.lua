-- Create a new module for save management
SaveSystem = {}

-- Function to extract only the necessary level data from levelsLDTK
function SaveSystem.getLevelState()
    local levelState = {}

    for i, level in ipairs(levelsLDTK) do
        levelState[i] = {
            -- Identificadores para verificar que es el nivel correcto
            identifier = level.identifier,
            uniqueIdentifer = level.uniqueIdentifer,
            
            -- Custom fields que pueden cambiar durante el juego
            visited = level.customFields.visited or false,
            comic_wasPlayed = level.customFields.comic_wasPlayed or false,
            
            -- Estado de entidades (enemies, props, items, crewMembers)
            entities = {}
        }

        -- Guardar estado de todas las entidades
        if level.entities then
            for entityType, entitiesList in pairs(level.entities) do
                levelState[i].entities[entityType] = {}
                
                for j, entity in ipairs(entitiesList) do
                    local entityState = {
                        iid = entity.iid  -- ID único para identificar la entidad
                    }
                    
                    -- Guardar customFields que pueden cambiar
                    if entity.customFields then
                        -- Enemies: dead, speed, position
                        if entityType == "Brocorat" or entityType == "Bosscolli" then
                            entityState.dead = entity.customFields.dead or false
                            entityState.speed = entity.customFields.speed
                            entityState.x = entity.x
                            entityState.y = entity.y
                        end
                        
                        -- Props: destroyed
                        if entity.customFields.destroyed ~= nil then
                            entityState.destroyed = entity.customFields.destroyed
                        end
                        
                        -- CrewMembers: isTaken
                        if entityType == "CrewMember" then
                            entityState.isTaken = entity.customFields.isTaken or false
                            entityState.crewID = entity.customFields.crewID
                        end
                        
                        -- Items: se manejan con PlayerData, pero podemos guardar si existen
                        if entity.layer == "Items" then
                            entityState.collected = false -- Esto se infiere de PlayerData
                        end
                        
                        -- Triggers: type, script, usado
                        if entityType == "Triggers" then
                            entityState.type = entity.customFields.type
                            entityState.script = entity.customFields.script
                            entityState.used = entity.customFields.used or false
                        end
                    end
                    
                    table.insert(levelState[i].entities[entityType], entityState)
                end
            end
        end
    end

    return levelState
end

-- Function to restore level state from saved data
function SaveSystem.restoreLevelState(levelState)
    if not levelState then return end

    for i, state in ipairs(levelState) do
        if levelsLDTK[i] then
            -- Verificar que sea el nivel correcto (por si cambia el orden)
            if levelsLDTK[i].uniqueIdentifer ~= state.uniqueIdentifer then
                print("⚠️  Warning: Level mismatch at index", i)
                -- Buscar el nivel correcto por uniqueIdentifer
                for j, level in ipairs(levelsLDTK) do
                    if level.uniqueIdentifer == state.uniqueIdentifer then
                        print("✅ Found correct level at index", j)
                        i = j
                        break
                    end
                end
            end
            
            -- Restaurar customFields
            levelsLDTK[i].customFields.visited = state.visited
            levelsLDTK[i].customFields.comic_wasPlayed = state.comic_wasPlayed

            -- Restaurar estado de entidades
            if state.entities and levelsLDTK[i].entities then
                for entityType, savedEntities in pairs(state.entities) do
                    if levelsLDTK[i].entities[entityType] then
                        for _, savedEntity in ipairs(savedEntities) do
                            -- Buscar la entidad por su iid
                            for _, currentEntity in ipairs(levelsLDTK[i].entities[entityType]) do
                                if currentEntity.iid == savedEntity.iid then
                                    -- Restaurar customFields
                                    if currentEntity.customFields then
                                        -- Enemies
                                        if savedEntity.dead ~= nil then
                                            currentEntity.customFields.dead = savedEntity.dead
                                        end
                                        if savedEntity.speed then
                                            currentEntity.customFields.speed = savedEntity.speed
                                        end
                                        if savedEntity.x and savedEntity.y then
                                            currentEntity.x = savedEntity.x
                                            currentEntity.y = savedEntity.y
                                        end
                                        
                                        -- Props
                                        if savedEntity.destroyed ~= nil then
                                            currentEntity.customFields.destroyed = savedEntity.destroyed
                                        end
                                        
                                        -- CrewMembers
                                        if savedEntity.isTaken ~= nil then
                                            currentEntity.customFields.isTaken = savedEntity.isTaken
                                        end
                                        
                                        -- Triggers
                                        if savedEntity.used ~= nil then
                                            currentEntity.customFields.used = savedEntity.used
                                        end
                                    end
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Updated save function
function SaveSystem.save()
    local saveData = {
        player = PlayerData,
        levelState = SaveSystem.getLevelState(),
        timestamp = playdate.getTime(),
        version = "2.0-LDTK"  -- Versión para identificar el formato
    }

    playdate.datastore.write(saveData, 'gameState', true)
    print("💾 Game saved successfully")
end

-- Updated load function
function SaveSystem.load()
    local saveData = playdate.datastore.read('gameState')
    if saveData then
        -- Verificar si es el formato nuevo
        if saveData.version == "2.0-LDTK" then
            PlayerData = saveData.player
            SaveSystem.restoreLevelState(saveData.levelState)
            print("✅ Save loaded (LDTK format)")
            return true, saveData.player.saveLevel  
        else
            print("⚠️  Old save format detected, migration needed")
            return false, nil
        end
    end
    print("📭 No save file found")
    return false, nil
end

-- Reset game state
function SaveSystem.reset()
    PlayerData = table.deepcopy(PlayerDataOriginal)
    -- Restaurar levelsLDTK original si tienes una copia
    if levelsLDTKOriginal then
        levelsLDTK = table.deepcopy(levelsLDTKOriginal)
    end
    print("🔄 Game state reset")
end

-- Delete save
function SaveSystem.delete()
    playdate.file.delete('gameState.json')
    
    PlayerData = table.deepcopy(PlayerDataOriginal)
    -- Restaurar levelsLDTK original
    if levelsLDTKOriginal then
        levelsLDTK = table.deepcopy(levelsLDTKOriginal)
    end
    print("🗑️  Save deleted")
end

-- Helper function: Create a backup of original levelsLDTK
function SaveSystem.createOriginalBackup()
    if not levelsLDTKOriginal then
        levelsLDTKOriginal = table.deepcopy(levelsLDTK)
        print("📋 Original levelsLDTK backup created")
    end
end

return SaveSystem