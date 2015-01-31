--------------------------------------------------------------------------------
-- Splash.lua - 游戏登录场景
-- @author fangzhou.long
-- TODO Add login animations and login panel
--------------------------------------------------------------------------------

require("core.BaseScene")
require("Scene.GameScene")

local SplashScene = class("SplashScene", function() return BaseScene.create() end)

function SplashScene:ctor()
    self.sceneName = "SplashScene"
end

--------------------------------------------------------------------------------
-- Scene initialize progress:
-- BaseScene.create -> BaseScene.new -> BaseScene.ctor -> SplashScene.ctor -> 
-- BaseScene.initScene -> SplashScene.onInit()
--------------------------------------------------------------------------------
function SplashScene.create()
    local scene = SplashScene.new()
    scene:initScene()
    return scene
end

function SplashScene:onInit()
    self:addChild(self:createBackLayer())

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/login.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    local eyeSprite1 = self:createEyeSprite()
    eyeSprite1:setPosition({GBackGroundMiddlePoint.x - 50, GBackGroundMiddlePoint.y + 180})
    cclog("GBackGroundMiddlePoint  "..GBackGroundMiddlePoint.x.."  "..GBackGroundMiddlePoint.y)

    local eyeSprite2 = self:createEyeSprite()
    eyeSprite2:setPosition({GBackGroundMiddlePoint.x + 50, GBackGroundMiddlePoint.y + 180})

    self:addChild(eyeSprite1)
    self:addChild(eyeSprite2)
end

function SplashScene:createEyeSprite()
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

function SplashScene:createPressScreenInfo()
	local testLabel = cc.LabelTTF:create("Press Screen", "Arial", 30)
	
	local scale1 = cc.ScaleTo:create(1.5, 1.2)
	local scale2 = cc.ScaleTo:create(1.5, 1)			

    local arrayOfActions = {scale1,scale2}

	local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
	testLabel:runAction(repeatFunc)

    testLabel:setPosition(cc.p(self.visibleSize.width / 2, 130))

	return testLabel
end

function SplashScene:createBackLayer()
	local backLayer = cc.Layer:create()

	local splashSprite = cc.Sprite:create("imgs/splash_bg.png")
	splashSprite:setPosition(splashSprite:getContentSize().width / 2, splashSprite:getContentSize().height / 2)


	backLayer:addChild(splashSprite)

    local testLabel = self:createPressScreenInfo()
	backLayer:addChild(testLabel)

    -- handing touch events
    local touchBeginPoint = nil

    local function onTouchBegan(x, y)
		print("touch began...")
		cc.Director:getInstance():replaceScene(CreateGameScene())
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

return SplashScene