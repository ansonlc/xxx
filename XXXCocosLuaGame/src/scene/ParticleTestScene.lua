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
    
    self:addChild(rootNode)
end

return ParticleTestScene