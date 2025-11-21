-- Create a new module for save management
SaveSystem = {}

-------------------------------------------------------------
-- Extract necessary level data
-------------------------------------------------------------
function SaveSystem.getLevelState()
    local levelState = {}

    for i, level in ipairs(levelsLDTK) do
        levelState[i] = {
            identifier = level.identifier,
            uniqueIdentifer = level.uniqueIdentifer,

            visited = level.customFields.visited or false,
            comic_wasPlayed = level.customFields.comic_wasPlayed or false,

            entities = {}
        }

        if level.entities then
            for entityType, entitiesList in pairs(level.entities) do
                levelState[i].entities[entityType] = {}

                for _, entity in ipairs(entitiesList) do
                    local entityState = {
                        iid = entity.iid
                    }

                    if entity.customFields then
                        -- Enemies
                        if entityType == "Brocorat" or entityType == "Bosscolli" then
                            entityState.dead = entity.customFields.dead or false
                            entityState.speed = entity.customFields.speed
                            entityState.x = entity.x
                            entityState.y = entity.y
                        end

                        -- Props
                        if entity.customFields.destroyed ~= nil then
                            entityState.destroyed = entity.customFields.destroyed
                        end

                        -- CrewMembers
                        if entityType == "CrewMember" then
                            entityState.isTaken = entity.customFields.isTaken or false
                            entityState.crewID = entity.customFields.crewID
                        end

                        -- Items
                        if entity.layer == "Items" then
                            entityState.collected = false
                        end

                        -- Triggers (FALLA ORIGINAL: se guardaba bien)
                        if entityType == "Triggers" or entity.layer == "Triggers" then
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


-------------------------------------------------------------
-- Restore level state (Corregido)
-------------------------------------------------------------
function SaveSystem.restoreLevelState(levelState)
    if not levelState then return end

    for i, state in ipairs(levelState) do
        if levelsLDTK[i] then

            -- Check uniqueIdentifer in case order changed
            if levelsLDTK[i].uniqueIdentifer ~= state.uniqueIdentifer then
                print("⚠️ Level mismatch at index", i)
                for j, level in ipairs(levelsLDTK) do
                    if level.uniqueIdentifer == state.uniqueIdentifer then
                        print("✅ Found correct level at index", j)
                        i = j
                        break
                    end
                end
            end

            -- Restore simple fields
            levelsLDTK[i].customFields.visited = state.visited
            levelsLDTK[i].customFields.comic_wasPlayed = state.comic_wasPlayed

            if not (state.entities and levelsLDTK[i].entities) then
                goto continue
            end

            -------------------------------------------------
            -- ENTITY RESTORATION (with Trigger fallback)
            -------------------------------------------------
            for entityType, savedEntities in pairs(state.entities) do
                local targetList = levelsLDTK[i].entities[entityType]

                -- 🔥 Fallback: if entityType does not match, try by layer = "Triggers"
                if not targetList and (entityType == "Triggers") then
                    for key, list in pairs(levelsLDTK[i].entities) do
                        if list[1] and list[1].layer == "Triggers" then
                            print("🔄 Fallback: redirecting Triggers →", key)
                            targetList = list
                            break
                        end
                    end
                end

                if targetList then
                    for _, savedEntity in ipairs(savedEntities) do
                        for _, currentEntity in ipairs(targetList) do
                            if currentEntity.iid == savedEntity.iid then
                                
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

                                    -- ⭐ TRIGGERS (fix)
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
            ::continue::
        end
    end
end


-------------------------------------------------------------
-- Save
-------------------------------------------------------------
function SaveSystem.save()
    local saveData = {
        player = PlayerData,
        levelState = SaveSystem.getLevelState(),
        timestamp = playdate.getTime(),
        version = "2.0-LDTK"
    }

    playdate.datastore.write(saveData, 'gameState', true)
    print("💾 Game saved successfully")
end


-------------------------------------------------------------
-- Load
-------------------------------------------------------------
function SaveSystem.load()
    local saveData = playdate.datastore.read('gameState')
    
    if saveData then
        if saveData.version == "2.0-LDTK" then
            PlayerData = saveData.player
            SaveSystem.restoreLevelState(saveData.levelState)
            print("✅ Save loaded (LDTK format)")
            return true, saveData.player.saveLevel
        else
            print("⚠️ Old save format detected, migration needed")
            return false, nil
        end
    end

    print("📭 No save file found")
    return false, nil
end


-------------------------------------------------------------
-- Reset
-------------------------------------------------------------
function SaveSystem.reset()
    PlayerData = table.deepcopy(PlayerDataOriginal)
    if levelsLDTKOriginal then
        levelsLDTK = table.deepcopy(levelsLDTKOriginal)
    end
    print("🔄 Game state reset")
end


-------------------------------------------------------------
-- Delete save
-------------------------------------------------------------
function SaveSystem.delete()
    playdate.file.delete('gameState.json')
    PlayerData = table.deepcopy(PlayerDataOriginal)

    if levelsLDTKOriginal then
        levelsLDTK = table.deepcopy(levelsLDTKOriginal)
    end

    print("🗑️ Save deleted")
end


-------------------------------------------------------------
-- Backup original level data
-------------------------------------------------------------
function SaveSystem.createOriginalBackup()
    if not levelsLDTKOriginal then
        levelsLDTKOriginal = table.deepcopy(levelsLDTK)
        print("📋 Original levelsLDTK backup created")
    end
end

return SaveSystem