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
    cclog("Now level: " .. self.enterData.level)
    cclog("Now mode: " .. self.enterData.mode)
    cclog("Now difficulty: " .. self.enterData.difficulty)
end

-- create game scene
function GameScene:onInit()
    AudioEngine.stopMusic(true)
    
    local GameBackgroundLayer = require("panel.GameBackgroundLayer")
    self.backLayer = GameBackgroundLayer.create()
    self:addChild(self.backLayer)
    
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
        self.gameBoard = GameBoardClass.create()
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
    
--    cclog(dt)
end

return GameScene