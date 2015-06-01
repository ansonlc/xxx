--------------------------------
-- LevelSelectScene.lua
-- @author fangzhou.long
-- TODO Add background map
--------------------------------

local LevelTagHeader = 10000

local LevelSelectScene = class("LevelSelectScene", function() return BaseScene.create() end)

function LevelSelectScene:ctor()
    self.sceneName = "LevelSelectScene"
end

function LevelSelectScene.create()
    local scene = LevelSelectScene.new()
    scene:initScene()
    return scene
end

local function buildLevelButton(lvlBossType, isLocked, isBossLevel, lvlNum, posY)
    local lvlBtn = ccui.Button:create()
    lvlBtn:setTitleText("          Level " .. lvlNum)-- ? - 0.lvlName
    lvlBtn:setTitleFontName("fonts/ALGER.TTF")
    lvlBtn:setTitleFontSize(72)
    
    --lvlBtn:setPositionType(cc.POSITION_TYPE_RELATIVE)
    --lvlBtn:setPositionPercent(cc.p(.5, posY))
    lvlBtn:setPosition(cc.p(540, posY))
    
    -- Add level button background
    local suffix = isLocked and "lock" or "unlock"
    if isBossLevel then
        lvlBtn:loadTextureNormal("imgs/LevelSelectScene/level_boss_" .. suffix .. ".png")
    else
        lvlBtn:loadTextureNormal("imgs/LevelSelectScene/level_" .. suffix .. ".png")
    end
    
    -- Add level icon
    local pic = 
        isLocked and 
        cc.Sprite:create("imgs/LevelSelectScene/icon_lock" .. (isBossLevel and "_boss" or "") .. ".png")
        or cc.Sprite:create("res/imgs/GameScene/tile_" .. (({"fire","earth","crystal","air","water"})[lvlBossType])..  ".png")
    
    if not isLocked and not isBossLevel then
        pic:setScale(0.5)
    end
    
    pic:setNormalizedPosition(cc.p(.25, .5))
    lvlBtn:addChild(pic)
    return lvlBtn
end

function LevelSelectScene:onInit()
    local rootNode = cc.CSLoader:createNode("LevelSelectScene.csb")
    self.btnTutorial = GameButton.create("TutorialBtn", true, 0.5)
    rootNode:getChildByName("btn_tutorial"):addChild(self.btnTutorial)

    local panel = require("panel.TutorialPanel")
    rootNode:addChild(panel.create(self, self.btnTutorial))
    
    self:addChild(rootNode)
    self.lvlScroll = rootNode:getChildByName("LevelScroll")
    
    local function onRtnTouch(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then
            local params = SceneManager.generateParams(self, "MainMenuScene", nil)
            SceneManager.replaceSceneWithName("MainMenuScene", params)
        end
    end
    local rtnNode = rootNode:getChildByName("node_rtn_btn");
    local rtnBtn = GameButton.create("ReturnBtn", true, 0.5)
    rtnBtn:addTouchEventListener(onRtnTouch)
    --rtnBtn:setEnabled(false)
    rtnNode:addChild(rtnBtn)
    
    local battle_mission_cfg = require("config.battle_mission")
    -- Level buttons touching event
    local function onTouch(sender, eventType)
        --While exiting this scene, ignore touch events
        if not self.touchEnabled then return true end
        
        if eventType == ccui.TouchEventType.ended then
            local selectLvL = battle_mission_cfg[sender:getTag() - LevelTagHeader]
            local params = SceneManager.generateParams(self, "MainMenuScene", {missionId = selectLvL.id})
            --params.data.mode = "SlideMode"
            params.data.mode = "DragMode"
            params.data.difficulty = "Hard"
            -- Write to current user info
            DataManager.userInfo.currentMonsterID = selectLvL.missionBossID
            DataManager.userInfo.currentLevelID = selectLvL.id
            SceneManager.replaceSceneWithName("SkillSelectScene", params)
        end
    end
    
    -- Add level button items to scroll view    
    local nowPosY = 600
    local totalHeight = 1300
    local preOffset = 200
    
    local unLockedStoryLevelNum = DataManager.getStoryProgress()
    for key, value in ipairs(battle_mission_cfg) do
        --TODO Add different chapters and worlds
        local lvBossType = value.missionBossType and value.missionBossType or 1
        local lvNum = math.mod(value.id, 100)
        local yOffset = (value.isBossLevel) and 310 or 190 --It should be 320/200, I dont know why its 10px less by Fangzhou.Long

        nowPosY = nowPosY + yOffset/2 + preOffset/2
        local isUnlocked = unLockedStoryLevelNum+1<key
        local lvlBtn = buildLevelButton(lvBossType, isUnlocked, value.isBossLevel, lvNum, nowPosY)
        lvlBtn:setTag(LevelTagHeader + key)
        lvlBtn:addTouchEventListener(onTouch)
        self.lvlScroll:addChild(lvlBtn)
        
        if isUnlocked then
            lvlBtn:setEnabled(false)
            break
        end
        
        totalHeight = totalHeight + yOffset
        preOffset = yOffset
    end

    --Auto adjust inner size
    self.lvlScroll:setInnerContainerSize(cc.size(1080, totalHeight))
end

return LevelSelectScene