-- Create a new module for save management
SaveSystem = {}

-- Function to extract only the necessary level data we want to save
function SaveSystem.getLevelState()
    local levelState = {}

    for i, level in ipairs(levels) do
        levelState[i] = {
            visited = level.floor.visited or false,
            -- Save state of items (collected/not collected)
            items = {},
            -- Save state of triggers (used/not used)
            triggers = {},
            -- Save state of enemies (defeated/position/etc)
            enemies = {}
        }

        -- Save items state
        if level.floor.items then
            for j, item in ipairs(level.floor.items) do
                levelState[i].items[j] = {
                    collected = item.collected or false,
                    type = item.type
                }
            end
        end

        -- Save triggers state
        if level.floor.triggers then
            for j, trigger in ipairs(level.floor.triggers) do
                levelState[i].triggers[j] = {
                    usedTrigger = trigger.usedTrigger or false
                }
            end
        end

        -- Save enemies state
        if level.floor.enemies then
            for j, enemy in ipairs(level.floor.enemies) do
                levelState[i].enemies[j] = {
                    id = enemy.id,
                    name = enemy.name,
                    x = enemy.x,
                    y = enemy.y,
                    speed = enemy.speed,
                    dead = enemy.dead or false
                }
            end
        end
    end

    return levelState
end

-- Function to restore level state from saved data
function SaveSystem.restoreLevelState(levelState)
    if not levelState then return end

    for i, state in ipairs(levelState) do
        if levels[i] then
            -- Restore visited state
            levels[i].floor.visited = state.visited

            -- Restore items state
            if state.items and levels[i].floor.items then
                for j, itemState in ipairs(state.items) do
                    if levels[i].floor.items[j] then
                        levels[i].floor.items[j].collected = itemState.collected
                    end
                end
            end

            -- Restore triggers state
            if state.triggers and levels[i].floor.triggers then
                for j, triggerState in ipairs(state.triggers) do
                    if levels[i].floor.triggers[j] then
                        levels[i].floor.triggers[j].usedTrigger = triggerState.usedTrigger
                    end
                end
            end

            -- Restore enemies state
            if state.enemies and levels[i].floor.enemies then
                for j, enemyState in ipairs(state.enemies) do
                    if levels[i].floor.enemies[j] then
                        levels[i].floor.enemies[j].id = enemyState.id
                        levels[i].floor.enemies[j].name = enemyState.name
                        levels[i].floor.enemies[j].x = enemyState.x
                        levels[i].floor.enemies[j].y = enemyState.y
                        levels[i].floor.enemies[j].speed = enemyState.speed
                        levels[i].floor.enemies[j].dead = enemyState.dead
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
        timestamp = playdate.getTime()
    }

    playdate.datastore.write(saveData, 'gameState', true)
end

-- Updated load function
function SaveSystem.load()
    local saveData = playdate.datastore.read('gameState')
    if saveData then
        PlayerData = saveData.player
        SaveSystem.restoreLevelState(saveData.levelState)
        return true
    end
    return false
end

-- Reset game state
function SaveSystem.reset()
    PlayerData = table.deepcopy(PlayerDataOriginal)
    levels = playdate.datastore.read('levelOriginal')
end

-- Delete save
function SaveSystem.delete()
    playdate.file.delete('gameState.json')
end

return SaveSystem