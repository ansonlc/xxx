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
    SoundManager.playBGM('menu', true)
    
    local rootNode = cc.CSLoader:createNode("EndingScene.csb")
    self:addChild(rootNode)
    
    local btns = {
        ["btn_retry"] = GameButton.create("Retry", true, 2),
        ["btn_next"] = GameButton.create("Continue", true, 2),
        ["btn_return"] = GameButton.create("Return", true ,2),
    }
    
    btns["btn_next"]:setTitleFontSize(30)
    
    local btn2scene = {
        ["btn_retry"] = "SkillSelectScene",
        ["btn_next"] = "LevelSelectScene",
        ["btn_return"] = "MainMenuScene",
    }
    
    local function onBtnPress(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then
            if sender:getName() == "btn_next" then
                self.enterData.missionId = self.nextLevelId
            end
            local params = SceneManager.generateParams(self, "LoginScene", self.enterData)
            SceneManager.replaceSceneWithName(btn2scene[sender:getName()], params)
            return true
        end
    end
    
    btns["btn_next"]:setEnabled(false)
    if self.enterScene == "ResultScene" then
        local _, nowLevelKey = GeneralUtil.getSubTableByKey(MetaManager["battle_mission"], 
            {name = "id", value = self.enterData.missionId})
        if MetaManager["battle_mission"][nowLevelKey+1] then
            self.nextLevelId = MetaManager["battle_mission"][nowLevelKey+1].id
            btns["btn_next"]:setEnabled(true)
        end
    end
    
    for key,_ in pairs(btn2scene) do
        rootNode:getChildByName("panel_btn"):getChildByName("node_" .. key):addChild(btns[key])
        btns[key]:setName(key)
        btns[key]:addTouchEventListener(onBtnPress)
    end
end

return EndingScene