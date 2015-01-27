--------------------------------------------------------------------------------
-- Splash.lua - 游戏登录场景
-- author: fangzhou.long
-- TODO 将本场景包装成类
--------------------------------------------------------------------------------

require("src/Scene/GameScene")

local visibleSize = cc.Director:getInstance():getVisibleSize()	

local function createEyeSprite()
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

local function createPressScreenInfo()
	local testLabel = cc.LabelTTF:create("Press Screen", "Arial", 30)
	
	local scale1 = cc.ScaleTo:create(1.5, 1.2)
	local scale2 = cc.ScaleTo:create(1.5, 1)			

    local arrayOfActions = {scale1,scale2}

	local sequence = cc.Sequence:create(arrayOfActions)

	local repeatFunc = cc.RepeatForever:create(sequence)
	testLabel:runAction(repeatFunc)

	testLabel:setPosition(cc.p(visibleSize.width / 2, 130))

	return testLabel
end

local function createBackLayer()

	local backLayer = cc.Layer:create()

	local splashSprite = cc.Sprite:create("imgs/splash_bg.png")
	splashSprite:setPosition(splashSprite:getContentSize().width / 2, splashSprite:getContentSize().height / 2)


	backLayer:addChild(splashSprite)

	local testLabel = createPressScreenInfo()
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

-- create main menu
function CreateSplashScene()
	local scene = cc.Scene:create()
	scene:addChild(createBackLayer())

	local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/login.wav")
	AudioEngine.playMusic(bgMusicPath, true)

	local eyeSprite1 = createEyeSprite()
	eyeSprite1:setPosition({GBackGroundMiddlePoint.x - 50, GBackGroundMiddlePoint.y + 180})
	cclog("GBackGroundMiddlePoint  "..GBackGroundMiddlePoint.x.."  "..GBackGroundMiddlePoint.y)

	local eyeSprite2 = createEyeSprite()
	eyeSprite2:setPosition({GBackGroundMiddlePoint.x + 50, GBackGroundMiddlePoint.y + 180})

	scene:addChild(eyeSprite1)
	scene:addChild(eyeSprite2)

    return scene
end