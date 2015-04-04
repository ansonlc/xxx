--------------------------------------------------------------------------------
-- ResultScene.lua 
-- @author fangzhou.long
--------------------------------------------------------------------------------

--[[
Battle result example:
local upgradeSkillIds = {
{
    skillId = 0,
    lvlBefore = 0,
    lvlAfter = 0,
},
{
    skillId = 0,
    lvlBefore = 0,
    lvlAfter = 0,
},
}
local battleResult = {
    unlockMonsterId = 0,
    learnSkillId = 0,
    upgradeSkillIds = upgradeSkillIds,
    crystal = 0,
}
--]]

require("core.BaseScene")

local ResultScene = class("LoginScene", function() return BaseScene.create() end)

function ResultScene:ctor()
    self.sceneName = "ResultScene"
end

--------------------------------
--  Create method of the scene, will be execute when called
-- @function [parent=#ResultScene] create
-- @param #talbe params  
function ResultScene.create(params)
    local scene = ResultScene.new()
    scene:initScene(params)
    return scene
end

function ResultScene:onInit()
    local battleResult = self.enterData.battleResult

    local rootNode = cc.CSLoader:createNode("ResultScene.csb")
    self:addChild(rootNode)
    
    local monsterNode = rootNode:getChildByName("panel_result"):getChildByName("node_monster")
    local monsterSprite = GameIconManager.getMonsterSprite("Pikachu", 1, false)
    monsterSprite:setAnchorPoint(0, 0)
    monsterNode:addChild(monsterSprite)
    
    --rootNode:getChildByName("txt_result"):setString("You WIN")
    local continueBtn = ccui.Button:create()
    continueBtn:setTitleText("Press here to continue")
    continueBtn:setTitleFontSize(50)
    continueBtn:setPosition(cc.p(540,960))
    continueBtn:setOpacity(100)
    rootNode:addChild(continueBtn)
    
    local scale1 = cc.ScaleTo:create(2, 1.2)
    local scale2 = cc.ScaleTo:create(1.5, 1)          
    local arrayOfActions = {scale1,scale2}
    local sequence = cc.Sequence:create(arrayOfActions)
    local repeatFunc = cc.RepeatForever:create(sequence)
    continueBtn:runAction(repeatFunc)
    
    local function onPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local params = SceneManager.generateParams(self, "MainMenuScene", self.enterData.levelData)
            SceneManager.replaceSceneWithName("EndingScene", params)
            return true
        end
    end
    
    continueBtn:addTouchEventListener(onPress)
end

return ResultScene