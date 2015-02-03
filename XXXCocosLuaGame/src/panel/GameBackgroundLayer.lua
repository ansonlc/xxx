local GameBackGroundLayer = {}

--背景层
function GameBackGroundLayer.create()
    local backLayer = cc.Layer:create()

    local backSprite = cc.Sprite:create("imgs/game_bg.png")
    backSprite:setPosition(backSprite:getContentSize().width / 2, backSprite:getContentSize().height / 2)

    backLayer:addChild(backSprite)

    return backLayer
end

return GameBackGroundLayer