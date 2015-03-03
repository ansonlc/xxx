--------------------------------------------------------------------------------
-- GameBattlePanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

local parentNode

local GameBattlePanel = class("GameBattlePanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

---
-- Create the instance for the GameBattelPanel 
-- and set the position of this panel
-- @function [parent=#panel.GameBattlePanel] create
function GameBattlePanel.create(parent)
    parentNode = parent
    local panel = GameBattlePanel.new()
    -- initialize the panel
    panel:initPanel()
    return panel
end

---
--  Initilization of the GameBattelPanel
--@function [parent=#panel.GameBattlePanel] initPanel

function GameBattlePanel:initPanel()
    -- initialization of the panel position
    self:setAnchorPoint(0,0)
    self:setPosition(0, visibleSize.height * GBattlePanelVerticalStartOffsetRatio)

    -- Debug layer
    local debugColor = cc.c4b(255, 255, 255, 100)
    local debugLayer = cc.LayerColor:create(debugColor)
    
    debugLayer:changeWidthAndHeight(visibleSize.width,visibleSize.height * GBattlePanelVerticalRatio)
    debugLayer:setAnchorPoint(0,0)
    debugLayer:setPosition(0,0)
    
    self:addChild(debugLayer)

    -- Create the BackgroundLayer
    -- TODO change the single color to the final sprite in te res file
    local backgroundColor = cc.c4b(255, 255, 255, 255)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
    --self:addChild(backgroundLayer)
    
    -- HP Bar
    local hpBarSprite = cc.Sprite:create("res/imgs/temp/hpbar_1.png")
    hpBarSprite:setAnchorPoint(0,0)
    hpBarSprite:setPosition(visibleSize.width * GBattleHPBarHorizontalStartOffsetRatio, visibleSize.height * GBattleHPBarVerticalStartOffsetRatio)
    hpBarSprite:setScaleX(visibleSize.width * GBattleHPBarHorizontalRatio / hpBarSprite:getContentSize().width)
    hpBarSprite:setScaleY(visibleSize.height * GBattleHPBarVerticalRatio / hpBarSprite:getContentSize().height)
    
    self.hpBarSprite = hpBarSprite
    self:addChild(self.hpBarSprite)
    
    -- Battle Field
    local battleFieldColor = cc.c4b(0, 0, 255, 80)
    local battleFieldLayer = cc.LayerColor:create(battleFieldColor)
    
    battleFieldLayer:changeWidthAndHeight(visibleSize.width * GBattleFieldHorizontalRatio, visibleSize.height * GBattleFieldVerticalRatio)
    battleFieldLayer:setAnchorPoint(0,0)
    battleFieldLayer:setPosition(visibleSize.width * GBattleFieldHorizontalStartOffsetRatio,visibleSize.height * GBattleFieldVerticalStartOffsetRatio)
        
    self:addChild(battleFieldLayer)
    
    -- Rune Block
    local runeBlockColor = cc.c4b(100, 100, 0, 100)
    local runeBlockLayer = cc.LayerColor:create(runeBlockColor)
    
    runeBlockLayer:changeWidthAndHeight(visibleSize.width * GBattleRuneBlockHorizontalRatio, visibleSize.height * GBattleRuneBlockVerticalRatio)
    runeBlockLayer:setAnchorPoint(0,0)
    runeBlockLayer:setPosition(visibleSize.width * GBattleRuneBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleRuneBlockVerticalStartOffsetRatio)
    
    self.runeBlock = runeBlockLayer
    self:addChild(runeBlockLayer)
    
    -- Level Block
    local levelSprite = cc.Sprite:create("imgs/temp/leveltitle_1.png")
    levelSprite:setScaleX(visibleSize.width * GBattleLevelBlockHorizontalRatio / levelSprite:getContentSize().width)
    levelSprite:setScaleY(visibleSize.height * GBattleLevelBlockVerticalRatio / levelSprite:getContentSize().height)
    levelSprite:setAnchorPoint(0,0)
    levelSprite:setPosition(visibleSize.width * GBattleLevelBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleLevelBlockVerticalStartOffsetRatio)
    
    self:addChild(levelSprite)
    
    -- Option Block
    local optionSprite = cc.Sprite:create("imgs/temp/pause_button.png")
    
    -- used for the touch event test
    -- TODO: Find a better way for this purpose
    optionSprite.onScreenWidth = visibleSize.width * GBattleOptionBlockHorizontalRatio
    optionSprite.onScreenHeight = visibleSize.height * GBattleOptionBlockVerticalRatio
    optionSprite.onScreenX = visibleSize.width * GBattleOptionBlockHorizontalStartOffset
    optionSprite.onScreenY = visibleSize.height * GBattleOptionBlockVerticalStartOffset
    
    optionSprite:setScaleX(optionSprite.onScreenWidth / optionSprite:getContentSize().width)
    optionSprite:setScaleY(optionSprite.onScreenHeight / optionSprite:getContentSize().height)
    optionSprite:setAnchorPoint(0,0)
    optionSprite:setPosition(optionSprite.onScreenX, optionSprite.onScreenY)
    
    self.optionButton = optionSprite
    self:addChild(optionSprite)
    
    -- Monster Block
    local monsterBlockColor = cc.c4b(100, 100, 0, 100)
    local monsterBlockLayer = cc.LayerColor:create(monsterBlockColor)

    monsterBlockLayer:changeWidthAndHeight(visibleSize.width * GBattleMonsterBlockHorizontalRatio, visibleSize.height * GBattleMonsterBlockVerticalRatio)
    monsterBlockLayer:setAnchorPoint(0,0)
    monsterBlockLayer:setPosition(visibleSize.width * GBattleMonsterBlockHorizontalStartOffsetRatio,visibleSize.height * GBattleMonsterBlockVerticalStartOffsetRatio)

    self:addChild(monsterBlockLayer)
    
    -- Initialization for the Rune Block
    self:initRuneBlock()
    
    -- TODO: Delete the test monster in this panel
    local monster = cc.Sprite:create("res/imgs/monster/Pikachu.png")
    monster:setPosition(550, 200)
    monster:setName("MonsterNode")
    self:addChild(monster)

    -- test for the scene change
    local function onTouch(eventType, x, y)
        if x >= self.optionButton.onScreenX and x <= (self.optionButton.onScreenX + self.optionButton.onScreenWidth) and y >= (self.optionButton.onScreenY + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) and y <= (self.optionButton.onScreenY + self.optionButton.onScreenHeight + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) then
            SceneManager.replaceSceneWithName("LevelSelectScene","Test")
        end
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)

end

---
-- Initialization for the rune block (Create the icon and text for this block)
-- @function [parent=#panel.GameBattlePanel] initRuneBlock
function GameBattlePanel:initRuneBlock()
    -- Rune Icons
    -- Current all the Runes Sprites are the children of the RuneBlock in this panel
    -- Fire Rune
    local fireRuneSprite = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("icon11.png"))
    fireRuneSprite:setAnchorPoint(0,0)
    fireRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    fireRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneFireVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(fireRuneSprite)

    -- Water Rune
    local waterRuneSprite = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("icon15.png"))
    waterRuneSprite:setAnchorPoint(0,0)
    waterRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    waterRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneWaterVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(waterRuneSprite)

    -- Earth Rune
    local earthRuneSprite = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("icon12.png"))
    earthRuneSprite:setAnchorPoint(0,0)
    earthRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    earthRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneEarthVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(earthRuneSprite)

    -- Air Rune
    local airRuneSprite = cc.Sprite:createWithSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame("icon17.png"))
    airRuneSprite:setAnchorPoint(0,0)
    airRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    airRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneAirVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(airRuneSprite)
    
    -- Rune Text
    -- Fire Rune Text
    local fireRuneText = cc.LabelTTF:create("10", "Arial", 100)
    fireRuneText:setAnchorPoint(0,0)
    fireRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / fireRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / fireRuneText:getContentSize().height)
    fireRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneFireTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.fireRune = fireRuneText
    self.runeBlock:addChild(fireRuneText)
    
    -- Water Rune Text
    local waterRuneText = cc.LabelTTF:create("10", "Arial", 100)
    waterRuneText:setAnchorPoint(0,0)
    waterRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / waterRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / waterRuneText:getContentSize().height)
    waterRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneWaterTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.waterRune = waterRuneText
    self.runeBlock:addChild(waterRuneText)
    
    -- Earth Rune Text
    local earthRuneText = cc.LabelTTF:create("10", "Arial", 100)
    earthRuneText:setAnchorPoint(0,0)
    earthRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / earthRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / earthRuneText:getContentSize().height)
    earthRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneEarthTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.earthRune = earthRuneText
    self.runeBlock:addChild(earthRuneText)
    
    -- Air Rune Text
    local airRuneText = cc.LabelTTF:create("10", "Arial", 100)
    airRuneText:setAnchorPoint(0,0)
    airRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / airRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / airRuneText:getContentSize().height)
    airRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneAirTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.airRune = airRuneText
    self.runeBlock:addChild(airRuneText)
    
end

---
-- Update the rune number according to the current runes table
-- @function [parent=#panel.GameBattlePanel] updateRuneNum
-- @param runesTable table runes table passed from the logic node
function GameBattlePanel:updateRuneNum(runesTable)
    assert(runesTable, "Nil input in the function: GameBattlePanel:updateRuneNum")
    self.runeBlock.airRune:setString(runesTable.air)
    self.runeBlock.earthRune:setString(runesTable.earth)
    self.runeBlock.waterRune:setString(runesTable.water)
    self.runeBlock.fireRune:setString(runesTable.fire)
end

---
-- Show the damage info for the monster
-- @function [parent=#panel.GameBattlePanel] doDamageToMonster
-- @param damageValue The damage hit on the monster
function GameBattlePanel:doDamageToMonster(damageValue)
    assert(damageValue, "Nil input in function: GameBattlePanel:doDamageToMonster()")
    if self.damageText == nil then
        if damageValue >= 0 then
            self.damageText = cc.LabelTTF:create("-"..damageValue, "Arial", 200)
        else
            self.damageText = cc.LabelTTF:create("+"..math.abs(damageValue), "Arial", 200)
        end
        self.damageText:setName("DamageTextNode") 
        self:addChild(self.damageText)
    else
        if damageValue >= 0 then
            self.damageText:setString("-"..damageValue)
        else
            self.damageText:setString("+"..math.abs(damageValue))
        end
    end
    local fadeInAction = cc.FadeIn:create(0.3)
    local fadeOutAction = cc.FadeOut:create(0.3)
    local actionSeqTable = {fadeInAction, fadeOutAction}
    local actionSeq = cc.Sequence:create(actionSeqTable)
    self.damageText:setAnchorPoint(0,0)
    self.damageText:setPosition(400, 150)
    self.damageText:runAction(actionSeq)
end

---
--  Show the damage info for the player
--  @function [parent=#panel.GameBattlePanel] doDamageToPlayer
--  @param self
--  @param currentPlayerHP num current player HP
--  @param playerMaxHP num player's max HP
--  @param damage num damage caused by the monster
function GameBattlePanel:doDamageToPlayer(currentPlayerHP, playerMaxHP, damage)
    local scaleRatio =  ((currentPlayerHP / playerMaxHP) / ((currentPlayerHP + damage) / playerMaxHP))
    local scaleAction = cc.ScaleBy:create(0.5,scaleRatio,1)   
    self.hpBarSprite:runAction(scaleAction) 
end

--[[function GameBattlePanel:onUpdate(delta)
    local gameLogicNode = parentNode:getChildByName("GameBattleLogic")
    local x = math.max(0, gameLogicNode.monsterHP) / gameLogicNode.monsterMaxHP  
    self.hpBarSprite:setScaleX(x * visibleSize.width * GBattleHPBarHorizontalRatio / self.hpBarSprite:getContentSize().width)
end--]]


---
-- Change the sprite for the monster when the monster is dead
-- @function [parent=#panel.GameBattlePanel] monsterIsDefeated
function GameBattlePanel:monsterIsDefeated()
    local scaleAction = cc.ScaleBy:create(2,0.01)
    self:getChildByName("MonsterNode"):runAction(scaleAction)   
end

return GameBattlePanel

