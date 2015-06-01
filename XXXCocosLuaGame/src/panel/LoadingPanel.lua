--------------------------------------------------------------------------------
-- LoadingPanel.lua --- 加载信息提示层
-- @author Fangzhou.Long
--------------------------------------------------------------------------------

local LoadingPanel = {}

function LoadingPanel.create()
    local visibleSize = cc.Director:getInstance():getVisibleSize();
    local blackLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), visibleSize.width, visibleSize.height)
    local label = cc.Label:create()
    label:setString("Loading......")
    label:setPosition(visibleSize.width/2 , visibleSize.height/2)
    label:setScale(6)
    blackLayer:addChild(label)

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
    blackLayer:setName("loadingLayer")
    blackLayer:setVisible(false)
    return blackLayer
end

return LoadingPanel