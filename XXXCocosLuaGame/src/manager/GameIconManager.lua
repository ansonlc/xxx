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
--  @param #int skillLvl Skill level number. Will not show when set nil
--  @return #cc.Sprite Created skill sprite, the skill information is in skillSprite.skill. The
--  size of skill sprite would be 170x170 with a 64x64 icon. The anchor point is 0,0
function GameIconManager.getSkillSprite(skillId, scale, borderAndBg, skillLvl)
    assert(skillId, "Nil skill id for getSkillSprite")
    
    --Read skill data from MetaManager
    local skillData = MetaManager.getSkill(skillId)
    --Construct skill sprite
    local skillSprite = cc.Sprite:create()
    skillSprite:setContentSize(170, 170)
    skillSprite:setAnchorPoint(0, 0)
    
    --Add border and background to sprite
    if (false) then
        local bg = cc.Sprite:create("res/imgs/item/border/bg" .. skillData.skillQuality .. ".png")
        bg:setPosition(85, 85)
        skillSprite:addChild(bg)
        skillSprite.bg = bg
    end
    
    --Add border to sprite
    if (borderAndBg) then
        local border = cc.Sprite:create("res/imgs/item/border/border"
            -- .. skillData.skillQuality
            .. ".png")
        border:setPosition(85, 85)
        skillSprite:addChild(border)
        skillSprite.border = border
    end
    
    --Add icon to sprite
    local skillIcon = cc.Sprite:create("res/imgs/SkillIcons/skill_" .. skillId .. ".png")
    skillIcon:setPosition(85, 85)
    if (not borderAndBg) then
        skillIcon:setScale(2)
    end
    skillSprite:addChild(skillIcon)
    skillSprite.skillIcon = skillIcon
   
    --Add skill level label
    if (skillLvl and skillLvl>0) then
        local lvlLbl = cc.LabelTTF:create("Lv. " .. (skillLvl<10 and "0" or "") .. skillLvl, "Arial", 25)
        lvlLbl:setPosition(120, 18)
        skillSprite.skillLevelLabel = lvlLbl
        skillSprite:addChild(lvlLbl)
        -- Add upgrade icon here
        local lvlUp = cc.Sprite:create("res/imgs/icon_levelup.png")
        lvlUp:setPosition(170, 0)
        lvlUp:setVisible(false)
        skillSprite.lvlUpSprite = lvlUp
        skillSprite:addChild(lvlUp)
    else
        if (skillLvl and skillLvl==0) then
            local newIcon = cc.Sprite:create("res/imgs/icon_new.png")
            newIcon:setPosition(170, 0)
            skillSprite:addChild(newIcon)
        end
    end
    
    --Provide a disabled cover for the pic
    local disableCover = cc.Sprite:create("res/imgs/item/border/black.png")
    disableCover:setPosition(85, 85)
    disableCover:setScale(170/128)
    disableCover:setOpacity(200)
    skillSprite:addChild(disableCover)
    disableCover:setVisible(false)
    -- Set disabled interface
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
--  Create method of item sprite
--  @function [parent=#GameIconManager] getItemSprite
--  @param #int itemId The skill id
--  @param #float scale Sprite scale
--  @param #bool borderAndBg Skill sprite border and background
--  @param #int itemAmount Item amount number. Will not show when set nil
--  @return #cc.Sprite Created skill sprite, the skill information is in skillSprite.skill. The
--  size of skill sprite would be 128x128 with a 64x64 icon. The anchor point is 0,0
function GameIconManager.getItemSprite(itemId, scale, borderAndBg, itemAmount)
    assert(itemId, "Nil skill id for getSkillSprite")

    --Read item data from MetaManager
    --local itemData = MetaManager.getSkill(itemId)
    --Construct skill sprite
    local itemSprite = cc.Sprite:create()
    itemSprite:setContentSize(128, 128)
    itemSprite:setAnchorPoint(0, 0)

    --Add border and background to sprite
    if (borderAndBg) then
        local bg = cc.Sprite:create("res/imgs/item/border/bg4.png")
        bg:setScale(128/130)
        bg:setPosition(64, 64)
        itemSprite:addChild(bg)
    end

    --Add icon to sprite
    local itemIcon = (itemId == 0)
        and cc.Sprite:create("res/imgs/item/crystal.png")
        or cc.Sprite:create("res/imgs/item/black.png")
    itemIcon:setPosition(64, 64)
    if (not borderAndBg) then
        itemIcon:setScale()
    end
    itemSprite:addChild(itemIcon)

    --Add border to sprite
    if (borderAndBg) then
        local border = cc.Sprite:create("res/imgs/item/border/border7.png")
        border:setScale(128/130)
        border:setPosition(64, 64)
        itemSprite:addChild(border)
    end

    --Add skill level label
    if (itemAmount) then
        local lvlLbl = cc.LabelTTF:create("x" .. (itemAmount>=100 and "" or (itemAmount>=10 and "0" or "00")) .. itemAmount, "Arial", 30)
        lvlLbl:setPosition(90, 20)
        itemSprite.skillLevelLabel = lvlLbl
        itemSprite:addChild(lvlLbl)
    end

    --Provide a disabled cover for the pic
    local disableCover = cc.Sprite:create("res/imgs/item/border/black.png")
    disableCover:setPosition(64, 64)
    disableCover:setOpacity(128)
    itemSprite:addChild(disableCover)
    disableCover:setVisible(false)
    itemSprite.setDisabled = function(self, flag)
        disableCover:setVisible(flag)
    end

    --Scale the sprite
    if (scale) then
        itemSprite:setScale(scale)
    end

    --Add skill meta data to skill sprite
    --itemSprite.item = itemData
    return itemSprite
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
    
    --[[if border then
        monsterSprite.border = cc.Sprite:create("res/imgs/monster/bgs/border.png")
        monsterSprite.border:setScale(470/400)
        monsterSprite.border:setAnchorPoint(0, 0)
        -- adjust the monster sprite size
        --monsterSprite:setScale(monsterSprite:getContentSize().width / 470, monsterSprite:getContentSize().height / 470)
        -- add as child
        monsterSprite:addChild(monsterSprite.border)
    end--]]
    
    if border then
        monsterSprite.border = cc.Sprite:create("res/imgs/monster/bgs/border.png")
        monsterSprite.border:setAnchorPoint(0,0)
        monsterSprite.border:setScaleX(monsterSprite:getContentSize().width / monsterSprite.border:getContentSize().width)
        monsterSprite.border:setScaleY(monsterSprite:getContentSize().height / monsterSprite.border:getContentSize().height)
        monsterSprite:addChild(monsterSprite.border)
    end
    
    if (scale) then
        monsterSprite:setScaleX(380 / monsterSprite:getContentSize().width)
        monsterSprite:setScaleY(380 / monsterSprite:getContentSize().height)
    end
    --monsterSprite.monster = MetaManager.getSkill(skillId)
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