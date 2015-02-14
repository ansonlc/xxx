--------------------------------------------------------------------------------
-- GameScene.lua - 游戏场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require "core.BaseScene"

local GameScene = class("GameScene", function() return BaseScene.create() end)

function GameScene:ctor()
    self.sceneName = "GameScene"
    self.gameBoard = nil
end

function GameScene.create()
    local scene = GameScene.new()
    scene:initScene()
    return scene
end

-- create game scene
function GameScene:onInit()
    AudioEngine.stopMusic(true)
    
    local GameBackgroundLayer = require("panel.GameBackgroundLayer")
    self.backLayer = GameBackgroundLayer.create()
    self:addChild(self.backLayer)
    
    ---[[
    local GameBoardPanelSwitchMode = require("panel.GameBoardPanelSwitchMode")
    self.gameBoard = GameBoardPanelSwitchMode.create()
    --]]
    
    --[[
    local GameBoardPanelDragMode = require("panel.GameBoardPanelDragMode")
    self.gameBoard = GameBoardPanelDragMode.create()
    --]]
    self:addChild(self.gameBoard)
    
    -- Add the SkillSlotPanel
    local GameSkillSlotPanel = require("panel.GameSkillSlotPanel")
    self.skillPanel = GameSkillSlotPanel.create()
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