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
    elseif self.enterData.mode == "DragMode" then
        GameBoardClass = require("panel.GameBoardPanelDragMode")
    elseif self.enterData.mode == "SlideMode" then
        GameBoardClass = require("panel.GameBoardPanelCycle")
    end
    self.gameBoard = GameBoardClass.create()
    self:addChild(self.gameBoard)
    
    -- Add the SkillSlotPanel
    local GameSkillSlotPanel = require("panel.GameSkillSlotPanel")
    self.skillPanel = GameSkillSlotPanel.create()
    self.skillPanel:setName("GameSkillSlotPanel")
    self:addChild(self.skillPanel)
    
    -- Add the GameBattlePanel
    local GameBattlePanel = require("panel.GameBattlePanel")
    self.battlePanel = GameBattlePanel.create()
    self.battlePanel:setName("GameBattlePanel")
    self:addChild(self.battlePanel)
    
    -- Add the GameBattleLogic node here
    local GameBattelLogic = require("logic.GameBattleLogic")
    self.battleLogicNode = GameBattelLogic.create()
    self.battleLogicNode:setName("GameBattleLogic")
    self:addChild(self.battleLogicNode)
    -- directly call the init function of this node
    self.battleLogicNode:initNode()

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)
end

function GameScene:onUpdate(dt)
    if self.gameBoard and self.gameBoard.onUpdate then
        self.gameBoard:onUpdate(dt)
    end
--    cclog(dt)
end

return GameScene