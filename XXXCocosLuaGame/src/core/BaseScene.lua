--------------------------------------------------------------------------------
-- BaseScene.lua - 模板场景
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template scene
--------------------------------------------------------------------------------

--------------------------------
--  Base UI scene for every scene
-- @module core.BaseScene
-- @extend cc.Scene
BaseScene = class("BaseScene", function() return cc.Scene:create() end)

--------------------------------
--  Constructor of the scene, will be execute when called "new"
-- @function [parent=#BaseScene] ctor
-- @param self 
function BaseScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize();
    self.origin = cc.Director:getInstance():getVisibleOrigin();
    self.sceneName = "BaseScene"
    self.onUpdateEntry = nil
end

--------------------------------
--  Create method of the scene, will be execute when called
--  @function [parent=#BaseScene] create
--  @param self
--  @return #cc.Scene Created scene
function BaseScene.create()
    local scene = BaseScene.new()
    return scene;
end

-- The method to call subscene's onUpdate method
local function onUpdateGlobal(dt)
    local runningScene = cc.Director:getInstance():getRunningScene()
    if  runningScene 
        and runningScene.onUpdate 
        then
        runningScene:onUpdate(dt)
    end
end

--------------------------------
--  Initialize method of the class, will be execute when called
-- @function [parent=#BaseScene] initScene
-- @param self
function BaseScene:initScene()
    cclog("Scene " .. self.sceneName .. " Initialized")
    self:onInit()
end

--------------------------------
--  Handle some child scene without a onInit method
--  @function [parent=#BaseScene] onInit
--  @param self
function BaseScene:onInit() end

--------------------------------
--  Handle something when enter this scene, called by SceneManager
-- @function [parent=#BaseScene] onEnter
-- @param self
function BaseScene:onEnter()
    if self.onUpdate then
        self.onUpdateEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(onUpdateGlobal, 0, false)
    end
end

--------------------------------
--  Handle something whent exit this scene, called by SceneManager
-- @function [parent=#BaseScene] onExit
-- @param self
function BaseScene:onExit()
    if self.onUpdate then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.onUpdateEntry)
    end
end

--------------------------------
--  Update on every frame
-- @function [parent=#BaseScene] onUpdate
-- @param self
-- @param #float dt Means the seconds between two frames
function BaseScene:onUpdate(dt) 
--    print(self.sceneName .. " updated in " .. dt .. " seconds")
end