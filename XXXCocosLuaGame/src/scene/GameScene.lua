--------------------------------------------------------------------------------
-- GameScene.lua
-- @author fangzhou.long
--------------------------------------------------------------------------------

require "core.BaseScene"

local GameScene = class("GameScene", function() return BaseScene.create() end)

function GameScene:ctor()
    self.sceneName = "GameScene"
    self.gameBoard = nil
end

function GameScene.create(params)
    local scene = GameScene.new()
    scene:initScene(params)
    return scene
end

function GameScene:onEnter()
    cclog("Now mission id: " .. self.enterData.missionId)
    cclog("Now mode: " .. self.enterData.mode)
    cclog("Now difficulty: " .. self.enterData.difficulty)
    --self:onGameOver()
end

function GameScene:setGameTouch(flag)
    self.gameBoard:setTouch(flag)
    self.battlePanel:setTouchEnabled(flag)
    self.skillPanel:setTouchEnabled(flag)
    self.skillPanel.skillSlotManagerLayer:setTouchEnabled(flag)
end

-- create game scene
function GameScene:onInit()
    --AudioEngine.stopMusic(true)
    
    local musicIndex = math.random(1,4)
    SoundManager.playBGM('battle'..tostring(musicIndex), true)
    
    local GameBackgroundLayer = require("panel.GameBackgroundLayer")
    self.backLayer = GameBackgroundLayer.create()
    self:addChild(self.backLayer)
    
    GameIconManager.loadTileIcons()
    local GameBoardClass = nil
    if self.enterData.mode == "SwitchMode" then
        GameBoardClass = require("panel.GameBoardPanelSwitchMode")
        self.gameBoard = GameBoardClass.create()
        self:addChild(self.gameBoard)
    elseif self.enterData.mode == "DragMode" then
        GameBoardClass = require("panel.GameBoardPanelDragMode")
        self.gameBoard = GameBoardClass.create(self)
        self:addChild(self.gameBoard)
    elseif self.enterData.mode == "SlideMode" then
        GameBoardClass = require("panel.GameBoardPanelCycle")
        self.gameBoard = GameBoardClass.create(self)
        self:addChild(self.gameBoard)
    end

    
    -- Add the SkillSlotPanel
    local GameSkillSlotPanel = require("panel.GameSkillSlotPanel")
    -- TODO: Pass in the skill table chosen by the player   - self.enterData.skillTable
    self.skillPanel = GameSkillSlotPanel.create(self, self.enterData.skillTable)
    self.skillPanel:setName("GameSkillSlotPanel")
    self:addChild(self.skillPanel)
    
    -- Add the GameBattlePanel
    local GameBattlePanel = require("panel.GameBattlePanel")
    self.battlePanel = GameBattlePanel.create(self)
    self.battlePanel:setName("GameBattlePanel")
    self:addChild(self.battlePanel)
    
    -- Add the GameBattleLogic node here
    local GameBattelLogic = require("logic.GameBattleLogic")
    self.battleLogicNode = GameBattelLogic.create()
    self.battleLogicNode:setName("GameBattleLogic")
    self:addChild(self.battleLogicNode)
    -- Directly call the init function of for this node
    self.battleLogicNode:initNode()
    self.battleLogicNode:initMonster(DataManager.userInfo.currentMonsterID)
    
    -- Add the MonsterAILogic
    local MonsterAIlogic = require("logic.MonsterAILogic")
    self.monsterAI = MonsterAIlogic.create(self)
    self.monsterAI:setName("MonsterAILogic")
    self:addChild(self.monsterAI)
    self.monsterAI:initAI()
    self.monsterAI:initMonster(DataManager.userInfo.currentMonsterID)
    
    --local rootNode = cc.CSLoader:createNode("GameScene.csb")
    --self:addChild(rootNode)

    --local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_battle.wav")
    --AudioEngine.playMusic(bgMusicPath, true)
end

function GameScene:onUpdate(dt)
    if self.gameBoard and self.gameBoard.onUpdate then
        self.gameBoard:onUpdate(dt)
    end
    
    if self.battlePanel and self.battlePanel.onUpdate then
        self.battlePanel:onUpdate(dt)
    end
    
    if self.skillPanel and self.skillPanel.onUpdate then
        self.skillPanel:onUpdate(dt)
    end 
    
    if self.monsterAI and self.monsterAI.onUpdate then
        self.monsterAI:onUpdate(dt)
    end
    
    if self.battleLogicNode and self.battleLogicNode.onUpdate then
        self.battleLogicNode:onUpdate(dt)
    end
    
    if self.skillPanel and self.skillPanel.onUpdate then
        self.skillPanel:onUpdate(dt)
    end
end

function GameScene:onGameOver(playerWins, gameData)
      
    -- stop the music
    --SoundManager.stopMusic()
    if playerWins then
        SoundManager.playBGM('victory', false)
    else
        SoundManager.stopMusic()
    end 
     
    local AINode = self:getChildByName("MonsterAILogic")
    AINode.isAIOn = false
    
    self:setGameTouch(false)
    
    local blackLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), self.visibleSize.width, self.visibleSize.height)
    local label = cc.Label:create()
    if playerWins then
        label:setString("You win!\nPress to continue")
        --Unlock next level
        local _, nowLevelKey = GeneralUtil.getSubTableByKey(MetaManager["battle_mission"], 
            {name = "id", value = self.enterData.missionId})
        local nowProgress = DataManager.getStoryProgress()
        local battle_mission_cfg = require("config.battle_mission")
        if nowLevelKey == nowProgress and battle_mission_cfg[nowProgress + 1] then
            DataManager.setStoryProgress(nowProgress + 1)
        end
    else
        label:setString("Game Over!\nPress to continue")
    end
    label:setPosition(self.visibleSize.width/2 , self.visibleSize.height/2)
    label:setAlignment(cc.TEXT_ALIGNMENT_CENTER)
    label:setScale(7)
    blackLayer:addChild(label)
    
    -- Save the data
    DataManager.saveData()
    
    local function onTouch(touch, event)
        --print(event:getEventCode())
        local params
        if event:getEventCode() == 2 then
            if playerWins then
                -- [[TODO Results needed to calculate by Ren
                --[[
                local upgradeSkillIds = {
                    {
                        skillId = 1001,
                        lvlBefore = 1,
                        lvlAfter = 99,
                    },
                    {
                        skillId = 1002,
                        lvlBefore = 1,
                        lvlAfter = 99,
                    },
                }
                --]]
                -- iterate through all the skill
                ---[[
                local upgradeSkillIds = {}
                local index = 1
                if gameData == nil or gameData[1] == nil then
                
                else
                    for k, v in pairs(gameData[1]) do
                        --local currentLvl = gameData[3][k].level
                        local currentLvl = DataManager.expToLevel(gameData[3][k].exp)
                        local expGained = v * MetaManager.getSkill(k).growthRatio
                        -- Construct the table
                        upgradeSkillIds[index] = {}
                        upgradeSkillIds[index].skillId = k
                        upgradeSkillIds[index].lvlBefore = currentLvl
                        --upgradeSkillIds[index].lvlAfter = currentLvl
                        -- add the exp to the current exp
                        DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills[k].exp = DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills[k].exp + expGained
                        -- check if the skill has leveled up or not\
                        upgradeSkillIds[index].lvlAfter = DataManager.expToLevel(DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills[k].exp)
                        --[[if true then
                        --if currentLvl < GSkillMaxLevel then
                            local nextLvl = 1  -- always points to the next lvl
                            upgradeSkillIds[index].lvlAfter = nextLvl - 1
                            DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills[k].level =  nextLvl - 1
                        end--]]
                        index  = index + 1
                    end
                end
               
                --]]
                local battleResult = {
                    unlockMonsterId = MetaManager.getMonster(DataManager.userInfo.currentMonsterID).picture,
                    --unlockMonsterId = "Pikachuaa",
                    learnSkillId = 1800,
                    upgradeSkillIds = upgradeSkillIds,
                    crystal = self.battleLogicNode.crystalNum ,
                }
                -- Modify codes before here
                
                
                local resultData = {
                    levelData = self.enterData,
                    battleResult = battleResult,
                }
                params = SceneManager.generateParams(self, "MainMenuScene", resultData)
                SceneManager.replaceSceneWithName("ResultScene", params)
            else
                params = SceneManager.generateParams(self, "MainMenuScene", self.enterData)
                SceneManager.replaceSceneWithName("EndingScene", params)
            end
            return true
        end
        return true
    end
    
    blackLayer:setTouchEnabled(true)
    blackLayer:setSwallowsTouches(true)
    
    self:addChild(blackLayer)
    
    local dispatcher = cc.Director:getInstance():getEventDispatcher()
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouch, cc.Handler.EVENT_TOUCH_ENDED)
    dispatcher:addEventListenerWithSceneGraphPriority(listener, blackLayer)
end

return GameScene