--------------------------------------------------------------------------------
-- GameSkillSlotPanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

require "logic.GameBattleLogic.lua"
require "config.CommonDefine.lua"
require "manager.SkillManager.lua"

local parentNode

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
    self:changeWidthAndHeight(visibleSize.width, visibleSize.height * GSkillSlotPanelVerticalRatio)  
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
    
    -- wrapper for the class touch event handler
    local function onTouch(eventType, x, y)
        self:touchEventHandler(eventType, x, y)
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)
end

---
-- Initialize for the skills
-- @function [parent=#panel.GameSkillSlotPanel] initSkills
-- @param self 
-- @param skillTable table skills chosen by the player
function GameSkillSlotManagerLayer:initSkills(skillTable)    
    -- TODO: Delete the simulation for the skill table
    skillTable = {1001, 1002, 1004, 1006, 1008}
    local skillSprite1 = self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[1]..".png"), SkillManager.getSkill(skillTable[1]))
    local skillSprite2 = self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[2]..".png"), SkillManager.getSkill(skillTable[2]))
    local skillSprite3 = self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[3]..".png"), SkillManager.getSkill(skillTable[3]))
    local skillSprite4 = self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[4]..".png"), SkillManager.getSkill(skillTable[4]))
    local skillSprite5 = self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[5]..".png"), SkillManager.getSkill(skillTable[5]))
    
    self:insertSkillNode(1,skillSprite1)
    self:insertSkillNode(2,skillSprite2)
    self:insertSkillNode(3,skillSprite3)
    self:insertSkillNode(4,skillSprite4)
    self:insertSkillNode(5,skillSprite5)
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
                else
                    cclog("Not Enough Runes to use skill: "..self.skillSlotTable[i].skill.skillName)
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
        if self.skillSlotTable[i] ~= nil and self.skillSlotTable[i].skill ~= nil then
            local test = self.skillSlotTable[i].skill.runeCostTable
            if currentRunesTable.water >= self.skillSlotTable[i].skill.runeCostTable.water and currentRunesTable.air >= self.skillSlotTable[i].skill.runeCostTable.air and currentRunesTable.fire >= self.skillSlotTable[i].skill.runeCostTable.fire and currentRunesTable.earth >= self.skillSlotTable[i].skill.runeCostTable.earth then
                self.skillSlotTable[i].isActive = true 
                
                -- Cancel the Inactive layer
                if self.skillSlotTable[i].inActiveLayer ~= nil then
                    self:removeChild(self.skillSlotTable[i].inActiveLayer)
                    self.skillSlotTable[i].inActiveLayer = nil
                end
            else
                self.skillSlotTable[i].isActive = false
                -- Set the layer color to grey
                if self.skillSlotTable[i].inActiveLayer == nil then
                    local greyColor =cc.c4b(128, 128, 128, 200)
                    local greyLayer = cc.LayerColor:create(greyColor)

                    greyLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, self.skillSlotTable[i].scaledSize)
                    greyLayer:setAnchorPoint(0,0)
                    greyLayer:setPosition(self.skillSlotTable[i].x, self.skillSlotTable[i].y)

                    self.skillSlotTable[i].inActiveLayer = greyLayer
                    self:addChild(greyLayer)
                end
 
            end
        end
    end
end

function GameSkillSlotPanel.create(parent, skillTable)
    parentNode = parent
    local panel = GameSkillSlotPanel.new()
    panel:initPanel(skillTable)
    return panel
end

function GameSkillSlotPanel:initPanel(skillTable)
   
    -- Debug layer to show the panel size
    local debugColor = cc.c4b(128, 0, 0, 100)
    local debugLayer = cc.LayerColor:create(debugColor)
    
    debugLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * GSkillSlotPanelVerticalRatio)
    debugLayer:setAnchorPoint(0,0)
    debugLayer:setPosition(0,0)
    
    self:addChild(debugLayer)
    
    -- Create the BackgroundLayer
    -- TODO: changed to sprite image
    local backgroundColor = cc.c4b(255, 255, 255, 180)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width * GSkillSlotBGHorizontalRatio, visibleSize.height * GSkillSlotBGVerticalRatio)
    backgroundLayer:setAnchorPoint(0,0)
    backgroundLayer:setPosition(visibleSize.width * GSkillSlotBGHorizontalStartOffsetRatio,visibleSize.height * GSkillSlotBGVerticalStartOffsetRatio) 
    backgroundLayer:setName("BackgroundLayer")
    self:addChild(backgroundLayer)
    
    
   -- Add the GameSkillSlotMangaerNode (as a self member -> easy to access)
   self.skillSlotManagerLayer = GameSkillSlotManagerLayer:create()
   self.skillSlotManagerLayer:initSkills(skillTable)
   self.skillSlotManagerLayer:setName("SkillSlotManager")
   self:addChild(self.skillSlotManagerLayer)
   
   
end

return GameSkillSlotPanel