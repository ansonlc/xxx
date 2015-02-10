--------------------------------------------------------------------------------
-- LoginScene.lua - 游戏登录场景
-- @author fangzhou.long
-- TODO Add login animations and login panel
--------------------------------------------------------------------------------

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
    self:addChild(self:createBackLayer())
    
    --self:addChild(self:createTitleInfo())

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/login.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    local eyeSprite1 = self:createEyeSprite()
    eyeSprite1:setPosition(cc.p(GBackGroundMiddlePoint.x - 50, GBackGroundMiddlePoint.y + 180))
    --self:addChild(eyeSprite1)

    local eyeSprite2 = self:createEyeSprite()
    eyeSprite2:setPosition(cc.p(GBackGroundMiddlePoint.x + 50, GBackGroundMiddlePoint.y + 180))
    --self:addChild(eyeSprite2)
end

function LoginScene:createEyeSprite()
	local eyeSprite = cc.Sprite:create("imgs/eye.png")

	local scale1 = cc.ScaleTo:create(0.1, 1, 0.2)
	local scale2 = cc.ScaleTo:create(0.1, 1, 1)	
	local delay = cc.DelayTime:create(2)		

    local arrayOfActions = {scale1, scale2, delay}  

    local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
	eyeSprite:runAction(repeatFunc)

	return eyeSprite
end

function LoginScene:createTitleInfo()
    local titleLabel = cc.LabelTTF:create("This is a game title", "Arial", 70)

    titleLabel:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.85))
    
    return titleLabel
end

function LoginScene:createTextBtn(btnStr)
	local button = ccui.Button:create()
    button:setTitleText(btnStr)
	button:setScale(2)
	
	local scale1 = cc.ScaleTo:create(2.5, 2.2)
	local scale2 = cc.ScaleTo:create(2.5, 2)			

    local arrayOfActions = {scale1,scale2}

	local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
    button:runAction(repeatFunc)

    return button
end

function LoginScene:createBackLayer()
	local backLayer = cc.Layer:create()

    local splashSprite = cc.Sprite:create("imgs/MenuScene00-0.png")
	splashSprite:setPosition(splashSprite:getContentSize().width / 2, splashSprite:getContentSize().height / 2)
	backLayer:addChild(splashSprite)

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
    
    local startBtn = self:createTextBtn("Press Here to Start")
    
    startBtn:addTouchEventListener(onStartBtnPress)
    startBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.55))
    backLayer:addChild(startBtn)
    
    local function onDebugBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            SceneManager.replaceSceneWithName("ParticleTestScene", "Test parameter passed by LoginScene")
            return true
        end
    end
    
    local debugBtn = self:createTextBtn("Debug Particular Scene");
    debugBtn:addTouchEventListener(onDebugBtnPress)
    debugBtn:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.32))
    backLayer:addChild(debugBtn)

	return backLayer
end

return LoginScene