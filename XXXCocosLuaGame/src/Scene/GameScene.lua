--------------------------------------------------------------------------------
-- GameBoardPanel.lua - 游戏场景
-- @author fangzhou.long
-- TODO 将本场景包装成类
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
    local GameBackgroundLayer = require("panel.GameBackgroundLayer")
    self:addChild(GameBackgroundLayer.create())

    AudioEngine.stopMusic(true)

    local bgMusicPath = cc.FileUtils:getInstance():fullPathForFilename("sound/bgm_game.wav")
    AudioEngine.playMusic(bgMusicPath, true)

    local GameBoardPanel = require("panel.GameBoardPanel")
    self.gameBaord = GameBoardPanel.create()
    self:addChild(self.gameBaord)
end

return GameScene