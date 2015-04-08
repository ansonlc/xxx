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

--------------------------------
--  The method to change current scene to a new scene with its name and deliver a parameter table
-- @function [parent=#SceneManager] replaceSceneWithName
-- @param #string sceneName Target scene name
-- @param #table params Parameters passed to create target scene
function SceneManager.replaceSceneWithName(sceneName, params)
    local ccRunning = cc.Director:getInstance():getRunningScene()
    if ccRunning and ccRunning.doExit then
        ccRunning:doExit()
        -- ccRunning:dispose()
    end
    
    local startTime = TimeUtil.getRunningTime()
    local sceneClass = require("scene." .. sceneName)
    print ("sceneClass is..")
    print (sceneClass)
    local targetScene = sceneClass.create(params)
    cclog("Initialized in " .. (TimeUtil.getRunningTime() - startTime) .. "s")
    
    if ccRunning then
        cc.Director:getInstance():replaceScene(targetScene)
    else
        cc.Director:getInstance():runWithScene(targetScene)
    end
    
    if targetScene.doEnter then
        targetScene:doEnter()
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