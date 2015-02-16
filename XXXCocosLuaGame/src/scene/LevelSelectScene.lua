--------------------------------
-- LevelSelectScene.lua
-- @author fangzhou.long
-- TODO Add background map
--------------------------------

local LevelAmounts = 3

local LevelSelectScene = class("LevelSelectScene", function() return BaseScene.create() end)

function LevelSelectScene:ctor()
    self.sceneName = "LevelSelectScene"
end

function LevelSelectScene.create()
    local scene = LevelSelectScene.new()
    scene:initScene()
    return scene
end

function LevelSelectScene:onInit()
    local rootNode = cc.CSLoader:createNode("LevelSelectScene.csb")
    self:addChild(rootNode)
    
    local function onTouch(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            local params = SceneManager.generateParams(self, "MainMenuScene", {level = 0})
            params.data.difficulty = "Hard"
            
            if sender:getName() == "btn_lvl_1" then
                params.data.mode = "SwitchMode"
            end
            
            if sender:getName() == "btn_lvl_2" then
                params.data.mode = "DragMode"
            end
            
            if sender:getName() == "btn_lvl_3" then
                params.data.mode = "SlideMode"
            end
            
            SceneManager.replaceSceneWithName("GameScene", params)
        end
    end
    
    for i=1,LevelAmounts do
        local button = rootNode:getChildByName("LevelScroll"):getChildByName("btn_lvl_" .. i)
        button:addTouchEventListener(onTouch)
    end
end

return LevelSelectScene