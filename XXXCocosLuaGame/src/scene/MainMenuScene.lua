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
    
    self.logoSprite = rootNode:getChildByName("main_menu_logo")
    self.btnStory = rootNode:getChildByName("btn_story")
    self.btnEndless = rootNode:getChildByName("btn_endless")
    self.btnVs = rootNode:getChildByName("btn_vs")
    
    self.logoSprite:setPosition(self.visibleSize.width/2, self.visibleSize.height/3)
    
    self.btnStory:setOpacity(0)
    self.btnEndless:setOpacity(0)
    self.btnVs:setOpacity(0)
    
    local function onStoryPress(sender, eventType)
        SceneManager.replaceSceneWithName("GameScene")
        return true
    end
    
    self.btnStory:addTouchEventListener(onStoryPress)
end

function MainMenuScene:onEnter()
    local moveToAction = cc.MoveTo:create(0.5, cc.p(self.visibleSize.width/2, self.visibleSize.height/2))
    
    local curScene = self
    local function endOnMoveTo()
        curScene.btnStory:runAction(cc.FadeIn:create(1))
        curScene.btnEndless:runAction(cc.FadeIn:create(1))
        curScene.btnVs:runAction(cc.FadeIn:create(1))
    end
    
    local sequence = cc.Sequence:create({moveToAction, cc.CallFunc:create(endOnMoveTo)})
    self.logoSprite:runAction(sequence)
end

return MainMenuScene