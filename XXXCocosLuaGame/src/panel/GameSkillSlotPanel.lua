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
    self:changeWidthAndHeight(visibleSize.width, visibleSize.height * GSkillSlotLayerVerticalRatio)  -- currently 20% of the whole screen space
    -- initialize the constant
    self.spriteSize = visibleSize.width * GSkillSlotIdelSizeRatio    -- should be dynamic;
    self.slotNumber = GSkillSLotStartIndex  -- indices of lua table start from 1
    self.skillSlotTable = {}
    self.layerHorizontalStartOffset = visibleSize.width * GSkillSlotHorizontalStartOffsetRatio
    self.layerHorizontalOffset = visibleSize.width * GSkillSlotHorizontalOffsetRatio
    self.layerVerticalStartOffset = visibleSize.height * GSkillSlotVerticalStartOffsetRatio
    -- 1. Create all the slots for the skills
    -- 2. Determine the size and position for each slot
    -- 3. Create all the skill nodes and attach them to the manager
    
    -- TODO: replace the skill below with the skill given by the manager
    local testSkill1 = {}
    testSkill1.name = "Strike"
    testSkill1.runeCostTable = {["Water"] = 1, ["Wind"] = 1, ["Fire"] = 1, ["Earth"] = 1}
    testSkill1.effectType = "Attack"
    testSkill1.effectValue = 25
    
    local skillSprite1 = self:generateSkillNode("res/imgs/temp/sword_1.png", testSkill1)
    local skillSprite2 = self:generateSkillNode("res/imgs/temp/magic_1.png", nil)
    local skillSprite3 = self:generateSkillNode("res/imgs/temp/shield_1.png", nil)
    
    self:insertSkillNode(1,skillSprite1)
    self:insertSkillNode(2,skillSprite2)
    self:insertSkillNode(3,skillSprite3)
    self:insertSkillNode(4,nil)
    self:insertSkillNode(5,nil)
    
    -- wrapper for the class touch event handler
    local function onTouch(eventType, x, y)
        self:touchEventHandler(eventType, x, y)
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)
end

-- Activate the skill slot given the x and y coord
-- nil if not available
function GameSkillSlotManagerLayer:touchEventHandler(eventType, x, y)
    if y > self:getContentSize().height then
        return
    end

    for i = 1, 5, 1 do
        if self.skillSlotTable[i] ~= nil then
            if x >= self.skillSlotTable[i].x and x <= (self.skillSlotTable[i].x + self.skillSlotTable[i].scaledSize) and y >= self.skillSlotTable[i].y and y <= (self.skillSlotTable[i].y + self.skillSlotTable[i].scaledSize) then
                -- TODO: the manager should check if the runes are enough to activate this skill
                -- and then activate the skill
                if self.skillSlotTable[i].isActive then
                    if self.gameLogicNode == nil then
                        self.gameLogicNode = self:getParent():getParent():getChildByName("GameBattleLogic")
                    end
                    assert(self.gameLogicNode, "Nil gameLogicNode in touchEventHandler")
                    self.gameLogicNode:playerUseSkill(self.skillSlotTable[i].skill)
                end
            end
        end
    end
end

function GameSkillSlotManagerLayer:generateSkillNode(path, skill)
    assert(path, "Nil input in function: GameSkillSlotManagerLayer:generateSkillNode()")
    local skillSprite = cc.Sprite:create(path)
    skillSprite.skill = skill
    return skillSprite
end

-- Insert a certain node into the layer and automatically 
-- adjust the position and size of it
function GameSkillSlotManagerLayer:insertSkillNode(index, node)
    assert(index, "Nil input in function: GameSkillSlotManagerLayer:insertSkillNode()")
    assert(index < 6, "Index out of bound in SkillSlotLayer")
    -- assert(node, "Nil input in function: GameSkillSlotManagerLayer:insertSkillNode()")
    if node == nil then
        -- this is an empty slot
        local nullSprite = cc.Sprite:create("res/imgs/temp/null_1.png") 
        local scale = GSkillSlotIdelSizeRatio * visibleSize.width / nullSprite:getContentSize().width
        local scaledSize = nullSprite:getContentSize().width * scale
        
        nullSprite:setAnchorPoint(0,0)
        nullSprite:setScale(scale)
        nullSprite:setPosition(self.layerHorizontalStartOffset + (index - 1) * (scaledSize + self.layerHorizontalOffset), self.layerVerticalStartOffset)

        self.skillSlotTable[index] = nil
        self:addChild(nullSprite)
    else
        -- 
        local scale = GSkillSlotIdelSizeRatio * visibleSize.width / node:getContentSize().width
        local scaledSize = node:getContentSize().width * scale
        
        node.isActive = false
        node.scaledSize = scaledSize
        node.x = self.layerHorizontalStartOffset + (index - 1) * (scaledSize + self.layerHorizontalOffset)
        node.y = self.layerVerticalStartOffset

        node:setAnchorPoint(0,0)
        node:setScale(scale)
        node:setPosition(node.x, node.y)

        self.skillSlotTable[index] = node 
        self:addChild(node)
    end
end

---
-- Update the current skill status given the current runes tabler
-- @function [parent=#panel.GameSkillSlotPanel] updateSkillStatus
-- @param self 
-- @param currentRunesTable table current runes table in the logic node
function GameSkillSlotManagerLayer:updateSkillStatus(currentRunesTable)
    for i = 1, GMaxSkillsInSlot, 1 do
        --if currentRunesTable["Water"] >= self.skillSlotTable[i].skill.runes
        if self.skillSlotTable[i] ~= nil and self.skillSlotTable[i].skill ~= nil then
            if currentRunesTable["Water"] >= self.skillSlotTable[i].skill.runeCostTable["Water"] and currentRunesTable["Wind"] >= self.skillSlotTable[i].skill.runeCostTable["Wind"] and currentRunesTable["Fire"] >= self.skillSlotTable[i].skill.runeCostTable["Fire"] and currentRunesTable["Earth"] >= self.skillSlotTable[i].skill.runeCostTable["Earth"] then
                self.skillSlotTable[i].isActive = true 
            else
                self.skillSlotTable[i].isActive = false
            end
            cclog("Update the status for: "..self.skillSlotTable[i].skill.name..":"..tostring(self.skillSlotTable[i].isActive))
        end
    end
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

   backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * GSkillSlotLayerVerticalRatio) 
   backgroundLayer:setName("BackgroundLayer")
   self:addChild(backgroundLayer)
   
   -- Add the GameSkillSlotMangaerNode (as a self member -> easy to access)
   self.skillSlotManagerLayer = GameSkillSlotManagerLayer:create()
   self.skillSlotManagerLayer:setName("SkillSlotManager")
   self:addChild(self.skillSlotManagerLayer)
   
end

return GameSkillSlotPanel