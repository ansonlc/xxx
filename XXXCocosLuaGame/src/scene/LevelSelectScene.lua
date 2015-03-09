--------------------------------
-- LevelSelectScene.lua
-- @author fangzhou.long
-- TODO Add background map
--------------------------------

local battle_mission_cfg = require("config.battle_mission")
local LevelTagHeader = 10000
local unLockedStoryLevelNum = 101103 --TODO Get it from UserInfo table

local LevelSelectScene = class("LevelSelectScene", function() return BaseScene.create() end)

function LevelSelectScene:ctor()
    self.sceneName = "LevelSelectScene"
end

function LevelSelectScene.create()
    local scene = LevelSelectScene.new()
    scene:initScene()
    return scene
end

local function buildLevelButton(lvlBossType, lvlNum, lvlName, posY)
    local lvlBtn = ccui.Button:create()
    lvlBossType = lvlBossType and lvlBossType or "?"
    lvlBtn:setTitleText(lvlBossType .. " - " .. lvlNum .. "." .. lvlName)-- ? - 0.lvlName
    lvlBtn:setTitleFontName("fonts/ALGER.TTF")
    lvlBtn:setTitleFontSize(72)
    
    --lvlBtn:setPositionType(cc.POSITION_TYPE_RELATIVE)
    --lvlBtn:setPositionPercent(cc.p(.5, posY))
    lvlBtn:setPosition(cc.p(540, posY))
    
    --TODO Add level button background
    return lvlBtn
end

function LevelSelectScene:onInit()
    local rootNode = cc.CSLoader:createNode("LevelSelectScene.csb")
    self:addChild(rootNode)
    self.lvlScroll = rootNode:getChildByName("LevelScroll")
    
    local function onRtnTouch(sender, eventType)
        local params = SceneManager.generateParams(self, "MainMenuScene", nil)
        SceneManager.replaceSceneWithName("MainMenuScene", params)
    end
    local rtnBtn = rootNode:getChildByName("btn_return");
    rtnBtn:addTouchEventListener(onRtnTouch)
    
    -- Level buttons touching event
    local function onTouch(sender, eventType)
        --While exiting this scene, ignore touch events
        if not self.touchEnabled then
            return false
        end
        
        if eventType == ccui.TouchEventType.ended then
            local selectLvL = battle_mission_cfg[sender:getTag() - LevelTagHeader]
            local params = SceneManager.generateParams(self, "MainMenuScene", {missionId = selectLvL.id})
            params.data.mode = "SlideMode"
            params.data.difficulty = "Hard"
            
            SceneManager.replaceSceneWithName("SkillSelectScene", params)
        end
    end
    
    -- Add level button items to scroll view
    local yOffset = 100
    local nowPosY = 1720
    for key, value in ipairs(battle_mission_cfg) do
        --TODO Add different chapters and worlds
        local lvBossType = value.lvlBossType==0 and nil or value.lvlBossType
        local lvNum = math.mod(value.id, 100)
        local lvName = value.missionName
        
        if unLockedStoryLevelNum<value.id then
            lvName = "-- LEVEL LOCKED --"
        end
        
        local lvlBtn = buildLevelButton(lvBossType, lvNum, lvName, nowPosY)
        lvlBtn:setTag(LevelTagHeader + key)
        lvlBtn:addTouchEventListener(onTouch)
        self.lvlScroll:addChild(lvlBtn)
        
        if unLockedStoryLevelNum<value.id then
            lvlBtn:setEnabled(false)
            break
        end
        
        nowPosY = nowPosY - yOffset
    end
    --TODO Adjust scroll view size here
end

return LevelSelectScene