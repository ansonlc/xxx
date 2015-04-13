require("config/CommonDefine")
local GameBackGroundLayer = {}
local visibleSize = cc.Director:getInstance():getVisibleSize()

--背景层
function GameBackGroundLayer.create()
    local backLayer = cc.Layer:create()
    
    -- Background of the GameScene
    local backSprite = cc.Sprite:create("res/imgs/GameScene/GameSceneBG.png")
    backSprite:setScale(visibleSize.width / backSprite:getContentSize().width, visibleSize.height / backSprite:getContentSize().height)
    backSprite:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    
    backLayer:addChild(backSprite)
    
    -- Tile-matching panel
    local tileMatchingPanel = cc.Sprite:create("res/imgs/GameScene/matching_panel.png")
    tileMatchingPanel:setAnchorPoint(0,0)
    tileMatchingPanel:setScale(visibleSize.width * GTileMatchingPanelHorizontalRatio / tileMatchingPanel:getContentSize().width, visibleSize.height * GTileMatchingPanelVerticalRatio / tileMatchingPanel:getContentSize().height)
    tileMatchingPanel:setPosition(visibleSize.width * GTileMatchingPanelHorizontalStartOffsetRatio, visibleSize.height * GTileMatchingPanelVerticalStartOffsetRatio)
    --tileMatchingPanel:setPosition(0, 0)
    backLayer:addChild(tileMatchingPanel)

    return backLayer
end

return GameBackGroundLayer