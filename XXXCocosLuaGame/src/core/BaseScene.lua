--------------------------------------------------------------------------------
-- BaseScene.lua - 模板场景
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template scene
-- TODO Add switch methods
--------------------------------------------------------------------------------

-- Definition of class, change the class name and comment for the scene here
BaseScene = class("BaseScene", function()
    return cc.Scene:create()
end)

-- Constructor of the scene, will be execute when called "new"
function BaseScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize();
    self.origin = cc.Director:getInstance():getVisibleOrigin();
end

-- Create method of the scene, will be execute
function BaseScene.create()
    local scene = BaseScene.new()
    scene:init()
    return scene;
end

-- Initialize method of the class, will be execute when create
function BaseScene:init()
    
end
