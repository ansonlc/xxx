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
    
    self:addChild(self:createTitleInfo())
    
    self:addChild(self:createPressScreenInfo())

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/login.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    local eyeSprite1 = self:createEyeSprite()
    eyeSprite1:setPosition(cc.p(GBackGroundMiddlePoint.x - 50, GBackGroundMiddlePoint.y + 180))
    self:addChild(eyeSprite1)

    local eyeSprite2 = self:createEyeSprite()
    eyeSprite2:setPosition(cc.p(GBackGroundMiddlePoint.x + 50, GBackGroundMiddlePoint.y + 180))
    self:addChild(eyeSprite2)
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

function LoginScene:createPressScreenInfo()
	local testLabel = cc.LabelTTF:create("Press to Start", "Arial", 30)
	
	local scale1 = cc.ScaleTo:create(1.5, 1.2)
	local scale2 = cc.ScaleTo:create(1.5, 1)			

    local arrayOfActions = {scale1,scale2}

	local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
	testLabel:runAction(repeatFunc)

    testLabel:setPosition(cc.p(self.visibleSize.width / 2, self.visibleSize.height * 0.15))

	return testLabel
end

function LoginScene:createBackLayer()
	local backLayer = cc.Layer:create()

	local splashSprite = cc.Sprite:create("imgs/splash_bg.png")
	splashSprite:setPosition(splashSprite:getContentSize().width / 2, splashSprite:getContentSize().height / 2)
	backLayer:addChild(splashSprite)

    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchBegan(x, y)
		print("touch began...")
		
        local scene = require("scene.GameScene")
        local gameScene = scene.create()
        cc.Director:getInstance():replaceScene(gameScene)
		
        touchBeginPoint = {x = x, y = y}
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onTouch(eventType, x, y)
        if eventType == "began" then   
            return onTouchBegan(x, y)
        end
    end

    backLayer:registerScriptTouchHandler(onTouch)
    backLayer:setTouchEnabled(true)

	return backLayer
end

return LoginScene