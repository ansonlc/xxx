--------------------------------------------------------------------------------
-- ResultScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")

local ResultScene = class("LoginScene", function() return BaseScene.create() end)

function ResultScene:ctor()
    self.sceneName = "ResultScene"
end

function ResultScene.create(params)
    local scene = ResultScene.new()
    scene:initScene(params)
    return scene
end

function ResultScene:onInit()
    local rootNode = cc.CSLoader:createNode("ResultScene.csb")
    self:addChild(rootNode)
    
    --[[rootNode:getChildByName("txt_result"):setString("You WIN")
    local continueBtn = ccui.Button:create()
    continueBtn:setTitleText("Press here to continue")
    continueBtn:setTitleFontSize(50)
    rootNode:getChildByName("node_continue"):addChild(continueBtn)
    
    local scale1 = cc.ScaleTo:create(2, 1.2)
    local scale2 = cc.ScaleTo:create(1.5, 1)          
    local arrayOfActions = {scale1,scale2}
    local sequence = cc.Sequence:create(arrayOfActions)
    local repeatFunc = cc.RepeatForever:create(sequence)
    continueBtn:runAction(repeatFunc)
    
    local function onPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local params = SceneManager.generateParams(self, "MainMenuScene", self.enterData)
            SceneManager.replaceSceneWithName("EndingScene", params)
            return true
        end
    end
    
    continueBtn:addTouchEventListener(onPress)
    --]]
end

return ResultScene