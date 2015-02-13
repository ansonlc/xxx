--------------------------------------------------------------------------------
-- GameSkillSlotPanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

require "logic.GameBattleLogic.lua"
require "config.CommonDefine.lua"

local GameSkillSlotPanel = class("GameSkillSlotPanel", function() return cc.Layer:create() end)
--local GameSkillSlotManagerLayer = class("GameSkillSlotManagerLayer", function() return cc.Layer:create() end)
local GameSkillSlotManagerLayer = class("GameSkillSlotManagerLayer", function() return cc.LayerColor:create(cc.c4b(255, 255, 255,0)) end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameSkillSlotManagerLayer:create()
    local layer = GameSkillSlotManagerLayer.new()
    layer:initLayer()
    return layer
end

function GameSkillSlotManagerLayer:initLayer()
    -- initialize the layer
    self:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)
    -- initialize the constant
    self.spriteSize = 64 * 3
    self.slotsLeftNumber = GMaxSkillsInSlot    
    self.skillSlotTable = {}
    -- 1. Create all the slots for the skills
    -- 2. Determine the size and position for each slot
    -- 3. Create all the skill nodes and attach them to the manager
    local skillSprite1 = self:generateSkillNode("res/imgs/temp/sword_1.png")
    skillSprite1:setPosition(220, 200) -- currently hardcoded position
    skillSprite1:setScale(3)
    local skillSprite2 = self:generateSkillNode("res/imgs/temp/magic_1.png")
    skillSprite2:setPosition(520, 200)
    skillSprite2:setScale(3)
    local skillSprite3 = self:generateSkillNode("res/imgs/temp/shield_1.png")
    skillSprite3:setPosition(820, 200)
    skillSprite3:setScale(3)
    
    self:insertSkillNode(1,skillSprite1)
    self:insertSkillNode(2,skillSprite2)
    self:insertSkillNode(3,skillSprite3)
end

-- TODO: should also pass in Skill info
function GameSkillSlotManagerLayer:generateSkillNode(path)
    assert(path, "Nil input in function: GameSkillSlotManagerLayer:generateSkillNode()")
    local skillSprite = cc.Sprite:create(path)
    return skillSprite
end

-- Insert a certain node into the layer and automatically 
-- adjust the position and size of it
-- TODO: Auto-adjustment
function GameSkillSlotManagerLayer:insertSkillNode(index, node)
    assert(index, "Nil input in function: GameSkillSlotManagerLayer:insertSkillNode()")
    assert(node, "Nil input in function: GameSkillSlotManagerLayer:insertSkillNode()")
    self.skillSlotTable[index] = node 
    self.slotsLeftNumber = self.slotsLeftNumber - 1
    self:addChild(node)
end

function GameSkillSlotPanel.create()
    local panel = GameSkillSlotPanel.new()
    panel:initPanel()
    return panel
end

function GameSkillSlotPanel:initPanel()
   
   -- Create the BackgroundLayer
   -- TODO: changed to sprite image
   local backgroundColor = cc.c4b(255, 255, 255, 180)
   local backgroundLayer = cc.LayerColor:create(backgroundColor)

   backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
   backgroundLayer:setName("BackgroundLayer")
   self:addChild(backgroundLayer)
   
   -- Create the TouchLayer
   local touchLayer = self:createTouchLayer()
   self:addChild(touchLayer)
   
   -- Add the GameSkillSlotMangaerNode (as a self member -> easy to access)
   self.skillSlotManagerLayer = GameSkillSlotManagerLayer:create()
   self.skillSlotManagerLayer:setName("SkillSlotManager")
   self:addChild(self.skillSlotManagerLayer)
end

-- Create the Touch Layer for this panel

function GameSkillSlotPanel:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)
    
    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)    -- 20% of the screen's height
   
    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
       --[[if x >= (220 - spriteSize.width / 2) and x<= (220 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2)then
            cclog("Attack Skill Used")
            local gameScene = self:getParent()         
            local battleLogic = gameScene:getChildByName("GameBattleLogic")
            assert(battleLogic, "Nil child")
            battleLogic:doDamage(25)
       elseif x >= (520 - spriteSize.width / 2) and x <= (520 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2) then
            cclog("Magic Skill Used")
            local gameScene = self:getParent()         
            local battleLogic = gameScene:getChildByName("GameBattleLogic")
            assert(battleLogic, "Nil child")
            local testRunesTable = {["Water"] = 1}
            battleLogic:updateRunesTable(testRunesTable)
       elseif x >= (820 - spriteSize.width / 2) and x <= (820 + spriteSize.width / 2) and y >= (200 - spriteSize.height / 2) and y <= (200 + spriteSize.height / 2) then
            cclog("Shield Skill Used")
       end--]]
       
    end
    -- Register the touch handler and enable touch
    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)
    
    return touchLayer
end

return GameSkillSlotPanel