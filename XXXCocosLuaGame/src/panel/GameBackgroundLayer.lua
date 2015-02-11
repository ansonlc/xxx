local GameBackGroundLayer = {}
local visibleSize = cc.Director:getInstance():getVisibleSize()

--背景层
function GameBackGroundLayer.create()
    local backLayer = cc.Layer:create()
    
    local backSprite = cc.Sprite:create("imgs/game_bg.png")
    backSprite:setScale(visibleSize.width / backSprite:getContentSize().width, visibleSize.height / backSprite:getContentSize().height)
    backSprite:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    
    backLayer:addChild(backSprite)

    return backLayer
end

return GameBackGroundLayer