--------------------------------------------------------------------------------
-- GameOptionPanel.lua - 游戏选项面板
-- @author chaomin.zhong
--------------------------------------------------------------------------------

local GameOptionPanel = class("GameOptionPanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameOptionPanel:create(parent)
    local layer = GameOptionPanel.new()
    layer:initLayer()
    parent.addChild(layer)
    return layer
end
