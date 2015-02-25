--------------------------------------------------------------------------------
-- TestScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")

local TestScene = class("LoginScene", function() return BaseScene.create() end)

function TestScene:ctor()
    self.sceneName = "TestScene"
end

function TestScene.create(params)
    local scene = TestScene.new()
    scene:initScene(params)
    return scene
end

function TestScene:onInit()
    cclog("Parameter: " .. self.params)
    
    local rootNode = cc.CSLoader:createNode("GameSceneLayout.csb")
    
    --[[local backBtn = rootNode:getChildByName("Button_Home")
    backBtn:setTitleText("Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        SceneManager.replaceSceneWithName("LoginScene")
    return true end)--]]
    
    self:addChild(rootNode)
end

function TestScene:onUpdate()

end

return TestScene