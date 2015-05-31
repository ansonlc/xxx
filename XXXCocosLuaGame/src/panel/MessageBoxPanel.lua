--------------------------------------------------------------------------------
-- MessageBoxPanel.lua 
-- @author Chao Lin
--------------------------------------------------------------------------------

local MessageBoxPanel = {}

function MessageBoxPanel.create(parent,dataTable)
    local visibleSize = cc.Director:getInstance():getVisibleSize();
    local panel = cc.CSLoader:createNode("MessageBoxPanel.csb")
    panel:setName("MessageBoxPanel")
    panel:setPosition((visibleSize.width-panel:getContentSize().width)/2, (visibleSize.height-panel:getContentSize().height)/2)
    MessageBoxPanel.initBtn(parent,panel,dataTable)
    MessageBoxPanel.initText(parent,panel,dataTable)
    panel:setVisible(false)
    parent:addChild(panel)
    return panel
end

function MessageBoxPanel.initBtn(parent,panel,dataTable)
    GameButton.ChangeTo(panel:getChildByName("btn_ok"), GameButton.create("Confirm", true))
    panel:getChildByName("btn_ok"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then             
            if dataTable.callback == nil then
                panel:setVisible(false)
            else
                local sequence = cc.Sequence:create({cc.CallFunc:create(dataTable.callback)})
                parent:runAction(sequence)    
                panel:setVisible(false)
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