--------------------------------
-- SceneManager.lua - 游戏场景管理器
-- @author fangzhou.long
--------------------------------

--------------------------------
--  Scene manager for the game
-- @module manager.SceneManager
SceneManager = {}

--------------------------------
--  The method to change current scene to a new scene and deliver a parameter table.
-- I really doubt whether we will use so I just left it alone --by fangzhou.long
-- @function [parent=#SceneManager] replaceScene
-- @param #string scene Target scene
-- @param #table params Parameters passed to create target scene
function SceneManager.replaceScene(scene, params)
    --TODO Is this function really needed?
    assert("Error! Uncompleted function called:" .. "SceneManager.replaceScene(scene, params) use sceneName instead!")
end

function SceneManager.generateLoadingPanel()
    local visibleSize = cc.Director:getInstance():getVisibleSize();
    local blackLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), visibleSize.width, visibleSize.height)
    local label = cc.Label:create()
    label:setString("Loading... Please wait")
    label:setPosition(visibleSize.width/2 , visibleSize.height/2)
    label:setScale(6)
    blackLayer:addChild(label)

    blackLayer:setTouchEnabled(true)
    blackLayer:setSwallowsTouches(true)
    --[[
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    local function onTouch(touch, event)
    return true
    end
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_ENDED)
    dispatcher:addEventListenerWithSceneGraphPriority(listener, blackLayer)
    --]]
    return blackLayer
end

--------------------------------
--  The method to change current scene to a new scene with its name and deliver a parameter table
-- @function [parent=#SceneManager] replaceSceneWithName
-- @param #string sceneName Target scene name
-- @param #table params Parameters passed to create target scene
function SceneManager.replaceSceneWithName(sceneName, params)
    local ccRunning = cc.Director:getInstance():getRunningScene()
    if ccRunning then
        if ccRunning.doExit then
            ccRunning:doExit()
        end
        local loading = SceneManager.generateLoadingPanel()
        ccRunning:addChild(loading)
        -- ccRunning:dispose()
    end

    local function doChangeScene()
        local startTime = TimeUtil.getRunningTime()
        local sceneClass = require("scene." .. sceneName)
        print ("sceneClass is.." .. sceneName)
        local targetScene = sceneClass.create(params)
        cclog("Initialized in " .. (TimeUtil.getRunningTime() - startTime) .. "s")

        cc.Director:getInstance():replaceScene(targetScene)

        if targetScene.doEnter then
            targetScene:doEnter()
        end
    end

    local sequence = cc.Sequence:create({cc.DelayTime:create(0.01), cc.CallFunc:create(doChangeScene)})
    if ccRunning then
        ccRunning:runAction(sequence)
    else
        local sceneClass = require("scene." .. sceneName)
        local targetScene = sceneClass.create(params)
        cc.Director:getInstance():runWithScene(targetScene)
        if targetScene.doEnter then
            targetScene:doEnter()
        end
    end
end

--------------------------------
--  The method to generate a parameter table passed to next scene
-- @function [parent=#SceneManager] generateParams
-- @param #cc.Scene curScene Current scene, often "self"
-- @param #string returnSceneName Tell next scene which scen should it go when pressed "Return" button
-- @param #table dataTable The datas passed to next scene
function SceneManager.generateParams(curScene, returnSceneName, dataTable)
    return {
        enterScene = curScene.sceneName,
        returnScene = returnSceneName,
        data = dataTable}
end