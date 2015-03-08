--------------------------------
-- SkillSelectScene.lua
-- @author Gaoyuan Chen
--------------------------------

require("utils.GeneralUtil")
require("manager.DataManager")
require("manager.MetaManager")

local battle_mission_cfg = require("config.battle_mission")
local SkillTagHeader = 10000
local currentSelect = 0
local SkillSelectScene = class("SkillSelectScene", function() return BaseScene.create() end)

function SkillSelectScene:ctor()
    self.sceneName = "SkillSelectScene"
end

function SkillSelectScene.create(params)
    local scene = SkillSelectScene.new()
    scene:initScene(params)
    return scene
end

local skillIcons = {}
local skillSlotButton = {}


local function drawCurrentSkill(root)
    local skills = DataManager.userInfo.currentSkills

    for _, id in pairs(allSkill()) do
        skillIcons[id]:setVisible(false)
    end

    for i = 1,5 do
        local skillSprite = skillIcons[skills[i]]
        skillSprite:setPosition(i * 196 - 45 , 1654)
        skillSprite:setScale(2.6)
        skillSprite:setVisible(true)
        skillSprite:setOpacity(255)
        if i == currentSelect then
            skillSprite:setOpacity(50)
        end
    end
end

local function currentNotContain(id)
    for i = 1,5 do
        if DataManager.userInfo.currentSkills[i] == id then
            return false
        end
    end
    return true
end

local SkillListSize = 200
local SkillListSizePlus = 210

local skillListIcons = {}

local function updateInvalidSkills()
    for _, id in pairs(allSkill()) do
        if currentNotContain(id) then
            skillListIcons[id]:setOpacity(255)
        else
            skillListIcons[id]:setOpacity(50)
        end
    end
end

local function buildSkillButton(id, skill, posY)
    local skillButton = ccui.Button:create()
    
    skillListIcons[id] = skillButton

    --skillButton:setTitleText(skill.skillName)-- ? - 0.lvlName
    --skillButton:setTitleFontName("fonts/ALGER.TTF")
    --skillButton:setTitleFontSize(72)
    
    skillButton:loadTextures("res/imgs/temp/white.png", "res/imgs/temp/white.png")
    skillButton:setScale(800, SkillListSize)
    skillButton:setPosition(cc.p(430, posY))
    
    local pic = cc.Sprite:create("res/imgs/temp/skill_" .. id .. ".png")
    pic:setScale(2.0 / 800, 2.0 / SkillListSize)
    pic:setPosition(100.0 / 800, 100.0 / SkillListSize)
    skillButton:addChild(pic)
    
    
    local function onBtnPress(sender, eventType)
        if eventType == 0 then
            if currentSelect > 0 and currentNotContain(id) then
                print ("x[" .. currentSelect .. "] = " .. id)
                DataManager.userInfo.currentSkills[currentSelect] = id
                currentSelect = 0
                drawCurrentSkill()
                updateInvalidSkills()
            end
        end
    end
    skillButton:addTouchEventListener(onBtnPress)
    
    --TODO Add level button background
    return skillButton
end


local function drawIcons(root)
    for _, id in pairs(allSkill()) do
        skillIcons[id] = cc.Sprite:create("res/imgs/temp/skill_" .. id .. ".png")
        root:addChild(skillIcons[id])
        skillIcons[id]:setVisible(false)
    end
end



function SkillSelectScene:onInit()
    
    
    local rootNode = cc.CSLoader:createNode("SkillSelectScene.csb")
    
    
    drawIcons(rootNode)
    
    self:addChild(rootNode)
    self.skillScroll = rootNode:getChildByName("SkillScroll")
    
    print("self.skillScroll = ")
    print(self.skillScroll)
    
    drawCurrentSkill(rootNode)
    
    local btn2scene = {
        ["Button_Ok"] = "GameScene",
        ["Button_Cancel"] = "LevelSelectScene",
        ["Button_Skill1"] = "",
        ["Button_Skill2"] = "",
        ["Button_Skill3"] = "",
        ["Button_Skill4"] = "",
        ["Button_Skill5"] = "",

    }

    local function onBtnPress(sender, eventType)
        
        if eventType == ccui.TouchEventType.ended then
            for i = 1,5 do
                if sender:getName() == ("Button_Skill" .. i) then
                    
                    if i == currentSelect then
                        currentSelect = 0
                    elseif currentSelect > 0 then
                        local a = DataManager.userInfo.currentSkills[i]
                        local b = DataManager.userInfo.currentSkills[currentSelect]
                        DataManager.userInfo.currentSkills[i] = b
                        DataManager.userInfo.currentSkills[currentSelect] = a
                        currentSelect = 0
                    else
                        currentSelect = i
                    end
                    drawCurrentSkill(rootNode)
                    updateInvalidSkills()
                end
            end
            
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
    
    for i = 1,5 do
        rootNode:getChildByName("Button_Skill" .. i):setOpacity(0)
    end

    for key,_ in pairs(btn2scene) do
        rootNode:getChildByName(key):addTouchEventListener(onBtnPress)
    end
    
    --TODO Adjust scroll view size here
    local totalY = 0
    local yOffset = SkillListSizePlus
    local nowPosY = 1850
    for id, key in pairs(allSkill()) do
        
        local skillButton = buildSkillButton(key, MetaManager.getSkill(key), nowPosY)
        self.skillScroll:addChild(skillButton)
        nowPosY = nowPosY - yOffset
        totalY = totalY + SkillListSizePlus
    end
    
    updateInvalidSkills()


end

return SkillSelectScene