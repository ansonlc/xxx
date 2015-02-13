--------------------------------------------------------------------------------
-- GameSkillSlotPanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

require "logic.GameBattleLogic.lua"

local GameSkillSlotPanel = class("GameSkillSlotPanel", function() return cc.Layer:create() end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()

local spriteSize

function GameSkillSlotPanel.create()
    local panel = GameSkillSlotPanel.new()
    panel:initPanel()
    return panel
end

function GameSkillSlotPanel:initPanel()
   
   -- Create the BackgroundLayer
   local backgroundLayer = self:createBackgroundLayer()
   self:addChild(backgroundLayer)
   
   -- Create the ForegroundLayer
   local foregroundLayer = self:createForegroundLayer()
   self:addChild(foregroundLayer)
   
   -- Create the TouchLayer
   local touchLayer = self:createTouchLayer()
   self:addChild(touchLayer)
   
end

-- Create the Background Layer for this panel

function GameSkillSlotPanel:createBackgroundLayer()
    --local backgroundLayer = cc.Layer:create()
    
    -- TODO change the single color to the final sprite in te res file
    -- local backgroundSprite = cc.Sprite:create("")
    local backgroundColor = cc.c4b(255, 255, 255, 180)
    --backgroundLayer:setColor(backgroundColor)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)
    
    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
    
    return backgroundLayer
end

-- Creat the Foreground Layer for this panel
function GameSkillSlotPanel:createForegroundLayer()
    -- TODO implmementation
    local foregroundColor = cc.c4b(255, 255, 255, 0)
    local foregroundLayer = cc.LayerColor:create(foregroundColor)
    
    foregroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)
    
    -- here we have to insert all the sprite node here
    -- test code for inserting the sprite
    local skillSprite1 = cc.Sprite:create("res/imgs/temp/sword_1.png")
    skillSprite1:setPosition(220, 200) -- currently hardcoded position
    skillSprite1:setScale(3)
    
    local skillSprite2 = cc.Sprite:create("res/imgs/temp/magic_1.png")
    skillSprite2:setPosition(520, 200)
    skillSprite2:setScale(3)
    
    local skillSprite3 = cc.Sprite:create("res/imgs/temp/shield_1.png")
    skillSprite3:setPosition(820, 200)
    skillSprite3:setScale(3)
    
    -- get the size of the sprite
    spriteSize = skillSprite1:getContentSize()
    
    foregroundLayer:addChild(skillSprite1)
    foregroundLayer:addChild(skillSprite2)
    foregroundLayer:addChild(skillSprite3)
    -- test code finished here
    
    return foregroundLayer
end

-- Create the Touch Layer for this panel

function GameSkillSlotPanel:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)
    
    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)    -- 20% of the screen's height
   
    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
       if x >= (220 - spriteSize.width / 2) and x<= (220 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2)then
            cclog("Attack Skill Used")
            local gameScene = self:getParent()         
            local battleLogic = gameScene:getChildByName("GameBattleLogic")
            assert(battleLogic, "Nil child")
            local testRunesTable = {["Water"] = 1}
            battleLogic:updateRunesTable(testRunesTable)
            
       elseif x >= (520 - spriteSize.width / 2) and x <= (520 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2) then
            cclog("Magic Skill Used")
       elseif x >= (820 - spriteSize.width / 2) and x <= (820 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2) then
            cclog("Shield Skill Used")
       end
       
    end
    -- Register the touch handler and enable touch
    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)
    
    return touchLayer
end

return GameSkillSlotPanel