--------------------------------------------------------------------------------
-- main.lua - 主类
-- author: fangzhou.long
--------------------------------------------------------------------------------

cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("res")
-- CC_USE_DEPRECATED_API = true

require "cocos.init"
require "manager.DataManager"
require "manager.MetaManager"
require "manager.SceneManager"
require "manager.GameIconManager"
require "manager.ParticleManager"
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
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100) 
    collectgarbage("setstepmul", 5000)

    -- run
    initGLView()
    
    DataManager.loadUserInfo()
    DataManager.saveData()
    MetaManager.init()
    ParticleManager.init()
    SceneManager.replaceSceneWithName("LoginScene")
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end