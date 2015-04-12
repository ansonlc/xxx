--------------------------------
-- GameButton.lua - 游戏按钮
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template game button
--------------------------------

--------------------------------
--  Base game button
-- @module core.GameButton
-- @extend ccui.Button
GameButton = class("GameButton", function() return ccui.Button:create() end)

function GameButton:ctor() end

function GameButton.create(text, withBg)
    local button = GameButton.new()
    button:setTitleText(text)
    button:setTitleFontSize(40)
    button:setTitleFontName("Marker Felt")
    button:setTouchEnabled(true)
    button:loadTextures(
        "imgs/btns/btn_normal.png",
        "imgs/btns/btn_normal_selected.png",
        "imgs/btns/btn_normal.png")
        
    local coverLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), 150, 60)
    coverLayer:setVisible(false)
    button.coverLayer = coverLayer
    button:addChild(coverLayer)
    
    return button;
end

function GameButton:setEnabled(enabled)
    ccui.Widget.setEnabled(self, enabled) --ccui.Button doesnt have a setEnabled method
    self.coverLayer:setVisible(not enabled)
end