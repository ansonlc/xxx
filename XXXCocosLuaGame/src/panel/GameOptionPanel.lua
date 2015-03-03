--------------------------------------------------------------------------------
-- GameOptionPanel.lua - 游戏选项面板
-- @author chaomin.zhong
--------------------------------------------------------------------------------

require "config.CommonDefine.lua"

local GameOptionPanel = class("GameOptionPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameOptionPanel:create()
    local layer = GameOptionPanel.new()
    layer:initLayer()
    return layer
end

function GameOptionPanel:initLayer()
    -- initialize the layer
    self:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.8)  
    -- initialize the constant

    local function onTouch(eventType, x, y)
        self:touchEventHandler(eventType, x, y)
    end
    
    self:registerScriptTouchHandler(onTouch)
    self:setTouchEnabled(true)
end

function LoginScene:onEnter()
    local action = cc.FadeIn:create(2.0)
    self.logoSprite:runAction(action)
end

function LoginScene.createTextBtn(btnStr)
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

function LoginScene:createBackLayer()
	local backLayer = cc.Layer:create()

    local bgSprite = cc.Sprite:create("imgs/main_menu_bg.png")
    bgSprite:setPosition(self.visibleSize.width / 2, self.visibleSize.height / 2)
    backLayer:addChild(bgSprite)
    
    self.logoSprite = cc.Sprite:create("imgs/main_menu_logo.png")
    self.logoSprite:setPosition(self.visibleSize.width / 2, self.visibleSize.height / 3)
    backLayer:addChild(self.logoSprite)
    self.logoSprite:setOpacity(0)

	return backLayer
end

function LoginScene:createBtnLayer()
    local btnLayer = cc.Layer:create()
    
    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchEnded()
        SceneManager.replaceSceneWithName("MainMenuScene")

        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onStartBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then   
            return onTouchEnded()
        end
    end

    local startBtn = self.createTextBtn("Press Here to Start")

    startBtn:addTouchEventListener(onStartBtnPress)
    startBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.32))
    btnLayer:addChild(startBtn)

    local function onDebugBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            SceneManager.replaceSceneWithName("TestScene", "Test parameter passed by LoginScene")
            return true
        end
    end

    local debugBtn = self.createTextBtn("Debug Particular Scene");
    debugBtn:addTouchEventListener(onDebugBtnPress)
    debugBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.22))
    btnLayer:addChild(debugBtn)
    
    return btnLayer
end

return LoginScene