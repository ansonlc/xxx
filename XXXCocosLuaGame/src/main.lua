--------------------------------------------------------------------------------
-- main.lua
-- author: fangzhou.long
--------------------------------------------------------------------------------

cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
-- CC_USE_DEPRECATED_API = true

require "cocos.init"

require "core.BaseScene"
require "core.GameButton"
require "core.BaseRequest"

require "manager.DataManager"
require "manager.MetaManager"
require "manager.SceneManager"
require "manager.GameIconManager"
require "manager.ParticleManager"
require "manager.AnimationManager"
require "manager.SoundManager"
require "manager.NetworkManager"
require "utils.TimeUtil"

-- cclog
cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    
    DataManager.message = {
        title="Error: Game crashed",
        msg="We will fix this problem in\nnext version.",
        callback = nil,
    }
    SceneManager.replaceSceneWithName("LoginScene")
end

local function initGLView()
    local director = cc.Director:getInstance()
    local glView = director:getOpenGLView()
    if nil == glView then
        glView = cc.GLViewImpl:create("Lua Debbuger")
        director:setOpenGLView(glView)
    end

    director:setOpenGLView(glView)

    glView:setDesignResolutionSize(1080, 1920, cc.ResolutionPolicy.SHOW_ALL)

    --turn on display FPS
    director:setDisplayStats(false)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100) 
    collectgarbage("setstepmul", 5000)

    -- run
    initGLView()
    
    -- Don't init game/data here, init game at LoginScene:initGame() !
    SceneManager.replaceSceneWithName("LoginScene")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
