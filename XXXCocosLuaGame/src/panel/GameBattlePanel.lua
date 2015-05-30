--------------------------------------------------------------------------------
-- GameBattlePanel.lua 
-- @author Chicheng Ren
--------------------------------------------------------------------------------

local parentNode

local GameBattlePanel = class("GameBattlePanel", function() return cc.Layer:create() end)

local visibleSize = cc.Director:getInstance():getVisibleSize()

---
-- Create the instance for the GameBattelPanel 
-- and set the position of this panel
-- @function [parent=#panel.GameBattlePanel] create
function GameBattlePanel.create(parent)
    parentNode = parent
    local panel = GameBattlePanel.new()
    -- initialize the panel
    panel:initPanel()
    return panel
end

---
--  Initilization of the GameBattelPanel
--@function [parent=#panel.GameBattlePanel] initPanel

function GameBattlePanel:initPanel()
    -- initialization of the panel position
    self:setAnchorPoint(0,0)
    self:setPosition(0, visibleSize.height * GBattlePanelVerticalStartOffsetRatio)

    -- Debug layer
    --[[local debugColor = cc.c4b(255, 255, 255, 100)
    local debugLayer = cc.LayerColor:create(debugColor)

    debugLayer:changeWidthAndHeight(visibleSize.width,visibleSize.height * GBattlePanelVerticalRatio)
    debugLayer:setAnchorPoint(0,0)
    debugLayer:setPosition(0,0)

    self:addChild(debugLayer)--]]

    -- Create the BackgroundLayer
    local backgroundColor = cc.c4b(255, 255, 255, 255)
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)   -- 20% of the screen's height
    --self:addChild(backgroundLayer)
    
    -- HP Bar Frame
    local hpBarFrameSpriteDown = cc.Sprite:create("res/imgs/GameScene/player_health_bar_down.png")
    hpBarFrameSpriteDown:setAnchorPoint(0,0)
    hpBarFrameSpriteDown:setPosition(visibleSize.width * GBattleHPBarFrameHorizontalStartOffsetRatio, visibleSize.height * GBattleHPBarFrameVerticalStartOffsetRatio)
    hpBarFrameSpriteDown:setScaleX(visibleSize.width * GBattleHPBarFrameHorizontalRatio / hpBarFrameSpriteDown:getContentSize().width)
    hpBarFrameSpriteDown:setScaleY(visibleSize.height * GBattleHPBarFrameVerticalRatio / hpBarFrameSpriteDown:getContentSize().height)
    self:addChild(hpBarFrameSpriteDown)

    -- HP Bar
    local hpBarSprite = cc.Sprite:create("res/imgs/GameScene/player_health_bar.png")
    hpBarSprite:setAnchorPoint(0,0)
    hpBarSprite:setPosition(visibleSize.width * GBattleHPBarHorizontalStartOffsetRatio, visibleSize.height * GBattleHPBarVerticalStartOffsetRatio)
    hpBarSprite:setScaleX(visibleSize.width * GBattleHPBarHorizontalRatio / hpBarSprite:getContentSize().width)
    hpBarSprite:setScaleY(visibleSize.height * GBattleHPBarVerticalRatio / hpBarSprite:getContentSize().height)

    self.hpBarSpriteFullRatio = visibleSize.width * GBattleHPBarHorizontalRatio / hpBarSprite:getContentSize().width
    self.hpBarSprite = hpBarSprite
    self:addChild(self.hpBarSprite)
    
    -- Shell Bar
    local shellBarSprite = cc.Sprite:create("res/imgs/GameScene/player_shell_bar.png")
    shellBarSprite:setAnchorPoint(0,0)
    shellBarSprite:setPosition(visibleSize.width * GBattleHPBarHorizontalStartOffsetRatio, visibleSize.height * GBattleHPBarVerticalStartOffsetRatio)
    shellBarSprite:setScaleX(0)
    shellBarSprite:setScaleY(visibleSize.height * GBattleHPBarVerticalRatio / shellBarSprite:getContentSize().height)

    self.shellBarSpriteFullRatio = visibleSize.width * GBattleHPBarHorizontalRatio / shellBarSprite:getContentSize().width
    self.shellBarSprite = shellBarSprite
    self:addChild(self.shellBarSprite)
    
    -- HP Bar Frame
    local hpBarFrameSpriteUp = cc.Sprite:create("res/imgs/GameScene/player_health_bar_up.png")
    hpBarFrameSpriteUp:setAnchorPoint(0,0)
    hpBarFrameSpriteUp:setPosition(visibleSize.width * GBattleHPBarFrameHorizontalStartOffsetRatio, visibleSize.height * GBattleHPBarFrameVerticalStartOffsetRatio)
    hpBarFrameSpriteUp:setScaleX(visibleSize.width * GBattleHPBarFrameHorizontalRatio / hpBarFrameSpriteUp:getContentSize().width)
    hpBarFrameSpriteUp:setScaleY(visibleSize.height * GBattleHPBarFrameVerticalRatio / hpBarFrameSpriteUp:getContentSize().height)
    self:addChild(hpBarFrameSpriteUp)

    -- Battle Field
    --[[local battleFieldColor = cc.c4b(0, 0, 255, 80)
    local battleFieldLayer = cc.LayerColor:create(battleFieldColor)

    battleFieldLayer:changeWidthAndHeight(visibleSize.width * GBattleFieldHorizontalRatio, visibleSize.height * GBattleFieldVerticalRatio)
    battleFieldLayer:setAnchorPoint(0,0)
    battleFieldLayer:setPosition(visibleSize.width * GBattleFieldHorizontalStartOffsetRatio,visibleSize.height * GBattleFieldVerticalStartOffsetRatio)

    self:addChild(battleFieldLayer)--]]
    local battleFieldBackground = cc.Sprite:create("res/imgs/GameScene/battle_panel.png")
    
    battleFieldBackground:setScale(visibleSize.width * GBattleFieldHorizontalRatio / battleFieldBackground:getContentSize().width, visibleSize.height * GBattleFieldVerticalRatio / battleFieldBackground:getContentSize().height)
    battleFieldBackground:setAnchorPoint(0,0)
    battleFieldBackground:setPosition(visibleSize.width * GBattleFieldHorizontalStartOffsetRatio,visibleSize.height * GBattleFieldVerticalStartOffsetRatio)
    
    self:addChild(battleFieldBackground)
    
    -- Rune Block
    local runeBlockColor = cc.c4b(100, 100, 0, 0)
    local runeBlockLayer = cc.LayerColor:create(runeBlockColor)

    runeBlockLayer:changeWidthAndHeight(visibleSize.width * GBattleRuneBlockHorizontalRatio, visibleSize.height * GBattleRuneBlockVerticalRatio)
    runeBlockLayer:setAnchorPoint(0,0)
    runeBlockLayer:setPosition(visibleSize.width * GBattleRuneBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleRuneBlockVerticalStartOffsetRatio)

    self.runeBlock = runeBlockLayer
    self:addChild(runeBlockLayer)
    
    -- Crystal Block
    local crystalBlockSprite = cc.Sprite:create("res/imgs/GameScene/CrystalLabel.png")
    
    crystalBlockSprite:setScale(visibleSize.width * GBattleCrystalBlockHorizontalRatio / crystalBlockSprite:getContentSize().width, visibleSize.height * GBattleCrystalBlockVerticalRatio / crystalBlockSprite:getContentSize().height)
    crystalBlockSprite:setAnchorPoint(0,0)
    crystalBlockSprite:setPosition(visibleSize.width * GBattleCrystalBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleCrystalBlockVerticalStartOffsetRatio)
    
    self:addChild(crystalBlockSprite)
    
    -- Crystal Text Block
    local crystalTextBlock = cc.LabelTTF:create("10", "Arial", 80)
    
    crystalTextBlock:setScale(visibleSize.width * GBattleCrystalTextHorizontalRatio / crystalTextBlock:getContentSize().width, visibleSize.height * GBattleCrystalTextVerticalRatio / crystalTextBlock:getContentSize().height)
    crystalTextBlock:setAnchorPoint(0,0)
    crystalTextBlock:setPosition(visibleSize.width * GBattleCrystalTextHorizontalStartOffsetRatio, visibleSize.height * GBattleCrystalTextVerticalStartOffsetRatio)
    
    self.crystalText = crystalTextBlock
    self:addChild(crystalTextBlock)

    -- Level Block
    --local levelSprite = cc.Sprite:create("imgs/GameScene/level_1.png")
    local levelSprite = cc.Sprite:create("imgs/GameScene/level_"..DataManager.userInfo.currentLevelID..".png")
    levelSprite:setScaleX(visibleSize.width * GBattleLevelBlockHorizontalRatio / levelSprite:getContentSize().width)
    levelSprite:setScaleY(visibleSize.height * GBattleLevelBlockVerticalRatio / levelSprite:getContentSize().height)
    levelSprite:setAnchorPoint(0,0)
    levelSprite:setPosition(visibleSize.width * GBattleLevelBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleLevelBlockVerticalStartOffsetRatio)

    self:addChild(levelSprite)

    -- Option Block
    local optionSprite = GameButton.create("OptionBtn", true , 0.5)
    optionSprite.onScreenX = visibleSize.width * GBattleOptionBlockHorizontalStartOffset
    optionSprite.onScreenY = visibleSize.height * GBattleOptionBlockVerticalStartOffset

    optionSprite:setPosition(optionSprite.onScreenX, optionSprite.onScreenY)

    self.optionButton = optionSprite
    self:addChild(optionSprite)

    local toggleSprite = cc.Sprite:create("imgs/temp/toggle_button.png")

    toggleSprite.onScreenWidth = visibleSize.width * GBattleToggleBlockHorizontalRatio 
    toggleSprite.onScreenHeight = visibleSize.height * GBattleToggleBlockVerticalRatio
    toggleSprite.onScreenX = visibleSize.width * GBattleToggleBlockHorizontalStartOffset
    toggleSprite.onScreenY = visibleSize.height * GBattleToggleBlockVerticalStartOffset

    toggleSprite:setScaleX(toggleSprite.onScreenWidth / toggleSprite:getContentSize().width)
    toggleSprite:setScaleY(toggleSprite.onScreenHeight / toggleSprite:getContentSize().height)
    toggleSprite:setAnchorPoint(0,0)
    toggleSprite:setPosition(toggleSprite.onScreenX, toggleSprite.onScreenY) 

    self.toggleButton = toggleSprite
    self.toggleButton:setVisible(false)
    self:addChild(toggleSprite)

    -- Monster Block
    local monsterBlockColor = cc.c4b(100, 100, 0, 0)
    local monsterBlockLayer = cc.LayerColor:create(monsterBlockColor)

    monsterBlockLayer:changeWidthAndHeight(visibleSize.width * GBattleMonsterBlockHorizontalRatio, visibleSize.height * GBattleMonsterBlockVerticalRatio)
    monsterBlockLayer:setAnchorPoint(0,0)
    monsterBlockLayer:setPosition(visibleSize.width * GBattleMonsterBlockHorizontalStartOffsetRatio,visibleSize.height * GBattleMonsterBlockVerticalStartOffsetRatio)
    
    self:addChild(monsterBlockLayer)

    local picture = MetaManager.getMonster(DataManager.userInfo.currentMonsterID).picture
    
    local monsterSprite = nil
    if picture[1] == nil then
        monsterSprite = GameIconManager.getMonsterSprite(  picture, 1, false)
    else
        monsterSprite = GameIconManager.getMonsterSprite(  picture[1], picture[2], false)    
    end

    
    monsterSprite:setAnchorPoint(0.5,0.5)
    monsterSprite:setPosition(visibleSize.width * GBattleMonsterBlockHorizontalStartOffsetRatio + 0.5*visibleSize.width * GBattleMonsterBlockHorizontalRatio,visibleSize.height * GBattleMonsterBlockVerticalStartOffsetRatio + 0.5 * visibleSize.height * GBattleMonsterBlockVerticalRatio)
    monsterSprite:setScale(visibleSize.width * GBattleMonsterBlockHorizontalRatio / monsterSprite:getContentSize().width, visibleSize.height * GBattleMonsterBlockVerticalRatio / monsterSprite:getContentSize().height)
    monsterSprite:setName("MonsterNode")
    self.monsterSprite = monsterSprite
    self:addChild(monsterSprite)
    
    -- Monster HP Bar Frame
    local monsterHPBarFrameSpriteDown = cc.Sprite:create("res/imgs/GameScene/player_health_bar_down.png")
    monsterHPBarFrameSpriteDown:setAnchorPoint(0,0)
    monsterHPBarFrameSpriteDown:setPosition(visibleSize.width * GBattleMonsterHPBarFrameHorizontalStartOffsetRatio, visibleSize.height * GBattleMonsterHPBarFrameVerticalStartOffsetRatio)
    monsterHPBarFrameSpriteDown:setScaleX(visibleSize.width * GBattleMonsterHPBarFrameHorizontalRatio / monsterHPBarFrameSpriteDown:getContentSize().width)
    monsterHPBarFrameSpriteDown:setScaleY(visibleSize.height * GBattleMonsterHPBarFrameVerticalRatio / monsterHPBarFrameSpriteDown:getContentSize().height)
    self:addChild(monsterHPBarFrameSpriteDown)
    
    -- Monster HP Bar
    local monsterHPSprite = cc.Sprite:create("res/imgs/GameScene/player_health_bar.png")
    monsterHPSprite:setAnchorPoint(0,0)
    monsterHPSprite:setPosition(visibleSize.width * GBattleMonsterHPBarHorizontalStartOffsetRatio, visibleSize.height * GBattleMonsterHPBarVerticalStartOffsetRatio)
    monsterHPSprite:setScale(visibleSize.width * GBattleMonsterHPBarHorizontalRatio / monsterHPSprite:getContentSize().width, visibleSize.height * GBattleMonsterHPBarVerticalRatio / monsterHPSprite:getContentSize().height)
    self.monsterHPBar = monsterHPSprite
    self.monsterHPBarFullRatio = visibleSize.width * GBattleMonsterHPBarHorizontalRatio / monsterHPSprite:getContentSize().width
    self:addChild(monsterHPSprite)
    
    -- Monster HP Bar Frame
    local monsterHPBarFrameSpriteUP = cc.Sprite:create("res/imgs/GameScene/player_health_bar_up.png")
    monsterHPBarFrameSpriteUP:setAnchorPoint(0,0)
    monsterHPBarFrameSpriteUP:setPosition(visibleSize.width * GBattleMonsterHPBarFrameHorizontalStartOffsetRatio, visibleSize.height * GBattleMonsterHPBarFrameVerticalStartOffsetRatio)
    monsterHPBarFrameSpriteUP:setScaleX(visibleSize.width * GBattleMonsterHPBarFrameHorizontalRatio / monsterHPBarFrameSpriteUP:getContentSize().width)
    monsterHPBarFrameSpriteUP:setScaleY(visibleSize.height * GBattleMonsterHPBarFrameVerticalRatio / monsterHPBarFrameSpriteUP:getContentSize().height)
    self:addChild(monsterHPBarFrameSpriteUP)
    

    -- Player Effect Block
    --[[local playerEffectBlockLayer = cc.LayerColor:create(cc.c4b(100,100,0,100))
    playerEffectBlockLayer:setAnchorPoint(0,0)
    playerEffectBlockLayer:setPosition(visibleSize.width * GBattlePlayerEffectBlockHorizontalStartOffsetRatio, visibleSize.height * GBattlePlayerEffectBlockVerticalStartOffsetRatio)
    playerEffectBlockLayer:changeWidthAndHeight(visibleSize.width * GBattlePlayerEffectBlockHorizontalRatio,visibleSize.height * GBattlePlayerEffectBlockVerticalRatio)
    self.playerEffectBlockLayer = playerEffectBlockLayer
    self:addChild(playerEffectBlockLayer)--]]
    
    local playerEffectBlock = cc.Sprite:create("res/imgs/GameScene/player_buff_panel.png")
    playerEffectBlock:setAnchorPoint(0.0, 0.0)
    playerEffectBlock:setPosition(visibleSize.width * GBattlePlayerEffectBlockHorizontalStartOffsetRatio, visibleSize.height * GBattlePlayerEffectBlockVerticalStartOffsetRatio)
    playerEffectBlock:setScale(visibleSize.width * GBattlePlayerEffectBlockHorizontalRatio / playerEffectBlock:getContentSize().width, visibleSize.height * GBattlePlayerEffectBlockVerticalRatio / playerEffectBlock:getContentSize().height)
    self.playerEffectBlockLayer = playerEffectBlock
    self:addChild(playerEffectBlock)

    self.playerEffectBlockIndex = 1     -- this index points to the current location where the effect should be added
    self.playerEffectTable = {}

    -- Monster Effect Block
    --[[local monsterEffectBlockLayer = cc.LayerColor:create(cc.c4b(100,100,0,100))
    monsterEffectBlockLayer:setAnchorPoint(0,0)
    monsterEffectBlockLayer:setPosition(visibleSize.width * GBattleMonsterEffectBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleMonsterEffectBlockVerticalStartOffsetRatio)
    monsterEffectBlockLayer:changeWidthAndHeight(visibleSize.width * GBattleMonsterEffectBlockHorizontalRatio,visibleSize.height * GBattleMonsterEffectBlockVerticalRatio)
    self.monsterEffectBlockLayer = monsterEffectBlockLayer--]]
    local monsterEffectBlock = cc.Sprite:create("imgs/GameScene/monster_buff_panel.png")
    monsterEffectBlock:setAnchorPoint(0,0)
    monsterEffectBlock:setPosition(visibleSize.width * GBattleMonsterEffectBlockHorizontalStartOffsetRatio, visibleSize.height * GBattleMonsterEffectBlockVerticalStartOffsetRatio)
    monsterEffectBlock:setScale(visibleSize.width * GBattleMonsterEffectBlockHorizontalRatio / monsterEffectBlock:getContentSize().width, visibleSize.height * GBattleMonsterEffectBlockVerticalRatio / monsterEffectBlock:getContentSize().height)
    self.monsterEffectBlockLayer = monsterEffectBlock

    self:addChild(monsterEffectBlock)
    self.monsterEffectBlockIndex = 1
    self.monsterEffectTable = {}

    -- Initialization for the Rune Block
    self:initRuneBlock()

    -- test for the scene change
    local function onTouch(eventType, x, y)
        --print(x .. " " .. y)
        if not parentNode.touchEnabled then return true end
        --if x >= self.optionButton.onScreenX and x <= (self.optionButton.onScreenX + self.optionButton.onScreenWidth) and y >= (self.optionButton.onScreenY + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) and y <= (self.optionButton.onScreenY + self.optionButton.onScreenHeight + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) then
            --SoundManager.playBGM('menu')
            --SceneManager.replaceSceneWithName("LevelSelectScene","Test")
            parentNode.settingPanel.managePanel:setVisible(true)
            --parentNode.touchEnabled = false
            parentNode:setGameTouch(false)
        --end

        --if x >= self.toggleButton.onScreenX and x <= (self.toggleButton.onScreenX + self.toggleButton.onScreenWidth) and y >= (self.toggleButton.onScreenY + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) and y <= (self.toggleButton.onScreenY + self.toggleButton.onScreenHeight + visibleSize.height * GBattlePanelVerticalStartOffsetRatio) then
            -- For Test Purpose
            --[[local AINode = self:getParent():getChildByName("MonsterAILogic")
            AINode.isAIOn = not AINode.isAIOn
            if AINode.isAIOn then
                cclog("Current AI Status: On")
            else
                cclog("Current AI Status: Off")
            end
            self:getParent():onGameOver(true, nil)--]]
        --end
        return true
    end

    self.optionButton:addTouchEventListener(onTouch)
    self.optionButton:setTouchEnabled(true)

end

---
-- Initialization for the rune block (Create the icon and text for this block)
-- @function [parent=#panel.GameBattlePanel] initRuneBlock
function GameBattlePanel:initRuneBlock()
    -- Rune Icons
    -- Current all the Runes Sprites are the children of the RuneBlock in this panel
    -- Fire Rune
    local fireRuneSprite = cc.Sprite:create("res/imgs/GameScene/rune_fire_label.png")
    fireRuneSprite:setAnchorPoint(0,0)
    fireRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    fireRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneFireVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(fireRuneSprite)

    -- Water Rune
    local waterRuneSprite = cc.Sprite:create("res/imgs/GameScene/rune_water_label.png")
    waterRuneSprite:setAnchorPoint(0,0)
    waterRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    waterRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneWaterVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(waterRuneSprite)

    -- Earth Rune
    local earthRuneSprite = cc.Sprite:create("res/imgs/GameScene/rune_earth_label.png")
    earthRuneSprite:setAnchorPoint(0,0)
    earthRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    earthRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneEarthVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(earthRuneSprite)

    -- Air Rune
    local airRuneSprite = cc.Sprite:create("res/imgs/GameScene/rune_air_label.png")
    airRuneSprite:setAnchorPoint(0,0)
    airRuneSprite:setScale(GBattleRuneIdelWidthRatio * visibleSize.width / fireRuneSprite:getContentSize().width, GBattleRuneIdelHeightRatio * visibleSize.height / fireRuneSprite:getContentSize().height)
    airRuneSprite:setPosition(GBattleRuneIdelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneAirVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock:addChild(airRuneSprite)

    -- Rune Text
    -- Fire Rune Text
    local fireRuneText = cc.LabelTTF:create("10", "Arial", 80)
    fireRuneText:setAnchorPoint(0,0)
    fireRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / fireRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / fireRuneText:getContentSize().height)
    fireRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneFireTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.fireRune = fireRuneText
    self.runeBlock:addChild(fireRuneText)

    -- Water Rune Text
    local waterRuneText = cc.LabelTTF:create("10", "Arial", 80)
    waterRuneText:setAnchorPoint(0,0)
    waterRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / waterRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / waterRuneText:getContentSize().height)
    waterRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneWaterTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.waterRune = waterRuneText
    self.runeBlock:addChild(waterRuneText)

    -- Earth Rune Text
    local earthRuneText = cc.LabelTTF:create("10", "Arial", 80)
    earthRuneText:setAnchorPoint(0,0)
    earthRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / earthRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / earthRuneText:getContentSize().height)
    earthRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneEarthTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.earthRune = earthRuneText
    self.runeBlock:addChild(earthRuneText)

    -- Air Rune Text
    local airRuneText = cc.LabelTTF:create("10", "Arial", 80)
    airRuneText:setAnchorPoint(0,0)
    airRuneText:setScale(GBattleRuneTextLabelIdelWidthRatio * visibleSize.width / airRuneText:getContentSize().width, GBattleRuneTextLabelIdelHeightRatio * visibleSize.height / airRuneText:getContentSize().height)
    airRuneText:setPosition(GBattleRuneTextLabelHorizontalStartOffsetRatio * visibleSize.width, GBattleRuneAirTextLabelVerticalStartOffsetRatio * visibleSize.height)
    self.runeBlock.airRune = airRuneText
    self.runeBlock:addChild(airRuneText)
    
    -- Calculate the global position for all the runes
    self.runePositionTable = {}
    local runeBlockPosY = visibleSize.height * (GBattlePanelVerticalStartOffsetRatio + GBattleRuneBlockVerticalStartOffsetRatio)
    local runeBlockPosX = visibleSize.width * (GBattleRuneBlockHorizontalStartOffsetRatio)
    local runeIdelHeight = visibleSize.height * GBattleRuneIdelHeightRatio / 2
    local runePosX = runeBlockPosX + visibleSize.width * GBattleRuneIdelWidthRatio / 2
    local runePosY = runeBlockPosY + runeIdelHeight
    
    self.runePositionTable['Fire'] = {x = runePosX, y = runePosY + visibleSize.height * GBattleRuneFireVerticalStartOffsetRatio}
    self.runePositionTable['Water'] = {x = runePosX, y = runePosY + visibleSize.height * GBattleRuneWaterVerticalStartOffsetRatio}
    self.runePositionTable['Earth'] = {x = runePosX, y = runePosY + visibleSize.height * GBattleRuneEarthVerticalStartOffsetRatio}
    self.runePositionTable['Air'] = {x = runePosX, y = runePosY + visibleSize.height * GBattleRuneAirVerticalStartOffsetRatio}

    --[[local fire = self:getRunePosition('Fire')
    local water = self:getRunePosition('Water')
    local earth = self:getRunePosition('Earth')
    local air = self:getRunePosition('Air')--]]
    
end

---
-- Update the rune number according to the current runes table
-- @function [parent=#panel.GameBattlePanel] updateRuneNum
-- @param runesTable table runes table passed from the logic node
function GameBattlePanel:updateRuneNum(runesTable)
    assert(runesTable, "Nil input in the function: GameBattlePanel:updateRuneNum")
    self.runeBlock.airRune:setString(runesTable.air)
    self.runeBlock.earthRune:setString(runesTable.earth)
    self.runeBlock.waterRune:setString(runesTable.water)
    self.runeBlock.fireRune:setString(runesTable.fire)
end

---
--  Update the crystal number according to the current crystal number
--  @function [parent=#panel.GameBattlePanel] updateCrystalNum
--  @param num number number of crystal  
function GameBattlePanel:updateCrystalNum(num)
    self.crystalText:setString(num)
end

---
-- Play animation according to the players skill
function GameBattlePanel:playerPlayAnimation(name)
    
end

function GameBattlePanel:playerShellActivated(ratio)
    --self.shellBarSprite:setScaleX(visibleSize.width * GBattleHPBarHorizontalRatio * ratio / self.shellBarSprite:getContentSize().width)
    -- Animation
    local scaleAction = cc.ScaleTo:create(0.5, ratio * self.shellBarSpriteFullRatio, self.shellBarSprite:getScaleY())
    self.shellBarSprite:runAction(scaleAction)
end

---
--  The shell of the monster absorb the damage from the player
--  @function [parent=#panel.GameBattlePanel] monsterShellAbsorbed
function GameBattlePanel:monsterShellAbsorbed()
    -- TODO: animation needs to be modified
    if self.shieldText == nil then
        self.shieldText = cc.LabelTTF:create("Absorbed", "Arial", 80)
        self:addChild(self.shieldText)
    end

    -- Animation
    local fadeInAction = cc.FadeIn:create(0.3)
    local fadeOutAction = cc.FadeOut:create(0.3)
    local actionSeqTable = {fadeInAction, fadeOutAction}
    local actionSeq = cc.Sequence:create(actionSeqTable)
    self.shieldText:setAnchorPoint(0,0)
    self.shieldText:setPosition(400, 150)
    self.shieldText:runAction(actionSeq)
end

---
--  Show the Animaiton of the decrease of the player shell
--  @function [parent=#panel.GameBattlePanel] playerShellAbsorbed
--  @param currentShellEnergy num current Shell Energy
--  @param absorbedDamage num absorbed damage
function GameBattlePanel:playerShellAbsorbed(ratio)
    local scaleAction = cc.ScaleTo:create(0.5, ratio * self.shellBarSpriteFullRatio, self.shellBarSprite:getScaleY())
    --[[if currentShellEnergy == 0 then
    scaleAction = cc.ScaleTo:create(0.5, 0, self.shellBarSprite:getScaleY())
    else
    local scaleRatio = currentShellEnergy / (currentShellEnergy + absorbedDamage)
    scaleAction = cc.ScaleBy:create(0.5, scaleRatio, 1)
    end--]]
    self.shellBarSprite:runAction(scaleAction)
end

---
-- Show the damage info for the monster
-- @function [parent=#panel.GameBattlePanel] doDamageToMonster
-- @param damageValue The damage hit on the monster
function GameBattlePanel:doDamageToMonster(damageValue,ratio)
    assert(damageValue, "Nil input in function: GameBattlePanel:doDamageToMonster()")
    if self.damageText == nil then
        if damageValue >= 0 then
            self.damageText = cc.LabelTTF:create("-"..damageValue, "Arial", 150)
        else
            self.damageText = cc.LabelTTF:create("+"..math.abs(damageValue), "Arial", 150)
        end
        self.damageText:setName("DamageTextNode") 
        self:addChild(self.damageText)
    else
        if damageValue >= 0 then
            self.damageText:setString("-"..damageValue)
        else
            self.damageText:setString("+"..math.abs(damageValue))
        end
    end
    local fadeInAction = cc.FadeIn:create(0.1)
    local fadeOutAction = cc.FadeOut:create(0.3)
    --local fadeSpawn = cc.Spawn:create(fadeInAction, fadeOutAction)
    local moveToAction = cc.MoveBy:create(0.3, cc.p(200, -200))
    local actionSeqTable = {fadeInAction, fadeOutAction}
    --local actionSeqTable = {fadeSpawn, moveToAction};
    local actionSeq = cc.Sequence:create(actionSeqTable)
    self.damageText:setAnchorPoint(0,0)
    self.damageText:setPosition(500, 150)
    self.damageText:runAction(actionSeq)
    self.damageText:runAction(moveToAction)
    
    -- Play the attack animation
    local attackFlipbook = AnimationManager.create("Attack1")
    attackFlipbook:setPosition(540, 300)
    attackFlipbook:setScale(2)
    self:addChild(attackFlipbook)
    attackFlipbook:runAnimation()
    
    -- scale the monster hp bar
    if ratio < 0.0 then
        ratio = 0.0
    end
    local scaleAction = cc.ScaleTo:create(0.5, ratio * self.monsterHPBarFullRatio, self.monsterHPBar:getScaleY())
    self.monsterHPBar:runAction(scaleAction)
end

---
--  Show the damage info for the player
--  @function [parent=#panel.GameBattlePanel] doDamageToPlayer
--  @param self
--  @param ratio
function GameBattlePanel:doDamageToPlayer(ratio)
    if ratio < 0.0 then
        ratio = 0.0
    end
    local scaleAction = cc.ScaleTo:create(0.5,ratio * self.hpBarSpriteFullRatio,self.hpBarSprite:getScaleY())   
    self.hpBarSprite:runAction(scaleAction) 
end

---
-- Remove the buff or debuff on the player
-- @function [parent=#panel.GameBattlePanel] removeEffectOnPlayer
-- @param effect 
function GameBattlePanel:removeEffectOnPlayer(effect)
    if effect.effectType == 'Purify' then
        for i = 1, GBattleMaxEffectNumber, 1 do
            if self.playerEffectTable[i] ~= nil then
                local test = self.playerEffectTable[i].effectType
                if self.playerEffectTable[i].effectType == 'Bleed' or self.playerEffectTable[i].effectType == 'Fear' or self.playerEffectTable[i].effectType == 'Curse' then
                    self.playerEffectTable[i].effectTimeCount = self.playerEffectTable[i].effectTimeToLive   -- waiting for the next update to remove this effect
                end
            end
        end
    elseif effect.effectType == 'Disperse' then
        for i = 1, GBattleMaxEffectNumber, 1 do
            if self.monsterEffectTable[i] ~= nil then
                if self.monsterEffectTable[i].effectType == 'Bravery' or self.monsterEffectTable[i].effectType == 'Recovery' then
                    self.monsterEffectTable[i].effectTimeCount = self.monsterEffectTable[i].effectTimeToLive   -- waiting for the next update to remove this effect
                end              
            end
        end
    end
end

---
-- Display the animation to heal the player
-- @function [parent=#panel.GameBattlePanel] healPlayer
-- @param currentPlayerHP num current player HP
-- @param heal num heal value
function GameBattlePanel:healPlayer(ratio)
    local scaleAction = cc.ScaleTo:create(0.5, ratio * self.hpBarSpriteFullRatio, self.hpBarSprite:getScaleY())
    self.hpBarSprite:runAction(scaleAction)
end

function GameBattlePanel:healMonster(ratio)
    local scaleAction = cc.ScaleTo:create(0.5, ratio * self.monsterHPBarFullRatio, self.monsterHPBar:getScaleY())
    self.monsterHPBar:runAction(scaleAction)
end

function GameBattlePanel:getMonsterNode()
    return self.monsterSprite
end

---
-- Show the animation when the mosnter use the skill
-- @function [parent=#panel.GameBattlePanel] monsterUseSkill
-- @param skill
function GameBattlePanel:monsterUseSkill(skill)
    -- TODO: apply the skill effect
    local scale1 = cc.ScaleBy:create(0.2, 1.25, 1.25, 1.25)
    local scale2 = cc.ScaleBy:create(0.2, 0.8, 0.8, 0.8)
    local actionSeqTable = {scale1, scale2}
    local actionSeq = cc.Sequence:create(actionSeqTable)
    local monsterNode = self:getChildByName("MonsterNode")
    assert(monsterNode)
    monsterNode:runAction(actionSeq)
end

function GameBattlePanel:playerAddEffect(effect)
    -- First detect if this effect has existed in the table
    local index = nil
    for k,v in pairs(self.playerEffectTable) do
        cclog("Type: "..v.effectType)
        if v.effectType == effect.effectType then
            index = v.index
            break
        end
    end

    if index == nil then
        -- This effect has not been added to the table
        local effectSprite = cc.Sprite:create("imgs/BuffDebuff/effect_"..effect.effectType:lower()..'.png')
        effectSprite.index = self.playerEffectBlockIndex
        effectSprite.effectType = effect.effectType
        effectSprite.effectTimeCount = 0
        effectSprite.effectTimeToLive = effect.effectTimeToLive
        effectSprite:setAnchorPoint(0,0)
        -- Adjust the position
        if self.playerEffectBlockIndex <= 3 then
            effectSprite.onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * self.playerEffectBlockIndex + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.playerEffectBlockIndex - 1)
            effectSprite.onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio
        else
            effectSprite.onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * (self.playerEffectBlockIndex - GBattleMaxEffectInRow) + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.playerEffectBlockIndex - 1 - GBattleMaxEffectInRow)
            effectSprite.onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio * 2 + visibleSize.height * GBattleEffectIconVerticalRatio 
        end
        effectSprite:setPosition(effectSprite.onScreenX, effectSprite.onScreenY)
        -- Adjust the size
        effectSprite.onScreenWidth = visibleSize.width * GBattleEffectIconHorizontalRatio 
        effectSprite.onScreenHeight = visibleSize.height * GBattleEffectIconVerticalRatio 
        effectSprite:setScale(effectSprite.onScreenWidth / effectSprite:getContentSize().width, effectSprite.onScreenHeight / effectSprite:getContentSize().height)

        -- Add the timer layer
        local timerLayer = cc.LayerColor:create(cc.c4b(100,100,0,100))
        timerLayer:changeWidthAndHeight(effectSprite.onScreenWidth, effectSprite.onScreenHeight)
        timerLayer:setAnchorPoint(0,0)
        timerLayer:setPosition(0,0)
        effectSprite.timerLayer = timerLayer
        effectSprite:addChild(timerLayer)
        -- Add to the table
        self.playerEffectTable[self.playerEffectBlockIndex] = effectSprite
        -- Add as a child
        self.playerEffectBlockLayer:addChild(effectSprite)
        self.playerEffectBlockIndex = self.playerEffectBlockIndex + 1
    else
        -- This effect has been added to the table
        self.playerEffectTable[index].effectTimeCount = 0
        self.playerEffectTable[index].effectTimeToLive = effect.effectTimeToLive
        -- Update the timer layer
        self.playerEffectTable[index].timerLayer:changeWidthAndHeight(self.playerEffectTable[index].onScreenWidth, self.playerEffectTable[index].onScreenHeight)
    end

end

---
--  Add the effect to the monster slot
--  @function [parent=#panel.GameBattlePanel] mosnterAddEffect
--  @param effect 
function GameBattlePanel:monsterAddEffect(effect)
    -- First detect if this effect has existed in the table
    local index = nil
    for k,v in pairs(self.monsterEffectTable) do
       cclog("Type: "..v.effectType)
       if v.effectType == effect.effectType then
            index = v.index
            break
       end
    end
    
    if index == nil then
        -- This effect has not been added to the table
        local effectSprite = cc.Sprite:create("imgs/BuffDebuff/effect_"..effect.effectType:lower()..'.png')
        effectSprite.index = self.monsterEffectBlockIndex
        effectSprite.effectType = effect.effectType
        effectSprite.effectTimeCount = 0
        effectSprite.effectTimeToLive = effect.effectTimeToLive
        effectSprite:setAnchorPoint(0,0)
        -- Adjust the position
        if self.monsterEffectBlockIndex <= 3 then
            effectSprite.onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * self.monsterEffectBlockIndex + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.monsterEffectBlockIndex - 1)
            effectSprite.onScreenY = visibleSize.height * (GBattleEffectGapVerticalRatio + GBattleEffectVerticalStartOffset)
        else
            effectSprite.onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * (self.monsterEffectBlockIndex - GBattleMaxEffectInRow) + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.monsterEffectBlockIndex - 1 - GBattleMaxEffectInRow)
            effectSprite.onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio * 2 + visibleSize.height * GBattleEffectIconVerticalRatio 
        end
        effectSprite:setPosition(effectSprite.onScreenX, effectSprite.onScreenY)
        -- Adjust the size
        effectSprite.onScreenWidth = visibleSize.width * GBattleEffectIconHorizontalRatio 
        effectSprite.onScreenHeight = visibleSize.height * GBattleEffectIconVerticalRatio 
        effectSprite:setScale(effectSprite.onScreenWidth / effectSprite:getContentSize().width, effectSprite.onScreenHeight / effectSprite:getContentSize().height)

        -- Add the timer layer
        local timerLayer = cc.LayerColor:create(cc.c4b(0,0,0,100))
        timerLayer:changeWidthAndHeight(effectSprite.onScreenWidth, effectSprite.onScreenHeight)
        timerLayer:setAnchorPoint(0,0)
        timerLayer:setPosition(0,0)
        effectSprite.timerLayer = timerLayer
        effectSprite:addChild(timerLayer)
        -- Add to the table
        self.monsterEffectTable[self.monsterEffectBlockIndex] = effectSprite
        -- Add as a child
        self.monsterEffectBlockLayer:addChild(effectSprite)
        self.monsterEffectBlockIndex = self.monsterEffectBlockIndex + 1
    else
        -- This effect has been added to the table
        self.monsterEffectTable[index].effectTimeCount = 0
        self.monsterEffectTable[index].effectTimeToLive = effect.effectTimeToLive
        -- Update the timer layer
        self.monsterEffectTable[index].timerLayer:changeWidthAndHeight(self.monsterEffectTable[index].onScreenWidth, self.monsterEffectTable[index].onScreenHeight)
    end
    
    -- Apply the animation
    local effectFlipbook = AnimationManager.create("Heal2")
    effectFlipbook:setPosition(540, 300)
    effectFlipbook:setScale(3)
    self:addChild(effectFlipbook)
    effectFlipbook:runAnimation()
end

---
-- Update event
-- @function [parent=#panel.GameBattlePanel] onUpdate
-- @param delta num delta time
function GameBattlePanel:onUpdate(delta)
    -- Player effect
    local playerEffectToRemove = false
    --for k,v in pairs(self.playerEffectTable) do
    for i = 1, GBattleMaxEffectNumber, 1 do
        if self.playerEffectTable[i] ~= nil then
            self.playerEffectTable[i].effectTimeCount = self.playerEffectTable[i].effectTimeCount + delta
            if self.playerEffectTable[i].effectTimeCount > self.playerEffectTable[i].effectTimeToLive then
                -- time out and remove this effect
                self.playerEffectBlockLayer:removeChild(self.playerEffectTable[i])
                self.playerEffectTable[i] = nil
                cclog("Index: "..i..' to be deleted')
                playerEffectToRemove = true
            else
                -- update the icon
                self.playerEffectTable[i].timerLayer:changeWidthAndHeight(self.playerEffectTable[i].onScreenWidth, self.playerEffectTable[i].onScreenHeight * (1 - self.playerEffectTable[i].effectTimeCount / self.playerEffectTable[i].effectTimeToLive))    
            end
        end
    end

    if playerEffectToRemove then
        local reachEnd = false
        local playerBuffCount = 0
        -- Readjust all nodes position
        for i = 1, GBattleMaxEffectNumber, 1 do
            if self.playerEffectTable[i] == nil then
                for j = i + 1, GBattleMaxEffectNumber, 1 do
                    if self.playerEffectTable[j] ~= nil then
                        self.playerEffectTable[i] = self.playerEffectTable[j]   -- swap the effect element
                        self.playerEffectTable[i].index = i
                        self.playerEffectTable[j] = nil
                        if self.playerEffectTable[i].index <= 3 then
                            self.playerEffectTable[i].onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * self.playerEffectTable[i].index + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.playerEffectTable[i].index - 1)
                            self.playerEffectTable[i].onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio
                        else
                            self.playerEffectTable[i].onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * (self.playerEffectTable[i].index - GBattleMaxEffectInRow) + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.playerEffectTable[i].index - 1 - GBattleMaxEffectInRow)
                            self.playerEffectTable[i].onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio * 2 + visibleSize.height * GBattleEffectIconVerticalRatio 
                        end
                        self.playerEffectTable[i]:setPosition(self.playerEffectTable[i].onScreenX, self.playerEffectTable[i].onScreenY) 
                        self.playerEffectBlockIndex = i + 1
                        break
                    elseif self.playerEffectTable[j] == nil and j == GBattleMaxEffectNumber then
                        reachEnd = true          
                    end
                end
            else
                playerBuffCount = playerBuffCount + 1
            end
            -- If the remaining element is all nil ,jump out of the loop
            --[[if reachEnd then
                if i == 1 then
                    self.playerEffectBlockIndex = 1
                end
                break
            end--]]
        end
        self.playerEffectBlockIndex = playerBuffCount + 1
        cclog("Player next index " .. self.playerEffectBlockIndex)
        --cclog("Current index: "..self.playerEffectBlockIndex)
    end
    
    -- Monster effect
    local monsterEffectToRemove = false
    for i = 1, GBattleMaxEffectNumber, 1 do
        local effect = self.monsterEffectTable[i]
        if self.monsterEffectTable[i] ~= nil then
            self.monsterEffectTable[i].effectTimeCount = self.monsterEffectTable[i].effectTimeCount + delta
            if self.monsterEffectTable[i].effectTimeCount > self.monsterEffectTable[i].effectTimeToLive then
                -- time out and remove this effect
                self.monsterEffectBlockLayer:removeChild(self.monsterEffectTable[i])
                self.monsterEffectTable[i] = nil
                cclog("Index: "..i..' to be deleted')
                monsterEffectToRemove = true
            else 
                self.monsterEffectTable[i].timerLayer:changeWidthAndHeight(self.monsterEffectTable[i].onScreenWidth, self.monsterEffectTable[i].onScreenHeight * (1 - self.monsterEffectTable[i].effectTimeCount / self.monsterEffectTable[i].effectTimeToLive)) 
            end
        end
    end

    if monsterEffectToRemove then
        local reachEnd = false
        local monsterBuffCount = 0
        -- Readjust all nodes position
        for i = 1, GBattleMaxEffectNumber, 1 do
            if self.monsterEffectTable[i] == nil then
                for j = i + 1, GBattleMaxEffectNumber, 1 do
                    if self.monsterEffectTable[j] ~= nil then
                        self.monsterEffectTable[i] = self.monsterEffectTable[j]   -- swap the effect element
                        self.monsterEffectTable[i].index = i
                        self.monsterEffectTable[j] = nil
                        if self.monsterEffectTable[i].index <= 3 then
                            self.monsterEffectTable[i].onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * self.monsterEffectTable[i].index + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.monsterEffectTable[i].index - 1)
                            self.monsterEffectTable[i].onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio
                        else
                            self.monsterEffectTable[i].onScreenX = visibleSize.width * GBattleEffectHorizontalStartOffset + visibleSize.width * GBattleEffectGapHorizontalRatio * (self.monsterEffectTable[i].index - GBattleMaxEffectInRow) + visibleSize.width * GBattleEffectIconHorizontalRatio * (self.monsterEffectTable[i].index - 1 - GBattleMaxEffectInRow)
                            self.monsterEffectTable[i].onScreenY = visibleSize.height * GBattleEffectVerticalStartOffset + visibleSize.height * GBattleEffectGapVerticalRatio * 2 + visibleSize.height * GBattleEffectIconVerticalRatio 
                        end
                        self.monsterEffectTable[i]:setPosition(self.monsterEffectTable[i].onScreenX, self.monsterEffectTable[i].onScreenY) 
                        self.monsterEffectBlockIndex = i + 1
                        break
                    elseif self.monsterEffectTable[j] == nil and j == GBattleMaxEffectNumber then
                        reachEnd = true          
                    end
                end
            else 
                monsterBuffCount = monsterBuffCount + 1
            end
            -- If the remaining element is all nil ,jump out of the loop
            --[[if reachEnd then
                if i == 1 then
                    self.monsterEffectBlockIndex = 1
                end
                --break
            end--]]
        end
        
        self.monsterEffectBlockIndex = monsterBuffCount + 1
        cclog("Monster next index " .. self.monsterEffectBlockIndex)
        --cclog("Current index: "..self.monsterEffectBlockIndex)
    end
end

---
-- Change the sprite for the monster when the monster is dead
-- @function [parent=#panel.GameBattlePanel] monsterIsDefeated
function GameBattlePanel:monsterIsDefeated()
    local scaleAction = cc.ScaleBy:create(2,0.01)
    self:getChildByName("MonsterNode"):runAction(scaleAction)   
end

---
-- Get the position for a certain rune in the game battle panel
-- @function [parent=#panel.GameBattlePanel] getRunePosition
-- @param runeName string name of the desired rune
function GameBattlePanel:getRunePosition(runeName)
    return self.runePositionTable[runeName]
end

return GameBattlePanel

