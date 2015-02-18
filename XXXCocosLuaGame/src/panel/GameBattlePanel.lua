--------------------------------------------------------------------------------
-- GameBattlePanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

local GameBattlePanel = class("GameBattlePanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

---
-- Create the instance for the GameBattelPanel 
-- and set the position of this panel
-- @function [parent=#panel.GameBattlePanel] create
function GameBattlePanel.create()
    local panel = GameBattlePanel.new()
    -- set the panel position
    panel:setAnchorPoint(0,0)
    panel:setPosition(0, visibleSize.height * 0.8)
    -- initialize the panel
    panel:initPanel()
    return panel
end

---
--  Initilization of the GameBattelPanel
--@function [parent=#panel.GameBattlePanel] initPanel

function GameBattlePanel:initPanel()

    -- Create the BackgroundLayer
    -- TODO change the single color to the final sprite in te res file
    local backgroundColor = cc.c4b(255, 255, 255, 180)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
    self:addChild(backgroundLayer)
    
    -- TODO: Delete the test monster in this panel
    local monster = cc.Sprite:create("res/imgs/monster/Pikachu.png")
    monster:setPosition(550, 200)
    monster:setName("MonsterNode")
    self:addChild(monster)

    -- TODO: Delete the Back Button
    local backButton = cc.LabelTTF:create("Back Button", "Arial", 70)
    backButton:setAnchorPoint(0,0)
    backButton:setPosition(700 , 250)
    backButton:setName("BackButton")
    self:addChild(backButton)
    
    -- test for the scene change
    local function onTouch(eventType, x, y)
        local bButton = self:getChildByName("BackButton")
        assert(bButton, "Nil!")
        if x >= 700 and x <= (700 + bButton:getContentSize().width) and y >= (250 + visibleSize.height * 0.8) and y <= (250 + bButton:getContentSize().height + visibleSize.height * 0.8) then
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
    cclog("Function called")
    if self.damageText == nil then
        self.damageText = cc.LabelTTF:create("-"..damageValue, "Arial", 200)
        self.damageText:setName("DamageTextNode") 
        self:addChild(self.damageText)
    else
        self.damageText:setString("-"..damageValue)
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
-- Change the sprite for the monster when the monster is dead
-- @function [parent=#panel.GameBattlePanel] monsterIsDefeated
function GameBattlePanel:monsterIsDefeated()
    local scaleAction = cc.ScaleBy:create(2,0.01)
    self:getChildByName("MonsterNode"):runAction(scaleAction)   
end

return GameBattlePanel

