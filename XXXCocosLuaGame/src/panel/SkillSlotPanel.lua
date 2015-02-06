--------------------------------------------------------------------------------
-- SkillSlotPanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

require "core.BaseScene"

local SkillSlotPanel = class("SkillSlotPanel", function() return cc.Layer:create() end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()

function SkillSlotPanel.create()
    local panel = SkillSlotPanel.new()
    panel:initPanel()
    return panel
end

function SkillSlotPanel:initPanel()
   
   -- Create the BackgroundLaye r
   local backgroundLayer = self:createBackgroundLayer()
   self:addChild(backgroundLayer)
   
   -- Create the ForegroundLayer
   -- local foregroundLayer = self:createForegroundLayer()
   -- self:addChild(foregroundLayer)
   
   -- Create the TouchLayer
   local touchLayer = self:createTouchLayer()
   self:addChild(touchLayer)
   
end

-- Create the Background Layer for this panel

function SkillSlotPanel:createBackgroundLayer()
    --local backgroundLayer = cc.Layer:create()
    
    -- TODO change the single color to the final sprite in te res file
    -- local backgroundSprite = cc.Sprite:create("")
    local backgroundColor = cc.c4b(255, 255, 255, 255)
    --backgroundLayer:setColor(backgroundColor)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)
    
    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
    
    return backgroundLayer
end

-- Creat the Foreground Layer for this panel
function SkillSlotPanel:createForegroundLayer()
    -- TODO implmementation
end

-- Create the Touch Layer for this panel

function SkillSlotPanel:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)
    
    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)    -- 20% of the screen's height
   
    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
    end
    -- Register the touch handler and enable touch
    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)
    
    return touchLayer
end

return SkillSlotPanel