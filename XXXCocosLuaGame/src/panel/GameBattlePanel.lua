--------------------------------------------------------------------------------
-- GameBattlePanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

local GameBattlePanel = class("GameBattlePanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameBattlePanel.create()
    local panel = GameBattlePanel.new()
    -- set the panel position
    panel:setAnchorPoint(0,0)
    panel:setPosition(0, visibleSize.height * 0.8)
    -- initialize the panel
    panel:initPanel()
    return panel
end

function GameBattlePanel:initPanel()

    -- Create the BackgroundLayer
    local backgroundLayer = self:createBackgroundLayer()
    self:addChild(backgroundLayer)

-- Create the ForegroundLayer
-- local foregroundLayer = self:createForegroundLayer()
-- self:addChild(foregroundLayer)

-- Create the TouchLayer
-- local touchLayer = self:createTouchLayer()
-- self:addChild(touchLayer)

end

-- Create the Background Layer for this panel

function GameBattlePanel:createBackgroundLayer()
    --local backgroundLayer = cc.Layer:create()

    -- TODO change the single color to the final sprite in te res file
    -- local backgroundSprite = cc.Sprite:create("")
    local backgroundColor = cc.c4b(255, 255, 0, 255)
    --backgroundLayer:setColor(backgroundColor)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height

    return backgroundLayer
end   

return GameBattlePanel