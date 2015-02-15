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
    self.spriteSize = visibleSize.width * GSkillSlotIdelSizeRatio    -- should be dynamic; currently hard coded
    self.slotNumber = GSkillSLotStartIndex  -- indices of lua table start from 1
    self.skillSlotTable = {}
    self.layerHorizontalStartOffset = visibleSize.width * GSkillSlotHorizontalStartOffsetRatio
    self.layerHorizontalOffset = visibleSize.width * GSkillSlotHorizontalOffsetRatio
    self.layerVerticalStartOffset = visibleSize.height * GSkillSlotVerticalStartOffsetRatio
    -- 1. Create all the slots for the skills
    -- 2. Determine the size and position for each slot
    -- 3. Create all the skill nodes and attach them to the manager
    local skillSprite1 = self:generateSkillNode("res/imgs/temp/sword_1.png")
    local skillSprite2 = self:generateSkillNode("res/imgs/temp/magic_1.png")
    local skillSprite3 = self:generateSkillNode("res/imgs/temp/shield_1.png")
    
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
                cclog("Skill: "..i.." activated")
                -- TODO: the manager should check if the runes are enough to activate this skill
                -- and then activate the skill
            end
        end
    end
end

-- TODO: should also pass in Skill info
function GameSkillSlotManagerLayer:generateSkillNode(path)
    assert(path, "Nil input in function: GameSkillSlotManagerLayer:generateSkillNode()")
    local skillSprite = cc.Sprite:create(path)
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