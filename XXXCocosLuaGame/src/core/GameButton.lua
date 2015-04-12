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

function GameButton:init(text, withBg)
    if withBg then
        --Load button texture
        --TODO load different textures according to text
        self:loadTextures(
            "imgs/btns/btn_normal.png",
            "imgs/btns/btn_normal_selected.png",
            "imgs/btns/btn_normal.png")
    end
        
    --Set title data
    self:setTitle(text, "Marker Felt", 40)
end

function GameButton:setTitle(text, fontName, size)
    self:setTitleText(text)
    self:setTitleFontName(fontName)
    self:setTitleFontSize(size)
end

function GameButton.create(text, withBg)
    local button = GameButton.new()
    --Set touch
    button:setTouchEnabled(true)
    
    --Load button data
    button:init(text, withBg)
    
    --Add cover layer
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