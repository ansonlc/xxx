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

--------------------------------
--  Initialize method of the scene, will be execute when called "created"
--  @function [parent=#GameButton] init
--  @param self
--  @param #string text Text key
--  @param #bool withBg Load background texture or not
function GameButton:init(text, withBg)
    local btnConfig = MetaManager.getBtnUI(text)
    --Load background texture
    if withBg then
        --Load button texture
        if btnConfig and btnConfig.normal then
            self:loadTextureNormal(btnConfig.normal)
        else
            self:loadTextureNormal("imgs/btns/btn_normal.png")
        end
        if btnConfig and btnConfig.selected then
            self:loadTexturePressed(btnConfig.selected)
        else
            self:loadTexturePressed("imgs/btns/btn_normal_selected.png")
        end
        if btnConfig and btnConfig.disabled then
            if (btnConfig.disabled == "normal") then
                self:loadTextureDisabled(btnConfig.noraml)
            else
                self:loadTextureDisabled(btnConfig.disabled)
            end
        else
            self:loadTextureDisabled("imgs/btns/btn_normal.png")
        end
    end
        
    --Set title data
    if btnConfig then
        if btnConfig.text then
            self:setTitle(btnConfig.text)
        --else
            --Don't put title text when btnConfig.text == nil
        end
    else
        self:setTitle(text, "Marker Felt", 40)
    end
end

--------------------------------
--  Set title text of game button
--  @function [parent=#GameButton] setTitle
--  @param self
--  @param #string Title text
--  @param #bool fontName Title font name
--  @param #int size Title font size
function GameButton:setTitle(text, fontName, size)
    self:setTitleText(text)
    self:setTitleFontName(fontName)
    self:setTitleFontSize(size)
end

--------------------------------
--  Create method of the game button
--  @function [parent=#GameButton] create
--  @param #string text Text key
--  @param #bool withBg Load background texture or not (Optional, default = true)
--  @param #float scale Scale of the button (Optional, default = 1x)
--  @return #core.GameButton Created game button
function GameButton.create(text, withBg, scale)
    local button = GameButton.new()
    --Set touch
    button:setTouchEnabled(true)
    
    if withBg == nil then
        withBg = true
    end
    
    --Load button data
    button:init(text, withBg)
    
    if scale then
        button:setScale(scale)
    end
    
    --Add cover layer
    local btnConfig = MetaManager.getBtnUI(text)
    if withBg and ((btnConfig and btnConfig.disabled and btnConfig.disabled == "normal") or not btnConfig) then
        local coverLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), 150, 60)
        coverLayer:setVisible(false)
        button.coverLayer = coverLayer
        button:addChild(coverLayer)
    end
    
    return button;
end

GameButton.ChangeTo = function (tbut, newbut)
        newbut:setAnchorPoint(tbut:getAnchorPoint())
        newbut:setPosition(tbut:getPosition())
        local name = tbut:getName()
        tbut:setName('.' .. name)
        tbut:getParent():addChild(newbut)
        tbut:setVisible(false)
        newbut:setName(name)
end

--------------------------------
--  Set enabled function of game button
--  @function [parent=#GameButton] setEnabled
--  @param self
--  @param #bool enabled Enable flag
function GameButton:setEnabled(enabled)
    ccui.Widget.setEnabled(self, enabled) --ccui.Button doesnt have a setEnabled method
    if self.coverLayer then
        self.coverLayer:setVisible(not enabled)
    end
end