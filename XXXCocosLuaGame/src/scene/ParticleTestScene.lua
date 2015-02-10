--------------------------------------------------------------------------------
-- ParticleTestScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")

local ParticleTestScene = class("LoginScene", function() return BaseScene.create() end)

function ParticleTestScene:ctor()
    self.sceneName = "ParticleTestScene"
end

function ParticleTestScene.create(params)
    local scene = ParticleTestScene.new()
    scene.params = params
    scene:initScene()
    return scene
end

function ParticleTestScene:onInit()
    cclog("Parameter: " .. self.params)
    
    local rootNode = cc.CSLoader:createNode("ParticleTestScene.csb")
    
    local backBtn = rootNode:getChildByName("Button_Home")
    backBtn:setTitleText("Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        SceneManager.replaceSceneWithName("LoginScene")
    return true end)
    
    self:addChild(rootNode)
end

function ParticleTestScene:onUpdate()

end

return ParticleTestScene