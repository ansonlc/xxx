--------------------------------------------------------------------------------
-- GameSkillSlotPanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

require "logic.GameBattleLogic.lua"
require "config.CommonDefine.lua"
require "manager.DataManager.lua"

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
    self.spriteSize = visibleSize.width * GSkillSlotIdleSizeRatio    -- should be dynamic;
    self.slotNumber = GSkillSLotStartIndex  -- indices of lua table start from 1
    self.skillSlotTable = {}
    self.layerHorizontalStartOffset = visibleSize.width * GSkillSlotHorizontalStartOffsetRatio
    self.layerHorizontalOffset = visibleSize.width * GSkillSlotHorizontalOffsetRatio
    self.layerVerticalStartOffset = visibleSize.height * GSkillSlotVerticalStartOffsetRatio
    -- 1. Create all the slots for the skills
    -- 2. Determine the size and position for each slot
    -- 3. Create all the skill nodes and attach them to the manager
    
    -- CD Counter for the slots
    self.isSilenced = false
    self.isCoolingDown = false
    self.coolDownTimer = 0
    
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
    skillTable = DataManager.userInfo.currentSkills
    --skillTable = {1005, 1800, 1300, 2000, 2100}
    
    local skillSprite1 = GameIconManager.getSkillSprite(skillTable[1], nil , true)
        --self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[1]..".png"), MetaManager.getSkill(skillTable[1]))
    local skillSprite2 = GameIconManager.getSkillSprite(skillTable[2], nil , true)
        --self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[2]..".png"), MetaManager.getSkill(skillTable[2]))
    local skillSprite3 = GameIconManager.getSkillSprite(skillTable[3], nil , true)
        --self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[3]..".png"), MetaManager.getSkill(skillTable[3]))
    local skillSprite4 = GameIconManager.getSkillSprite(skillTable[4], nil , true)
        --self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[4]..".png"), MetaManager.getSkill(skillTable[4]))
    local skillSprite5 = GameIconManager.getSkillSprite(skillTable[5], nil , true)
        --self:generateSkillNode("res/imgs/temp/skill_"..tostring(skillTable[5]..".png"), MetaManager.getSkill(skillTable[5]))
    
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
                if self.skillSlotTable[i].isActive and not self.skillSlotTable[i].isCoolingDown and not self.isSilenced then
                    if self.gameLogicNode == nil then
                        self.gameLogicNode = self:getParent():getParent():getChildByName("GameBattleLogic")
                    end
                    assert(self.gameLogicNode, "Nil gameLogicNode in touchEventHandler")
                    self.gameLogicNode:playerUseSkill(self.skillSlotTable[i].skill)
                    -- CD this skill
                    self.skillSlotTable[i].isCoolingDown = true   
                           
                    self.skillSlotTable[i].CDLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, self.skillSlotTable[i].scaledSize) 
                    break        
                end
            end
        end
    end
    --[[for i = 1, 5, 1 do
        if self.skillSlotTable[i] ~= nil then
            if x >= self.skillSlotTable[i].x and x <= (self.skillSlotTable[i].x + self.skillSlotTable[i].scaledSize) and y >= self.skillSlotTable[i].y and y <= (self.skillSlotTable[i].y + self.skillSlotTable[i].scaledSize) then
                if self.skillSlotTable[i].isActive and not self.isCoolingDown  and not self.isSilenced then
                    if self.gameLogicNode == nil then
                        self.gameLogicNode = self:getParent():getParent():getChildByName("GameBattleLogic")
                    end
                    assert(self.gameLogicNode, "Nil gameLogicNode in touchEventHandler")
                    self.gameLogicNode:playerUseSkill(self.skillSlotTable[i].skill)
                    -- CD this skill
                    self.isCoolingDown = true     
                    for i = 1, 5, 1 do
                        self.skillSlotTable[i].CDLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, self.skillSlotTable[i].scaledSize)         
                    end                             
                    break
                end
            end
        end
    end--]]
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
        local scale = GSkillSlotIdleSizeRatio * visibleSize.width / nullSprite:getContentSize().width
        local scaledSize = nullSprite:getContentSize().width * scale
        
        nullSprite:setAnchorPoint(0,0)
        nullSprite:setScale(scale)
        nullSprite:setPosition(self.layerHorizontalStartOffset + (index - 1) * (scaledSize + self.layerHorizontalOffset), self.layerVerticalStartOffset)

        self.skillSlotTable[index] = nil
        self:addChild(nullSprite)
    else
        local scale = GSkillSlotIdleSizeRatio * visibleSize.width / node:getContentSize().width
        local scaledSize = node:getContentSize().width * scale
        
        local a1 = node:getContentSize().width
        -- Initialize for the skills
        node.isActive = false
        --node.isCoolingDown = false
        node.CDCounting = 0
        node.CD = node.skill.CD
        node.scaledSize = scaledSize
        node.x = self.layerHorizontalStartOffset + (index - 1) * (scaledSize + self.layerHorizontalOffset)
        node.y = self.layerVerticalStartOffset
        
        -- set the node
        node:setAnchorPoint(0,0)
        node:setScale(scale)
        node:setPosition(node.x, node.y)
   
        self.skillSlotTable[index] = node 
        self:addChild(node)
        
        -- Add the inActiveLayer
        local inActiveColor = cc.c4b(0, 0, 128, 100)
        local inActiveLayer = cc.LayerColor:create(inActiveColor)

        inActiveLayer:setAnchorPoint(0,0)
        inActiveLayer:setPosition(node.x, node.y)

        node.inActiveLayer = inActiveLayer
        self:addChild(inActiveLayer)
        
        -- Add the CD Layer
        local CDColor = cc.c4b(128, 128, 128, 150)
        local CDLayer = cc.LayerColor:create(CDColor)

        CDLayer:setAnchorPoint(0,0)
        CDLayer:setPosition(node.x, node.y)
        CDLayer:changeWidthAndHeight(0,0)

        node.CDLayer = CDLayer
        self:addChild(CDLayer)
       
        -- Add the lock Layer
        local LockColor = cc.c4b(200, 0, 0, 100)
        local LockLayer = cc.LayerColor:create(LockColor)
        
        LockLayer:setAnchorPoint(0,0)
        LockLayer:setPosition(node.x, node.y)
        LockLayer:changeWidthAndHeight(0,0)
        
        node.LockLayer = LockLayer
        self:addChild(LockLayer)
        
        -- Add the rune requirement block here
        node.runeSprite = {}
        local runeSpriteSize = visibleSize.width * GSkillSlotRuneIdleSizeRatio
        local runeSpriteGap = visibleSize.width * GSkillSlotRuneIdleGapRatio
        -- Air
        local airRuneSprite = cc.Sprite:create("res/imgs/GameScene/tile_air.png")
        local size = airRuneSprite:getContentSize().width
        airRuneSprite:setAnchorPoint(0,0)
        airRuneSprite:setScale(runeSpriteSize / airRuneSprite:getContentSize().width)
        airRuneSprite:setPosition(node.x + runeSpriteGap, node.y)
        --airRuneSprite:setPosition(0, 0)
        airRuneSprite:setVisible(false)
        node.runeSprite["Air"] = airRuneSprite
        self:addChild(airRuneSprite)
        -- Earth
        local earthRuneSprite = cc.Sprite:create("res/imgs/GameScene/tile_earth.png")
        earthRuneSprite:setAnchorPoint(0,0)
        earthRuneSprite:setScale(runeSpriteSize / earthRuneSprite:getContentSize().width)
        earthRuneSprite:setPosition(node.x + 2 * runeSpriteGap + runeSpriteSize, node.y)
        --earthRuneSprite:setPosition(40, 0)
        earthRuneSprite:setVisible(false)
        node.runeSprite["Earth"] = earthRuneSprite
        self:addChild(earthRuneSprite)
        -- Water
        local waterRuneSprite = cc.Sprite:create("res/imgs/GameScene/tile_water.png")
        waterRuneSprite:setAnchorPoint(0,0)
        waterRuneSprite:setScale(runeSpriteSize / waterRuneSprite:getContentSize().width)
        waterRuneSprite:setPosition(node.x + 3 * runeSpriteGap + 2 * runeSpriteSize, node.y)
        --waterRuneSprite:setPosition(80, 0)
        waterRuneSprite:setVisible(false)
        node.runeSprite["Water"] = waterRuneSprite
        self:addChild(waterRuneSprite)
        -- Fire
        local fireRuneSprite = cc.Sprite:create("res/imgs/GameScene/tile_fire.png")
        fireRuneSprite:setAnchorPoint(0,0)
        fireRuneSprite:setScale(runeSpriteSize / fireRuneSprite:getContentSize().width)
        fireRuneSprite:setPosition(node.x + 4 * runeSpriteGap + 3 * runeSpriteSize, node.y)
        --fireRuneSprite:setPosition(120, 0)
        fireRuneSprite:setVisible(false)
        node.runeSprite["Fire"] = fireRuneSprite
        self:addChild(fireRuneSprite)
        
        --[[local debugRuneLayer = cc.LayerColor:create(cc.c4b(100,100,100,100))
        
        debugRuneLayer:changeWidthAndHeight(scaledSize,scaledSize)
        debugRuneLayer:setAnchorPoint(0,0)
        debugRuneLayer:setPosition(node.x,node.y)
        
        self:addChild(debugRuneLayer)--]]
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
            -- judge if the skill is active
            if currentRunesTable.water >= self.skillSlotTable[i].skill.runeCostTable.water and currentRunesTable.air >= self.skillSlotTable[i].skill.runeCostTable.air and currentRunesTable.fire >= self.skillSlotTable[i].skill.runeCostTable.fire and currentRunesTable.earth >= self.skillSlotTable[i].skill.runeCostTable.earth then
                self.skillSlotTable[i].isActive = true 
                
                -- Cancel the Inactive layer
                self.skillSlotTable[i].inActiveLayer:changeWidthAndHeight(0, 0) -- make it invisible
                
                -- Cancel all the rune sprite
                for k,v in pairs(self.skillSlotTable[i].runeSprite) do
                    v:setVisible(false)
                end
            else
                self.skillSlotTable[i].isActive = false      
                         
                self.skillSlotTable[i].inActiveLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, self.skillSlotTable[i].scaledSize)
                
                local isAirRuneRequired = (currentRunesTable.air < self.skillSlotTable[i].skill.runeCostTable.air)
                local isEarthRuneRequired = (currentRunesTable.earth < self.skillSlotTable[i].skill.runeCostTable.earth)
                local isWaterRuneRequired = (currentRunesTable.water < self.skillSlotTable[i].skill.runeCostTable.water)
                local isFireRuneRequired = (currentRunesTable.fire < self.skillSlotTable[i].skill.runeCostTable.fire)
                
                if isAirRuneRequired then
                    self.skillSlotTable[i].runeSprite["Air"]:setVisible(true)
                else
                    self.skillSlotTable[i].runeSprite["Air"]:setVisible(false)
                end
                
                if isEarthRuneRequired then
                    self.skillSlotTable[i].runeSprite["Earth"]:setVisible(true)
                else 
                    self.skillSlotTable[i].runeSprite["Earth"]:setVisible(false)
                end
                
                if isWaterRuneRequired then
                    self.skillSlotTable[i].runeSprite["Water"]:setVisible(true)
                else
                    self.skillSlotTable[i].runeSprite["Water"]:setVisible(false)
                end
                
                if isFireRuneRequired then
                    self.skillSlotTable[i].runeSprite["Fire"]:setVisible(true)
                else
                    self.skillSlotTable[i].runeSprite["Fire"]:setVisible(false)
                end
            end
        end
    end
end

---
--  Disable the skill slots
--  @function [parent=#panel.GameSkillSlotPanel] disableSkillSlots
function GameSkillSlotManagerLayer:disableSkillSlots()
    self.isSilenced = true
    for i = 1, GMaxSkillsInSlot, 1 do
        if self.skillSlotTable[i] ~= nil then
            self.skillSlotTable[i].LockLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, self.skillSlotTable[i].scaledSize)
        end
    end
end

---
--  Enable the skill slots
--  @function [parent=#panel.GameSkillSlotPanel] enableSkillSlots
function GameSkillSlotManagerLayer:enableSkillSlots()
    self.isSilenced = false
    for i = 1, GMaxSkillsInSlot, 1 do
        if self.skillSlotTable[i] ~= nil then
            self.skillSlotTable[i].LockLayer:changeWidthAndHeight(0, 0)
        end
    end
end

function GameSkillSlotManagerLayer:onUpdate(dt)
    for i = 1, 5, 1 do
        if self.skillSlotTable[i].isCoolingDown then
            self.skillSlotTable[i].CDCounting = self.skillSlotTable[i].CDCounting + dt
            if self.skillSlotTable[i].CDCounting >= self.skillSlotTable[i].CD then
                -- disable the covering layer and set the skill to idle status
                self.skillSlotTable[i].isCoolingDown = false
                self.skillSlotTable[i].CDCounting = 0
                self.skillSlotTable[i].CDLayer:changeWidthAndHeight(0, 0)
            else
                -- refresh the covering layer
                self.skillSlotTable[i].CDLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, (self.skillSlotTable[i].CD - self.skillSlotTable[i].CDCounting) * self.skillSlotTable[i].scaledSize / self.skillSlotTable[i].CD)
            end
        end
    end
    --[[if self.isCoolingDown then
        self.coolDownTimer = self.coolDownTimer + dt
        if self.coolDownTimer >= GSkillPublicCD then
            self.isCoolingDown = false
            self.coolDownTimer = 0
            for i = 1, 5, 1 do
                self.skillSlotTable[i].CDLayer:changeWidthAndHeight(0, 0) 
            end
        else
            for i = 1, 5, 1 do
                self.skillSlotTable[i].CDLayer:changeWidthAndHeight(self.skillSlotTable[i].scaledSize, (GSkillPublicCD - self.coolDownTimer) * self.skillSlotTable[i].scaledSize / GSkillPublicCD)
            end
        end
    end--]]
end

function GameSkillSlotPanel.create(parent, skillTable)
    parentNode = parent
    local panel = GameSkillSlotPanel.new()
    panel:initPanel(skillTable)
    return panel
end

function GameSkillSlotPanel:initPanel(skillTable)
   
    -- Debug layer to show the panel size
    local debugColor = cc.c4b(128, 0, 0, 0)
    local debugLayer = cc.LayerColor:create(debugColor)
    
    debugLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * GSkillSlotPanelVerticalRatio)
    debugLayer:setAnchorPoint(0,0)
    debugLayer:setPosition(0,0)
    
    self:addChild(debugLayer)
    
    -- Create the BackgroundLayer
    -- TODO: changed to sprite image
    --[[local backgroundColor = cc.c4b(255, 255, 255, 180)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width * GSkillSlotBGHorizontalRatio, visibleSize.height * GSkillSlotBGVerticalRatio)
    backgroundLayer:setAnchorPoint(0,0)
    backgroundLayer:setPosition(visibleSize.width * GSkillSlotBGHorizontalStartOffsetRatio,visibleSize.height * GSkillSlotBGVerticalStartOffsetRatio) 
    backgroundLayer:setName("BackgroundLayer")--]]
    local backgroundSprite = cc.Sprite:create("res/imgs/GameScene/skillslot_panel.png")
    
    backgroundSprite:setScale(visibleSize.width * GSkillSlotBGHorizontalRatio / backgroundSprite:getContentSize().width, visibleSize.height * GSkillSlotBGVerticalRatio / backgroundSprite:getContentSize().height)
    backgroundSprite:setAnchorPoint(0,0)
    backgroundSprite:setPosition(visibleSize.width * GSkillSlotBGHorizontalStartOffsetRatio,visibleSize.height * GSkillSlotBGVerticalStartOffsetRatio) 
    
    self:addChild(backgroundSprite)
    
    
   -- Add the GameSkillSlotMangaerNode (as a self member -> easy to access)
   self.skillSlotManagerLayer = GameSkillSlotManagerLayer:create()
   self.skillSlotManagerLayer:initSkills(skillTable)
   self.skillSlotManagerLayer:setName("SkillSlotManager")
   self:addChild(self.skillSlotManagerLayer)
end

function GameSkillSlotPanel:onUpdate(dt)
    assert(self.skillSlotManagerLayer, "Nil SkillSlotManagerLayer in GameSkillSlotPanel")
    self.skillSlotManagerLayer:onUpdate(dt)
end

return GameSkillSlotPanel