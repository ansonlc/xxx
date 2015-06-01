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
    --print("hello " .. true)
    local rootNode = cc.CSLoader:createNode("MainMenuScene.csb")
    self:addChild(rootNode)
    
    -- Add the SettingPanel
    local GameSettingPanel = require("panel.GameSettingPanel")
    self.settingPanel = GameSettingPanel:create(self)
    --self.settingPanel:setName("GameSettingPanel")
    --self:addChild(self.settingPanel)
    --self.settingPanel.managePanel:setVisible(false)
    
    self.btnOption = GameButton.create("OptionBtn_Menu")
    rootNode:getChildByName("panel_icon"):getChildByName("node_option"):addChild(self.btnOption)
    
    self.logoSprite = rootNode:getChildByName("main_menu_logo")
    
    self.btnStory = GameButton.create("Story")
    rootNode:getChildByName("btn_story"):addChild(self.btnStory)
    
    self.btnEndless = GameButton.create("Endless")
    rootNode:getChildByName("btn_endless"):addChild(self.btnEndless)
    
    self.btnVs = GameButton.create("VS")
    rootNode:getChildByName("btn_vs"):addChild(self.btnVs)
    
    self.btnTutorial = GameButton.create("TutorialBtn", true, 0.5)
    rootNode:getChildByName("btn_tutorial"):addChild(self.btnTutorial)
    
    
    
    self.panelIcon = rootNode:getChildByName("panel_icon")
    self.btn_skill = GameButton.create("SkillBtn")
    rootNode:getChildByName("panel_icon"):getChildByName("btn_skill"):addChild(self.btn_skill)
    self.btn_monster = GameButton.create("MonsterBtn")
    self.panelIcon:getChildByName("btn_monster"):addChild(self.btn_monster)
    self.btn_tutorial = GameButton.create("TutorialBtn_Menu")
    self.panelIcon:getChildByName("btn_tutorial"):addChild(self.btn_tutorial)
    
    self.logoSprite:setPosition(self.visibleSize.width/2, self.visibleSize.height/3)
    
    print (self.btnVs)
    print (self.btn_skill)
    self.btnStory:setOpacity(0)
    self.btnEndless:setOpacity(0)
    self.btnVs:setOpacity(0)
    self.btnTutorial:setOpacity(0)
    self.panelIcon:setOpacity(0)
    
    local function onStoryPress(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("LevelSelectScene")
        end
    end
       
    self.btnStory:addTouchEventListener(onStoryPress)
    self.btn_skill:addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("SkillTree")
        end
        
    end
    )
    
    self.btnOption:addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            self.settingPanel.managePanel:setVisible(true)
            --self:setTouchEnabled(false)
            self.touchEnabled = false 
            --self.settingPanel.managePanel:setSwallowsTouches(true)           
        end

    end
    )
    
    self.btn_tutorial:addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            local inst = cc.UserDefault:getInstance()
            local hideTutorial = inst:getBoolForKey("hideTutorial")
            hideTutorial = not hideTutorial
            inst:setBoolForKey("hideTutorial", hideTutorial)
            
            self.btnTutorial:setEnabled(not hideTutorial)
            if hideTutorial then
                self.btnTutorial:setVisible(false)
            else
                self.btnTutorial:setVisible(true)
                self.btnTutorial:setOpacity(0)
                self.btnTutorial:runAction(cc.FadeIn:create(0.5))
            end
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
        self.btnTutorial:runAction(cc.FadeIn:create(1))
        self.panelIcon:runAction(cc.FadeIn:create(1))
        
        local part = cc.ParticleGalaxy:create()
        local sequence = cc.Sequence:create({cc.MoveBy:create(2, cc.p(self.visibleSize.width-200, 0)), cc.MoveBy:create(2, cc.p(200-self.visibleSize.width, 0))})
        local repeatFunc = cc.RepeatForever:create(sequence)
        self:addChild(part)
        part:setPosition(cc.p(100, self.visibleSize.height/1.5))
        part:runAction(repeatFunc)
        
        local panel = require("panel.TutorialPanel")
        self:addChild(panel.create(self, self.btnTutorial))
    end
    
    local sequence = cc.Sequence:create({moveToAction, cc.CallFunc:create(endOnMoveTo)})
    self.logoSprite:runAction(sequence)
end

return MainMenuScene