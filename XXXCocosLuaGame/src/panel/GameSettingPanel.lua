--------------------------------------------------------------------------------
-- GameSettingPanel.lua - Setting Panel
-- @author Chao Lin
--------------------------------------------------------------------------------

require "config.CommonDefine.lua"

local GameSettingPanel = class("GameSettingPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameSettingPanel:create()
    local panel = GameSettingPanel.new()
    panel:initPanel()
    --parent.addChild(panel)
    return panel
end

function GameSettingPanel:initPanel()
    self.managePanel = cc.CSLoader:createNode("SettingPanel.csb")
    self.managePanel:setPosition((visibleSize.width-self.managePanel:getContentSize().width)/2, (visibleSize.height-self.managePanel:getContentSize().height)/2)
    self:addChild(self.managePanel)
    self.managePanel:setVisible(false)
    GameSettingPanel:initBtn(self.managePanel)
end

function GameSettingPanel:onUpdate(dt)
end

function GameSettingPanel:initBtn(rootNode)
    rootNode:getChildByName("btn_close"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            rootNode:setVisible(false)
        end
    end)
    
    rootNode:getChildByName("btn_resume"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            --rootNode:setVisible(false)
        end
    end)
    
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
        end
    end)
    
    rootNode:getChildByName("btn_credits"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 

        end
    end)
end

return GameSettingPanel