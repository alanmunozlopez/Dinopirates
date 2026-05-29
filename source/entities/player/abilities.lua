function Player:useAbility()
    if not self.isAlive or PlayerData.isGaming ~= true then
        return
    end
    if PlayerData.isInDarkness then
        self:useLampAbility()
    else
        self:usePlungeAbility()
    end
end

function Player:useLampAbility()
    self:lightBurst()
end

function Player:usePlungeAbility()
    self:plunge()
end
