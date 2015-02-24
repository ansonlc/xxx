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
    
    self:addChild(runeBlockLayer)
    
    -- Level Block
    local levelSprite = cc.Sprite:create("imgs/temp/leveltitle_1.png")
    levelSprite:setScaleX(visibleSize.width * GBattleLevelBlockHorizontalRatio / levelSprite:getContentSize().width)
    levelSprite:setScaleY(visibleSize.height * GBattleLevelBlockVerticalRatio / levelSprite:getContentSize().height)
    levelSprite:setAnchorPoint(0,0)
    levelSprite:setPosition(visibleSize.width * GBattleLevelBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleLevelBlockVerticalStartOffsetRatio)
    
    self:addChild(levelSprite)
    
    -- TODO: Delete the test monster in this panel
    local monster = cc.Sprite:create("res/imgs/monster/Pikachu.png")
    monster:setPosition(550, 200)
    monster:setName("MonsterNode")
    self:addChild(monster)

    -- TODO: Delete the Back Button
    local backButton = cc.LabelTTF:create("Back Button", "Arial", 70)
    backButton:setAnchorPoint(0,0)
    backButton:setPosition(700 , 400)
    backButton:setName("BackButton")
    self:addChild(backButton)
    
    -- test for the scene change
    local function onTouch(eventType, x, y)
        local bButton = self:getChildByName("BackButton")
        assert(bButton, "Nil!")
        if x >= 700 and x <= (700 + bButton:getContentSize().width) and y >= (400 + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) and y <= (400 + bButton:getContentSize().height + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) then
            SceneManager.replaceSceneWithName("LevelSelectScene","Test")
        end
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)

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

-- TODO: This function should not be called every frame (only on demand)
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

