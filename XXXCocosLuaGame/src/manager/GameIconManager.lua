--------------------------------------------------------------------------------
-- GameIcon.lua - 游戏图标管理器
-- @author fangzhou.long
--------------------------------------------------------------------------------

--------------------------------
--  Game icons manager
-- @module manager.GameIconManager
GameIconManager = {}

GIconNormalType = 1
GIconCryType = 2
GIconMatchType = 3
GIconSelectType = 4

--------------------------------
--  Initialize tile sprite frame cache
-- @function [parent=#GameIconManager] loadTileIcons
function GameIconManager.loadTileIcons()
    local cacheInst = cc.SpriteFrameCache:getInstance()
    cacheInst:addSpriteFrames("imgs/GameIcon.plist")
end

--------------------------------
--  Create method of the scene, will be execute when called
--  @function [parent=#GameIconManager] getTileIconSprite
--  @param #int type Tile icon type(GIconNormalType, GIconCryType, GIconMatchType or GIconSelectType)
--  @param #int index Tile icon index
--  @return #cc.Sprite Created tile icon
function GameIconManager.getTileIconSprite(type, index)
    local cacheInst = cc.SpriteFrameCache:getInstance()
    local iconFrame = cacheInst:getSpriteFrame("icon"..type..index..".png")
    if iconFrame == nil then
        print("icon"..type..index..".png")
        print("iconFrame nil")
        return
    end
    local iconSprite = cc.Sprite:createWithSpriteFrame(iconFrame)
    iconSprite:setScale(150/88)
    return iconSprite
end

--创建随机变换的棋子
--[[
function GameIconManager.createBlinkIconSprite()
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
--]]