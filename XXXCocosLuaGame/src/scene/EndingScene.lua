--------------------------------------------------------------------------------
-- EndingScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")

local EndingScene = class("LoginScene", function() return BaseScene.create() end)

function EndingScene:ctor()
    self.sceneName = "EndingScene"
end

function EndingScene.create(params)
    local scene = EndingScene.new()
    scene:initScene(params)
    return scene
end

function EndingScene:onInit()
    local rootNode = cc.CSLoader:createNode("EndingScene.csb")
    self:addChild(rootNode)
    
    local btn2scene = {
        ["btn_retry"] = "GameScene",
        ["btn_next"] = "GameScene",
        ["btn_return"] = self.returnScene,
    }
    
    local function onBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender:getName() == "btn_next" then
                self.enterData.missionId = self.enterData.missionId + 1
            end
            local params = SceneManager.generateParams(self, "LoginScene", self.enterData)
            SceneManager.replaceSceneWithName(btn2scene[sender:getName()], params)
            return true
        end
    end
    
    if self.enterScene == "ResultScene" then
        rootNode:getChildByName("panel_btn"):getChildByName("btn_next"):setEnabled(true)
    else
        rootNode:getChildByName("panel_btn"):getChildByName("btn_next"):setEnabled(false)
    end
    
    for key,_ in pairs(btn2scene) do
        rootNode:getChildByName("panel_btn"):getChildByName(key):addTouchEventListener(onBtnPress)
    end
end

return EndingScene