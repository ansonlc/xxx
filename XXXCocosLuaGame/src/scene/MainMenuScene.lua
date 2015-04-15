--------------------------------
-- MainMenuScene.lua - 游戏主菜单场景
-- @author fangzhou.long
-- TODO Add login panel
--------------------------------

require("core.BaseScene")

local MainMenuScene = class("MainMenuScene", function() return BaseScene.create() end)

function MainMenuScene:ctor()
    self.sceneName = "MainMenuScene"
end

function MainMenuScene.create()
    local scene = MainMenuScene.new()
    scene:initScene()
    return scene
end

function MainMenuScene:onInit()
    local rootNode = cc.CSLoader:createNode("MainMenuScene.csb")
    self:addChild(rootNode)
    
    self.btnOption = GameButton.create("OptionBtn_Menu")
    rootNode:getChildByName("panel_icon"):getChildByName("node_option"):addChild(self.btnOption)
    
    self.logoSprite = rootNode:getChildByName("main_menu_logo")
    
    self.btnStory = GameButton.create("Story")
    rootNode:getChildByName("btn_story"):addChild(self.btnStory)
    
    self.btnEndless = GameButton.create("Endless")
    rootNode:getChildByName("btn_endless"):addChild(self.btnEndless)
    
    self.btnVs = GameButton.create("VS")
    rootNode:getChildByName("btn_vs"):addChild(self.btnVs)
    
    self.panelIcon = rootNode:getChildByName("panel_icon")
    self.btn_skill = GameButton.create("SkillBtn")
    rootNode:getChildByName("panel_icon"):getChildByName("btn_skill"):addChild(self.btn_skill)
    self.btn_monster = GameButton.create("MonsterBtn")
    self.panelIcon:getChildByName("btn_monster"):addChild(self.btn_monster)
    self.btn_tutorial = GameButton.create("TutorialBtn")
    self.panelIcon:getChildByName("btn_tutorial"):addChild(self.btn_tutorial)
    
    self.logoSprite:setPosition(self.visibleSize.width/2, self.visibleSize.height/3)
    
    print (self.btnVs)
    print (self.btn_skill)
    self.btnStory:setOpacity(0)
    self.btnEndless:setOpacity(0)
    self.btnVs:setOpacity(0)
    self.panelIcon:setOpacity(0)
    
    local function onStoryPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("LevelSelectScene")
        end
    end
       
    self.btnStory:addTouchEventListener(onStoryPress)
    self.btn_skill:addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("SkillTree")
        end
        
    end
    )
end

function MainMenuScene:onEnter()
    --TODO perform different enter animation when enter from other scenes
    local moveToAction = cc.MoveTo:create(0.5, cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
    
    local function endOnMoveTo()
        self.btnStory:runAction(cc.FadeIn:create(1))
        self.btnEndless:runAction(cc.FadeIn:create(1))
        self.btnVs:runAction(cc.FadeIn:create(1))
        self.panelIcon:runAction(cc.FadeIn:create(1))
        
        local part = cc.ParticleGalaxy:create()
        local sequence = cc.Sequence:create({cc.MoveBy:create(2, cc.p(self.visibleSize.width-200, 0)), cc.MoveBy:create(2, cc.p(200-self.visibleSize.width, 0))})
        local repeatFunc = cc.RepeatForever:create(sequence)
        self:addChild(part)
        part:setPosition(cc.p(100, self.visibleSize.height/1.5))
        part:runAction(repeatFunc)
    end
    
    local sequence = cc.Sequence:create({moveToAction, cc.CallFunc:create(endOnMoveTo)})
    self.logoSprite:runAction(sequence)
end

return MainMenuScene