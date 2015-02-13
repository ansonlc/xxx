--------------------------------
-- BaseScene.lua - 模板场景
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template scene
--------------------------------

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
    -- Visible size of this scene
    self.visibleSize = cc.Director:getInstance():getVisibleSize();
    
    -- Visible origin of this scene
    self.origin = cc.Director:getInstance():getVisibleOrigin();
    
    -- Scene name
    self.sceneName = "BaseScene"
    
    -- Enable onUpdate function or not
    self.enableUpdateFunc = true
    
    -- On update function entry
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

local sceneInitCount = 0
--------------------------------
--  Initialize method of the class, will be execute when called
-- @function [parent=#BaseScene] initScene
-- @param self
function BaseScene:initScene()
    sceneInitCount = sceneInitCount + 1
    cclog("No." .. sceneInitCount .. " Scene " .. self.sceneName .. " Initializing")
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
function BaseScene:onEnter() end

function BaseScene:doEnter()
    self:onEnter()
    
    -- The method to call subscene's onUpdate method
    local function onUpdateCallFunc(dt)
        if self then
            if self.onUpdate then
                self:onUpdate(dt)
            end -- Ignore if there is no valid onUpdate function
        else
            cclog("Calling onUpdate in a nil scene!")
        end
    end
    
    if self.onUpdate and self.enableUpdateFunc then
        self.onUpdateEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(onUpdateCallFunc, 0, false)
    end
end

--------------------------------
--  Handle something whent exit this scene, called by SceneManager
-- @function [parent=#BaseScene] onExit
-- @param self
function BaseScene:onExit() end

function BaseScene:doExit()
    if self.onUpdate and self.enableUpdateFunc then
        cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.onUpdateEntry)
    end
    
    self:onExit()
end

--------------------------------
--  Update on every frame
-- @function [parent=#BaseScene] onUpdate
-- @param self
-- @param #float dt Means the seconds between two frames
function BaseScene:onUpdate(dt) 
--    print(self.sceneName .. " updated in " .. dt .. " seconds")
end