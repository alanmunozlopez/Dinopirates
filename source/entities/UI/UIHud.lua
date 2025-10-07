class("UIHud").extends(NobleSprite)


function UIHud:init(x,y)
    UIHud.super.init(self,'assets/images/ui/interaction.png', true)
    -- Mark: animation states
    self.animation:addState('pressA', 1, 6)
    self.animation.pressA.frameDuration = 6
    
    self.animation:setState('pressA')
    -- Mark: properties (since are the sames from the sonar hud maybe this should be just a class)
    self:setSize(22,37)
    self:setZIndex(ZIndex.ui)
    self:add(x + 30,y - 30)
    self:setVisible(false)
end



