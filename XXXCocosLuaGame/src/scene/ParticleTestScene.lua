--------------------------------------------------------------------------------
-- ParticleTestScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")

local ParticleTestScene = class("LoginScene", function() return BaseScene.create() end)

function ParticleTestScene:ctor()
    self.sceneName = "ParticleTestScene"
end

function ParticleTestScene.create()
    local scene = ParticleTestScene.new()
    scene:initScene()
    return scene
end

function ParticleTestScene:onInit()
    local rootNode = cc.CSLoader:createNode("ParticleTestScene.csb")
    
    local backBtn = rootNode:getChildByName("Button_Home")
    backBtn:setTitleText("Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        local scene = require("scene.LoginScene")
        local loginScene = scene.create()
        cc.Director:getInstance():replaceScene(loginScene)    
    return true end)
    
    self:addChild(rootNode)
end

return ParticleTestScene