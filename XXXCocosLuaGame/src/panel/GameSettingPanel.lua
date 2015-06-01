--------------------------------------------------------------------------------
-- GameSettingPanel.lua - Setting Panel
-- @author Chao Lin
--------------------------------------------------------------------------------

require "config.CommonDefine.lua"

local GameSettingPanel = class("GameSettingPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameSettingPanel:create(parent)
    local panel = GameSettingPanel.new()
    panel:initPanel(parent)
    panel:setName("GameSettingPanel")
    parent:addChild(panel)
    return panel
end

function GameSettingPanel:initPanel(parent)
    self.managePanel = cc.CSLoader:createNode("SettingPanel.csb")
    self.managePanel:setPosition((visibleSize.width-self.managePanel:getContentSize().width)/2, (visibleSize.height-self.managePanel:getContentSize().height)/2)
    self:addChild(self.managePanel)
    self.managePanel:setVisible(false)
    GameSettingPanel:initBtn(parent,self.managePanel)
end

function GameSettingPanel:onUpdate(dt)
end

function GameSettingPanel:initBtn(parent,rootNode)
    rootNode:getChildByName("btn_confirm"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then             
            if parent.sceneName == "GameScene" then
                local AINode = parent:getChildByName("MonsterAILogic")
                AINode.isAIOn = true
                parent:setGameTouch(true)
            else
                --parent:setTouchEnabled(true)
                parent.touchEnabled = true
            end
            rootNode:setVisible(false)

        end
    end)
    
    rootNode:getChildByName("btn_close"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then             
            if parent.sceneName == "GameScene" then
                local AINode = parent:getChildByName("MonsterAILogic")
                AINode.isAIOn = true
                parent:setGameTouch(true)
            else
                --parent:setTouchEnabled(true)
                parent.touchEnabled = true
            end
            rootNode:setVisible(false)
            
        end
    end)
    
    rootNode:getChildByName("btn_resume"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            if parent.sceneName == "GameScene" then
                local AINode = parent:getChildByName("MonsterAILogic")
                AINode.isAIOn = true
                parent:setGameTouch(true)
            else
                --parent:setTouchEnabled(true)
                parent.touchEnabled = true
            end
            rootNode:setVisible(false)            
        end
    end)
    
    if parent.sceneName == "MainMenuScene" then
        rootNode:getChildByName("btn_resume"):setVisible(false)
    end
    
    rootNode:getChildByName("btn_music"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SoundManager.switchMusic()
            --SoundManager.stopMusic()
            --SoundManager.pauseMusic()
        end
    end)
    
    rootNode:getChildByName("btn_sound"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SoundManager.switchEffect()
        end
    end)
    
    rootNode:getChildByName("btn_home"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("MainMenuScene")
            SoundManager.playBGM('menu',true)
        end
    end)
    
    rootNode:getChildByName("btn_credits"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("CreditScene")
        end
    end)
end

return GameSettingPanel