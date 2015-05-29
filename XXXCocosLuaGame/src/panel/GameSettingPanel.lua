--------------------------------------------------------------------------------
-- GameSettingPanel.lua - Setting Panel
-- @author Chao Lin
--------------------------------------------------------------------------------

require "config.CommonDefine.lua"


local GameSettingPanel = class("GameSettingPanel", function() return cc.Layer:create() end)
--local GameSettingManagerLayer = class("GameSettingManagerLayer", function() return cc.LayerColor:create(cc.c4b(0, 0, 0,0)) end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

--[[function GameSettingManagerLayer:create()
    local layer = GameSettingManagerLayer.new()
    layer:initLayer()
    return layer
end

function GameSettingManagerLayer:initLayer()
    -- initialize the layer
    self:changeWidthAndHeight(visibleSize.width*0.8, visibleSize.height * 0.8)  
    
    --self:registerScriptTouchHandler(onTouch)
    --self:setTouchEnabled(true)
    
    -- background
    local bgPic = cc.Sprite:create("res/imgs/SettingPanel/setting_panel.png")
    bgPic:setAnchorPoint(0,0)
    bgPic:setScale(visibleSize.width * 0.8 / bgPic:getContentSize().width, visibleSize.height * 0.8 / bgPic:getContentSize().height)
    bgPic:setPosition(visibleSize.width*0.1, visibleSize.height * 0.1)
    self:addChild(bgPic)
end  ]]--
    
function GameSettingPanel:create()
    local panel = GameSettingPanel.new()
    panel:initPanel()
    --parent.addChild(panel)
    return panel
end

function GameSettingPanel:initPanel()
    --[[self.GameSettingManagerLayer = GameSettingManagerLayer:create()
    self.GameSettingManagerLayer:setName("GameSettingManager")
    self:addChild(self.GameSettingManagerLayer)]]--
    local rootNode = cc.CSLoader:createNode("SettingPanel.csb")
    rootNode:setPosition((visibleSize.width-rootNode:getContentSize().width)/2, (visibleSize.height-rootNode:getContentSize().height)/2)
    self:addChild(rootNode)
    GameSettingPanel:initBtn(rootNode)
end

function GameSettingPanel:onUpdate(dt)
    --self.GameSettingManagerLayer:onUpdate(dt)
end

function GameSettingPanel:initBtn(rootNode)
    rootNode:getChildByName("btn_close"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            rootNode:setVisible(false)
        end
    end)
    
    rootNode:getChildByName("btn_resume"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
        --rootNode:setVisible(false)
        end
    end)
end

return GameSettingPanel