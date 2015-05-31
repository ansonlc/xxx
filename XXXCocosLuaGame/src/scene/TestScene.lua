--------------------------------------------------------------------------------
-- TestScene.lua
-- @author fangzhou.long
--------------------------------------------------------------------------------

require("json")
require("core.BaseScene")
require("manager.ParticleManager")
require("manager.MetaManager")

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
    
    -- Add the SettingPanel
    local GameSettingPanel = require("panel.GameSettingPanel")
    self.settingPanel = GameSettingPanel:create(self)
    
    -- Add the MessageBoxPanel
    local MessageBoxPanel = require("panel.MessageBoxPanel")
    local testfunc = function()print("test callback func")end
    local dataTable ={title="Test Title",msg="Testmsg\nThis is a warning\nThis is an error",callback = testfunc}
    self.messageBoxPanel = MessageBoxPanel.create(self,dataTable)
    
       
    self.setbtn = ccui.Button:create()
    self.setbtn:loadTextures("res/imgs/btns/icon/icon_option.png", "res/imgs/btns/icon/icon_option_selected.png")
    self.setbtn:setPosition(100,100)
    self:addChild(self.setbtn)
    self.setbtn:addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            --self.settingPanel.managePanel:setVisible(true)
            self.messageBoxPanel:setVisible(true)
        end
    end
    )
    
    --[[
    -- test for the particle effect
    local particle1  = MetaManager.getParticle(1001)
    local particle2  = MetaManager.getParticle(1002)
    local particle3  = MetaManager.getParticle(1003)
   
    ParticleManager.particleDisplay(cc.p(100,100),cc.p(1000,1000),rootNode,0.5,1001)
    ParticleManager.particleDisplay(cc.p(100,100),cc.p(1000,1500),rootNode,0.5,1002)
    ParticleManager.particleDisplay(cc.p(100,100),cc.p(1000,500),rootNode,0.5,1003)
    
    ParticleManager.sysParticleDisplay(cc.p(100,100),cc.p(1000,1500),rootNode,0.5,1005)
    
    

    -- show the plist effect
    local particle = cc.ParticleSystemQuad:create("effects/fx_activities.plist")
    particle:setPosition(100,100)
    rootNode:addChild(particle)    
    particle = cc.ParticleSystemQuad:create("effects/fx_blue_fire.plist")
    particle:setPosition(150,100)
    rootNode:addChild(particle)    
    particle = cc.ParticleSystemQuad:create("effects/fx_door.plist")
    particle:setPosition(200,100)
    rootNode:addChild(particle)    
    particle = cc.ParticleSystemQuad:create("effects/fx_fire.plist")
    particle:setPosition(250,100)
    rootNode:addChild(particle)    
    particle = cc.ParticleSystemQuad:create("effects/fx_flower.plist")
    particle:setPosition(300,100)
    rootNode:addChild(particle)
    particle = cc.ParticleSystemQuad:create("effects/fx_starline.plist")
    particle:setPosition(350,100)
    rootNode:addChild(particle)    
    particle = cc.ParticleSystemQuad:create("effects/fx_tree_light.plist")
    particle:setPosition(400,100)
    rootNode:addChild(particle)  
    
    
    
    -- show system's particle effect
    particle = cc.ParticleFire:create()
    particle:setPosition(cc.p(100,300))
    rootNode:addChild(particle)
    particle = cc.ParticleFireworks:create()
    particle:setPosition(cc.p(250,300))
    rootNode:addChild(particle)
    particle = cc.ParticleSun:create()
    particle:setPosition(cc.p(400,300))
    rootNode:addChild(particle)
    particle = cc.ParticleGalaxy:create()
    particle:setPosition(cc.p(550,300))
    rootNode:addChild(particle)
    particle = cc.ParticleFlower:create()
    particle:setPosition(cc.p(700,300))
    rootNode:addChild(particle)
    particle = cc.ParticleMeteor:create()
    particle:setPosition(cc.p(850,300))
    rootNode:addChild(particle) 
    particle = cc.ParticleSpiral:create()
    particle:setPosition(cc.p(1000,300))
    rootNode:addChild(particle)
    
    particle = cc.ParticleExplosion:create()
    particle:setPosition(cc.p(100,1000))
    rootNode:addChild(particle)
    particle = cc.ParticleSmoke:create()
    particle:setPosition(cc.p(250,1000))
    rootNode:addChild(particle)
    particle = cc.ParticleSnow:create()
    particle:setPosition(cc.p(400,1000))
    rootNode:addChild(particle)
    particle = cc.ParticleRain:create()
    particle:setPosition(cc.p(550,1000))
    rootNode:addChild(particle) 
    --local moveToAction = cc.MoveTo:create(0.5, cc.p(1000, 1000))
    --particle:runAction(moveToAction)
    --]]
    
    
    ---[[
    local backBtn = rootNode:getChildByName("Button_Home")
    backBtn:setTitleText("Back")
    backBtn:addTouchEventListener(function(sender, eventType)
        SceneManager.replaceSceneWithName("LoginScene")
    return true end)
    --]]
    
    self:addChild(rootNode)
    --[[
    local monster = GameIconManager.getMonsterSprite("Pikachu", 1, true)
    monster:setPosition(500, 600)
    rootNode:addChild(monster)
    --]]
    --[[
    local actionSeq = cc.Sequence:create(cc.FadeIn:create(1),cc.FadeOut:create(1))
    local actionSeq1 = cc.Sequence:create(cc.DelayTime:create(0.5),cc.Hide:create(),cc.DelayTime:create(1),cc.Show:create())
    
    local actionByLeft = cc.MoveBy:create(0.1,cc.p(-50,0))
    local actionByLeftBack  = actionByLeft:reverse()
    local actionByRight = cc.MoveBy:create(0.1,cc.p(50,0))
    local actionByRightBack  = actionByRight:reverse()   
    local actionScaleTo = cc.ScaleTo:create(0.5, 1.5)
    local actionScaleToBack = cc.ScaleTo:create(0.5, 1) 
    
    local actionSeq2 = cc.Sequence:create(cc.Blink:create(0.5, 3),actionByLeft,actionByLeftBack,actionByRight,actionByRightBack,actionScaleTo,actionScaleToBack)
    monster:runAction(actionSeq2)
    --local p = monster:getPositionY()
    
    local skill = GameIconManager.getSkillSprite(1002, 1, true, 0)
    skill:setPosition(500, 1000)
    --rootNode:addChild(skill)
    
    local item = GameIconManager.getItemSprite(0, 1, true, 10)
    item:setPosition(500, 750)
    --rootNode:addChild(item)
    --]]
       
    local sprite = AnimationManager.create("Attack1", nil, 10)
    rootNode:addChild(sprite)
    sprite:setScale(3)
    sprite:setPosition(cc.p(500, 750))
    sprite:runAnimation()
    
    local request = RegisterRequest.create()
    NetworkManager.send(request, request.onSuccess)
end

function TestScene:onUpdate()

end

return TestScene