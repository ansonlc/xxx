--------------------------------------------------------------------------------
-- GameOptionPanel.lua - 游戏选项面板
-- @author chaomin.zhong
--------------------------------------------------------------------------------

require "config.CommonDefine.lua"

local GameOptionPanel = class("GameOptionPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameOptionPanel:create(parent)
    local layer = GameOptionPanel.new()
    layer:initLayer()
    parent.addChild(layer)
    return layer
end

function GameOptionPanel:initLayer()
    -- initialize the layer
    self:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)  
    -- initialize the constant
    --[[
    local function onTouch(eventType, x, y)
        self:touchEventHandler(eventType, x, y)
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)
    --]]
end

function GameOptionPanel.createTextBtn(btnStr)
    local button = ccui.Button:create()
    button:setTitleText(btnStr)
    button:setScale(4)
    
    local scale1 = cc.ScaleTo:create(1.5, 3.5)
    local scale2 = cc.ScaleTo:create(2, 4)          

    local arrayOfActions = {scale1,scale2}

    local sequence = cc.Sequence:create(arrayOfActions)

    local repeatFunc = cc.RepeatForever:create(sequence)
    button:runAction(repeatFunc)

    return button
end

function GameOptionPanel:createBtnLayer()
    local btnLayer = cc.Layer:create()
    
    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchEnded()
        SceneManager.replaceSceneWithName("MainMenuScene")

        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onResumeBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then   
            return nil
        end
    end

    local resumeBtn = self.createTextBtn("Resume")

    resumeBtn:addTouchEventListener(onResumeBtnPress)
    resumeBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.8))
    btnLayer:addChild(resumeBtn)

    local function onMusicBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then   
            return nil
        end
    end

    local musicBtn = self.createTextBtn("Music")

    musicBtn:addTouchEventListener(onMusicBtnPress)
    musicBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.6))
    btnLayer:addChild(musicBtn)

    local function onSoundEffectBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then   
            return nil
        end
    end

    local soundEffectBtn = self.createTextBtn("Sound Effect")

    soundEffectBtn:addTouchEventListener(onSoundEffectBtnPress)
    soundEffectBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.4))
    btnLayer:addChild(soundEffectBtn)

    local function onReturnBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then   
            return nil
        end
    end

    local returnBtn = self.createTextBtn("Return")

    returnBtn:addTouchEventListener(onReturnBtnPress)
    returnBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.2))
    btnLayer:addChild(returnBtn)
    
    return btnLayer
end

return GameOptionPanel