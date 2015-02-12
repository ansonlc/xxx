--------------------------------------------------------------------------------
-- GameScene.lua - 游戏场景
-- @author fangzhou.long
--------------------------------------------------------------------------------

require "core.BaseScene"

local GameScene = class("GameScene", function() return BaseScene.create() end)

function GameScene:ctor()
    self.sceneName = "GameScene"
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
    
    --[[
    local GameBoardPanelSwitchMode = require("panel.GameBoardPanelSwitchMode")
    self.gameBaord = GameBoardPanelSwitchMode.create()
    self:addChild(self.gameBaord)
    --]]
    
    ---[[
    local GameBoardPanelDragMode = require("panel.GameBoardPanelDragMode")
    self.gameBaordDragMode = GameBoardPanelDragMode.create()
    self:addChild(self.gameBaordDragMode)
    --]]
    
    -- Add the SkillSlotPanel
    local GameSkillSlotPanel = require("panel.GameSkillSlotPanel")
    self.skillPanel = GameSkillSlotPanel.create()
    self:addChild(self.skillPanel)
    
    -- Add the GameBattlePanel
    local GameBattlePanel = require("panel.GameBattlePanel")
    self.battlePanel = GameBattlePanel.create()
    self:addChild(self.battlePanel)
    
    -- Add the GameBattleLogic node here
    local GameBattelLogic = require("logic.GameBattleLogic")
    self.battleLogicNode = GameBattelLogic.create()
    self:addChild(self.battleLogicNode, 0, 123)

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)
end

return GameScene