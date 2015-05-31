--------------------------------------------------------------------------------
-- MessageBoxPanel.lua 
-- @author Chao Lin
--------------------------------------------------------------------------------

local MessageBoxPanel = {}

function MessageBoxPanel.create(parent,dataTable)
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local blackLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), visibleSize.width, visibleSize.height)
    local panel = cc.CSLoader:createNode("MessageBoxPanel.csb")
    panel:setName("MessageBoxPanel")
    panel:setPosition((visibleSize.width-panel:getContentSize().width)/2, (visibleSize.height-panel:getContentSize().height)/2)
    MessageBoxPanel.initBtn(parent,panel,blackLayer,dataTable)
    MessageBoxPanel.initText(parent,panel,dataTable)
    --panel:setVisible(false)
    blackLayer:addChild(panel)
    parent:addChild(blackLayer)
    return blackLayer
end

function MessageBoxPanel.initBtn(parent,panel,layer,dataTable)
    GameButton.ChangeTo(panel:getChildByName("btn_ok"), GameButton.create("Confirm", true))
    panel:getChildByName("btn_ok"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then             
            if dataTable.callback == nil then
                layer:setVisible(false)
            else
                local sequence = cc.Sequence:create({cc.CallFunc:create(dataTable.callback)})
                parent:runAction(sequence)    
                layer:setVisible(false)
            end 
        end
    end)
end

function MessageBoxPanel.initText(parent,panel,dataTable)
    local title = panel:getChildByName("txt_title")
    title:setString(dataTable.title)
    local msg = panel:getChildByName("txt_msg")
    msg:setString(dataTable.msg)
end

return MessageBoxPanel