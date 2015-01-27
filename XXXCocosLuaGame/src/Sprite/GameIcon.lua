--------------------------------------------------------------------------------
-- GameIcon.lua - 游戏图标管理器
-- author: fangzhou.long
-- TODO 将本管理器包装成Manager类
--------------------------------------------------------------------------------

GIconNormalType = 1
GIconCryType = 2
GIconMatchType = 3
GIconSelectType = 4

--加载游戏图标资源
function loadGameIcon()
    local test = cc.SpriteFrameCache:getInstance()
    cclog("Cache size: "..test:getReferenceCount());
    cc.SpriteFrameCache:getInstance():addSpriteFrames("imgs/GameIcon.plist")
    cclog("Cache size: "..test:getReferenceCount());
end

--获取某个棋子
function getGameIconSprite(type, index)
    local test = cc.SpriteFrameCache:getInstance()
    local iconFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("icon"..type..index..".png")
    if iconFrame == nil then
        print("icon"..type..index..".png")
        print("iconFrame nil")
        return
    end
    local iconSprite = cc.Sprite:createWithSpriteFrame(iconFrame)
    return iconSprite
end

--创建随机变换的棋子
function createBlinkIconSprite()
    local animFrames = {}

    for i=1, GGameIconCount do
        local iconFrame = cc.SpriteFrameCache:getInstance():getSpriteFrame("icon4"..i..".png")
        table.insert(animFrames, iconFrame)
    end

    local iconSprite = getGameIconSprite(4, 1)

    local animation = cc.Animation:createWithSpriteFrames(animFrames, 0.1)
    local animate = cc.Animate:create(animation);

    iconSprite:runAction(cc.RepeatForever:create(animate))

    return iconSprite
end