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
    
    local monster = cc.Sprite:create("res/imgs/monster/Pikachu.png")
    monster:setPosition(550, 200)

    self:addChild(monster)

-- Create the ForegroundLayer
    local foregroundLayer = self:createForegroundLayer()
    self:addChild(foregroundLayer)

-- Create the TouchLayer
-- local touchLayer = self:createTouchLayer()
-- self:addChild(touchLayer)

end

-- Create the Background Layer for this panel

function GameBattlePanel:createBackgroundLayer()
    --local backgroundLayer = cc.Layer:create()

    -- TODO change the single color to the final sprite in te res file
    -- local backgroundSprite = cc.Sprite:create("")
    local backgroundColor = cc.c4b(255, 255, 255, 180)
    --backgroundLayer:setColor(backgroundColor)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height

    return backgroundLayer
end   

-- Create the Foreground Layer for this panel
function GameBattlePanel:createForegroundLayer()
    --local foregroundLayer = cc.Layer:create()
    --local foregroundLayer = cc.Layer:create()
    local foregroundColor = cc.c4b(255, 255, 255, 0)
    local foregroundLayer = cc.LayerColor:create(foregroundColor)
    
    foregroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2) -- 20% of the screen's height
    
    -- add all the child node
    --local fontInfo = {"fonts/Marker Felt.ttf", 16}
    local titleLabel = cc.LabelTTF:create("This is a game title", "Arial", 70)
    --foregroundLayer:addChild(hpNode)   
    return 
end

return GameBattlePanel

