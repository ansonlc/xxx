--------------------------------------------------------------------------------
-- TestScene.lua - 粒子效果测试场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("core.BaseScene")
require("manager.ParticleManager")

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
    --cclog("Parameter: " .. self.params)
    
    local rootNode = cc.CSLoader:createNode("ParticleTestScene.csb")
    
    -- test for the particle effect
    particleDisplay(cc.p(100,100),cc.p(1000,1000),rootNode,0.5,"effects/fx_fire.plist")
    
    --local particle = cc.ParticleSystemQuad:create("effects/fx_fire.plist")
    --particle:setPosition(100,100)
    --n:addChild(particle)
    
    --local moveToAction = cc.MoveTo:create(0.5, cc.p(1000, 1000))
    --particle:runAction(moveToAction)
    
    
    
    ---[[
    local backBtn = rootNode:getChildByName("Button_Home")
    backBtn:setTitleText("Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        SceneManager.replaceSceneWithName("LoginScene")
    return true end)
    --]]
    
    self:addChild(rootNode)
    
    local monster = GameIconManager.getMonsterSprite("Pikachu", 1, true)
    monster:setPosition(500, 500)
    rootNode:addChild(monster)
    
    local skill = GameIconManager.getSkillSprite(1002, 1, true, 1)
    skill:setPosition(500, 1000)
    rootNode:addChild(skill)
    
    local item = GameIconManager.getItemSprite(0, 1, true, 10)
    item:setPosition(500, 750)
    rootNode:addChild(item)
end

function TestScene:onUpdate()

end

return TestScene