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
end

-- create game scene
function GameScene:onInit()
    AudioEngine.stopMusic(true)
    
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
    -- TODO: Initialize the monster data based on the enter data - self.enterData.monsterID
    self.battleLogicNode:initNode()
    -- TODO: Delete the monster simulation ID
    self.battleLogicNode:initMonster(1003)
    
    -- Add the MonsterAILogic
    local MonsterAIlogic = require("logic.MonsterAILogic")
    self.monsterAI = MonsterAIlogic.create(self)
    self.monsterAI:setName("MonsterAILogic")
    self:addChild(self.monsterAI)
    self.monsterAI:initAI()
    self.monsterAI:initMonster(1003)
    
    --local rootNode = cc.CSLoader:createNode("GameScene.csb")
    --self:addChild(rootNode)

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)
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
    
    if playerWins then
        SceneManager.replaceSceneWithName("ResultScene", "Test")
    else
        SceneManager.replaceSceneWithName("EndingScene", "Test")
    end
    
    --[[local AINode = self:getChildByName("MonsterAILogic")
    AINode.isAIOn = false
    
    self:setGameTouch(false)
    
    local blackLayer = cc.LayerColor:create(cc.c4b(0, 0, 0,150), self.visibleSize.width, self.visibleSize.height)
    local label = cc.Label:create()
    label:setString("Game Over!\nPress to continue")
    label:setPosition(self.visibleSize.width/2 , self.visibleSize.height/2)
    label:setAlignment(cc.TEXT_ALIGNMENT_CENTER)
    label:setScale(7)
    blackLayer:addChild(label)
    
    local function onTouch(touch, event)
        --print(event:getEventCode())
        if event:getEventCode() == 2 then
            local params = SceneManager.generateParams(self, "MainMenuScene", self.enterData)
            SceneManager.replaceSceneWithName("ResultScene",params)
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
    dispatcher:addEventListenerWithSceneGraphPriority(listener, blackLayer)--]]
end

return GameScene