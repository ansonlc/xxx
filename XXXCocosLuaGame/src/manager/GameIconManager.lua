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
--  Create method of tile icon
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

--------------------------------
--  Create method of skill sprite
--  @function [parent=#GameIconManager] getSkillSprite
--  @param #int skillId The skill id
--  @param #float scale Sprite scale
--  @param #bool borderAndBg Skill sprite border and background
--  @papram #int skillLvl Skill level number. Will not show when set nil
--  @return #cc.Sprite Created skill sprite, the skill information is in skillSprite.skill. The
--  size of skill sprite would be 128x128 with a 64x64 icon.
function GameIconManager.getSkillSprite(skillId, scale, borderAndBg, skillLvl)
    assert(skillId, "Nil skill id for getSkillSprite")
    
    --Read skill data from MetaManager
    local skillData = MetaManager.getSkill(skillId)
    --Construct skill sprite
    local skillSprite = cc.Sprite:create()
    skillSprite:setContentSize(128, 128)
    skillSprite:setAnchorPoint(0, 0)
    
    --Add border and background to sprite
    if (borderAndBg) then
        local bg = cc.Sprite:create("res/imgs/item/border/bg" .. skillData.skillQuality .. ".png")
        bg:setScale(128/130)
        bg:setPosition(64, 64)
        skillSprite:addChild(bg)
    end
    
    --Add icon to sprite
    local skillIcon = cc.Sprite:create("res/imgs/temp/skill_" .. skillId .. ".png")
    skillIcon:setPosition(64, 64)
    if (not borderAndBg) then
        skillIcon:setScale(2)
    end
    skillSprite:addChild(skillIcon)
    
    --Add border to sprite
    if (borderAndBg) then
        local border = cc.Sprite:create("res/imgs/item/border/border" .. skillData.skillQuality .. ".png")
        border:setScale(128/130)
        border:setPosition(64, 64)
        skillSprite:addChild(border)
    end
    
    --Add skill level label
    if (skillLvl) then
        local lvlLbl = cc.LabelTTF:create("Lv. " .. skillLvl, "Arial", 30)
        lvlLbl:setPosition(80, 20)
        skillSprite.skillLevelLabel = lvlLbl
        skillSprite:addChild(lvlLbl)
    end
    
    --Provide a disabled cover for the pic
    local disableCover = cc.Sprite:create("res/imgs/item/border/black.png")
    disableCover:setPosition(64, 64)
    disableCover:setOpacity(128)
    skillSprite:addChild(disableCover)
    disableCover:setVisible(false)
    skillSprite.setDisabled = function(self, flag)
        disableCover:setVisible(flag)
    end
    
    --Scale the sprite
    if (scale) then
        skillSprite:setScale(scale)
    end
    
    --Add skill meta data to skill sprite
    skillSprite.skill = skillData
    return skillSprite
end

--------------------------------
--  Create method of monster sprite
--  @function [parent=#GameIconManager] getMonsterSprite
--  @param #int monsterId The monster id
--  @param #float scale Sprite scale
--  @param #bool border Monster sprite border
--  @return #cc.Sprite Created monster sprite, the monster information is in monsterSprite.monster
function GameIconManager.getMonsterSprite(monsterId, scale, border)
    assert(monsterId, "Nil monster id for getMonsterSpirte")
    
    local cacheInst = cc.SpriteFrameCache:getInstance()
    local monsterSprite = cc.Sprite:create("res/imgs/monster/" .. monsterId .. ".png")
    if (scale) then
        monsterSprite:setScale(scale)
    end
    monsterSprite.monster = MetaManager.getSkill(skillId)
    return monsterSprite
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