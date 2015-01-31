--------------------------------------------------------------------------------
-- BaseScene.lua - 模板场景
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template scene
-- TODO Add SceneManager
--------------------------------------------------------------------------------

-- Definition of class, change the class name and comment for the scene here
BaseScene = class("BaseScene", function() return cc.Scene:create() end)

-- Constructor of the scene, will be execute when called "new"
function BaseScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize();
    self.origin = cc.Director:getInstance():getVisibleOrigin();
    self.sceneName = "BaseScene"
    self.onUpdateEntry = nil
end

-- Create method of the scene, will be execute
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

-- Initialize method of the class, will be execute when create
function BaseScene:initScene()
    cclog("Scene " .. self.sceneName .. " Initialized")
    self:onInit()
end

-- Handle some child scene without a onInit method
function BaseScene:onInit() end

-- Handle something when enter this scene, called by SceneManager
function BaseScene:onEnter(params)
    if self.onUpdate then
        self.onUpdateEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(onUpdateGlobal, 0, false)
    end
end

-- Handle something whent exit this scene, called by SceneManager
function BaseScene:onExit()
    if self.onUpdate then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.onUpdateEntry)
    end
end

-- Update on every frame
function BaseScene:onUpdate(dt) 
--    print(dt)
end
