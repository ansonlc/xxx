--------------------------------
-- SkillSelectScene.lua
-- @author Gaoyuan Chen
--------------------------------

require("utils.GeneralUtil")
require("manager.DataManager")
require("manager.MetaManager")

local battle_mission_cfg = require("config.battle_mission")
local SkillTagHeader = 10000

local SkillSelectScene = class("SkillSelectScene", function() return BaseScene.create() end)

function SkillSelectScene:ctor()
    self.sceneName = "SkillSelectScene"
end

function SkillSelectScene.create(params)
    local scene = SkillSelectScene.new()
    scene:initScene(params)
    return scene
end


local function buildSkillButton(skill, posY)
    local skillButton = ccui.Button:create()

    skillButton:setTitleText(skill.skillName)-- ? - 0.lvlName
    skillButton:setTitleFontName("fonts/ALGER.TTF")
    skillButton:setTitleFontSize(72)

    --skillButton:setPositionType(cc.POSITION_TYPE_RELATIVE)
    --skillButton:setPositionPercent(cc.p(.5, posY))
    skillButton:setPosition(cc.p(450, posY))

    --TODO Add level button background
    return skillButton
end

local function drawCurrentSkill(root)
    local skills = DataManager.userInfo.currentSkills
    for i = 1,5 do
        local skillSprite = cc.Sprite:create("res/imgs/temp/skill_" .. skills[i] .. ".png")
        skillSprite:setPosition(i * 196 - 45 , 1654)
        skillSprite:setScale(2.6)
        root:addChild(skillSprite)
    end
end


function SkillSelectScene:onInit()
    
    
    local rootNode = cc.CSLoader:createNode("SkillSelectScene.csb")

    self:addChild(rootNode)
    self.skillScroll = rootNode:getChildByName("SkillScroll")
    
    print("self.skillScroll = ")
    print(self.skillScroll)
    
    drawCurrentSkill(rootNode)
    
    local btn2scene = {
        ["Button_Ok"] = "GameScene",
        ["Button_Cancel"] = "LevelSelectScene",
    }

    local function onBtnPress(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            if sender:getName() == "Button_Ok" then
                --print ("ok!")
                local params = {}
                params.enterScene = self.enterScene
                params.returnScene = self.returnScene
                params.data = self.enterData
                SceneManager.replaceSceneWithName("GameScene", params)
                
            end
            if sender:getName() == "Button_Cancel" then
                --print ("cancel!")
                SceneManager.replaceSceneWithName("LevelSelectScene")
            end
            --SceneManager.replaceSceneWithName(btn2scene[sender:getName()], params)
            return true
        end
    end

    for key,_ in pairs(btn2scene) do
        rootNode:getChildByName(key):addTouchEventListener(onBtnPress)
    end
    
    
    --[[
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

            SceneManager.replaceSceneWithName("GameScene", params)
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

        local skillButton = buildLevelButton(lvBossType, lvNum, lvName, nowPosY)
        skillButton:setTag(LevelTagHeader + key)
        skillButton:addTouchEventListener(onTouch)
        self.lvlScroll:addChild(skillButton)

        if unLockedStoryLevelNum<value.id then
            skillButton:setEnabled(false)
            break
        end

        nowPosY = nowPosY - yOffset
    end
    ]]--
    --TODO Adjust scroll view size here
    local yOffset = 100
    local nowPosY = 1000
    for id, key in pairs(allSkill()) do
        print("key = ")
        print(key)
        local skillButton = buildSkillButton(MetaManager.getSkill(key), nowPosY)
        self.skillScroll:addChild(skillButton)
        nowPosY = nowPosY - yOffset
    end


end

return SkillSelectScene