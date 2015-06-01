--------------------------------------------------------------------------------
-- GameOptionPanel.lua - 游戏选项面板
-- @author chaomin.zhong
--------------------------------------------------------------------------------

local GameOptionPanel = class("GameOptionPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameOptionPanel.create(scene, tutorialBtn)
    local layer = GameOptionPanel.new()
    layer:initLayer(scene, tutorialBtn)
    return layer
end

function GameOptionPanel:initLayer(scene, tutorialBtn)
    local inst = cc.UserDefault:getInstance()
    local hideTutorial = inst:getBoolForKey("hideTutorial")
    
    if scene.sceneName then
        local sprite = cc.Sprite:create("imgs/tutorial/" .. scene.sceneName .. ".png")
        if sprite then
            sprite:setPosition(visibleSize.width/2, visibleSize.height/2)
            self:addChild(sprite)
            
            local dispatcher = cc.Director:getInstance():getEventDispatcher()
            local listener = cc.EventListenerTouchOneByOne:create()
            
            local function onTouch(touch, event)
                if event:getEventCode() == ccui.TouchEventType.ended then
                    sprite:runAction(cc.FadeOut:create(0.5))
                    scene.touchEnabled = true
                    listener:setEnabled(false)
                    if scene.setGameTouch then
                        scene:setGameTouch(true)
                    end
                end
                
                return true
            end
            
            listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_BEGAN)
            listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_MOVED)
            listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_ENDED)
            dispatcher:addEventListenerWithSceneGraphPriority(listener, scene)
            listener:setSwallowTouches(true)
            
            local function onBtnPress(sender, eventType)
                if not scene.touchEnabled then return true end
                if eventType == ccui.TouchEventType.ended then 
                    if scene.setGameTouch then
                        scene:setGameTouch(false)
                    end
                            
                    scene.touchEnabled = false
                    sprite:runAction(cc.FadeIn:create(0.5))
                    listener:setEnabled(true)
                end
                return true
            end
            
            tutorialBtn:addTouchEventListener(onBtnPress)
            
            listener:setEnabled(false)
            sprite:setOpacity(0)
            
            if hideTutorial then
                tutorialBtn:setEnabled(false)
                tutorialBtn:setVisible(false)
            end
        else
            cclog("ERROR: This scene dont have a tutorial")
        end
    else
        if tutorialBtn then
            tutorialBtn:setEnabled(false)
            tutorialBtn:setVisible(false)
        end
    end
end

return GameOptionPanel