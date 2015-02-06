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
    
    local GameBoardPanel = require("panel.GameBoardPanel")
    self.gameBaord = GameBoardPanel.create()
    self:addChild(self.gameBaord)
    
    -- Add the SkillSlotPanel
    local SkillSlotPanel = require("panel.SkillSlotPanel")
    self.skillPanel = SkillSlotPanel.create()
    self:addChild(self.skillPanel)    

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)
end

return GameScene