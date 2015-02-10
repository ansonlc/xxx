--------------------------------
-- LoginScene.lua - 游戏登录场景
-- @author fangzhou.long
-- TODO Add login animations and login panel
--------------------------------

require("core.BaseScene")
require("config.CommonDefine")

local LoginScene = class("LoginScene", function() return BaseScene.create() end)

function LoginScene:ctor()
    self.sceneName = "LoginScene"
end

--------------------------------------------------------------------------------
-- Scene initialize progress:
-- BaseScene.create -> BaseScene.new -> BaseScene.ctor -> LoginScene.ctor -> 
-- BaseScene.initScene -> LoginScene.onInit()
--------------------------------------------------------------------------------
function LoginScene.create()
    local scene = LoginScene.new()
    scene:initScene()
    return scene
end

function LoginScene:onInit()
    self:addChild(self.createBackLayer())
    self:addChild(self:createBtnLayer())
    
    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/login.wav")
    AudioEngine.playMusic(bgMusicPath, true)
end

function LoginScene.createTextBtn(btnStr)
	local button = ccui.Button:create()
    button:setTitleText(btnStr)
	button:setScale(4)
	
	local scale1 = cc.ScaleTo:create(4.5, 3.5)
	local scale2 = cc.ScaleTo:create(4.5, 4)			

    local arrayOfActions = {scale1,scale2}

	local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
    button:runAction(repeatFunc)

    return button
end

function LoginScene.createBackLayer()
	local backLayer = cc.Layer:create()

    local bgSprite = cc.Sprite:create("imgs/main_menu_bg.png")
    bgSprite:setPosition(bgSprite:getContentSize().width / 2, bgSprite:getContentSize().height / 2)
    backLayer:addChild(bgSprite)
    
    local logoSprite = cc.Sprite:create("imgs/main_menu_logo.png")
    logoSprite:setPosition(logoSprite:getContentSize().width / 2, logoSprite:getContentSize().height / 3)
    backLayer:addChild(logoSprite)

	return backLayer
end

function LoginScene:createBtnLayer()
    local btnLayer = cc.Layer:create()
    
    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchEnded()
        SceneManager.replaceSceneWithName("GameScene")

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
            SceneManager.replaceSceneWithName("ParticleTestScene", "Test parameter passed by LoginScene")
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