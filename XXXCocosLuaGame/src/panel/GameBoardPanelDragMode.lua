--------------------------------------------------------------------------------
-- GameBoardPanelDragMode.lua 
-- @author Gaoyuan Chen
--------------------------------------------------------------------------------

require "manager.GameIcon"

local GameBoardPanelDragMode = class("GameBoardPanelDragMode", function() return cc.Layer:create() end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()
local myWidth = visibleSize.width * 0.88
local myHeight = visibleSize.height * 0.5
local centerWidth = visibleSize.width * 0.5
local centerHeight = visibleSize.height * 0.5

local nColumn = 6
local nRow = 6
local nType = 5

local GameBoard = {}

local NORMAL_TAG = 10
local MATCH_TAG = 30
local SELECT_TAG = 40

local icons = {}

function GameBoardPanelDragMode.create()
    local panel = GameBoardPanelDragMode.new()
    panel:initPanel()
    return panel
end




--根据index创建某类型结点，不包含额外信息
local function createNodeByIndex(index)
    local iconNormalSprite = getGameIconSprite(GIconNormalType, index)
    local iconMatchSprite = getGameIconSprite(GIconMatchType, index)
    local iconSelectSprite = getGameIconSprite(GIconSelectType, index)

    iconNormalSprite:setTag(NORMAL_TAG)
    iconMatchSprite:setTag(MATCH_TAG)
    iconSelectSprite:setTag(SELECT_TAG)

    iconMatchSprite:setVisible(false)
    iconSelectSprite:setVisible(false)

    local iconNode = cc.Node:create()
    iconNode:addChild(iconNormalSprite)
    iconNode:addChild(iconMatchSprite)
    iconNode:addChild(iconSelectSprite)

    return iconNode
end

local icon1
local x = 0

function GameBoardPanelDragMode:update(delta)
    --print("update")
    
    
end

function GameBoardPanelDragMode:initPanel()

    --self:registerScriptUpdateHandler(update)
    --self:setUpdateEnabled(true)


    loadGameIcon()
    
    
  
    --self.scheduleUpdate()

    -- Create the BackgroundLayer
    local backgroundLayer = self:createBackgroundLayer()
    self:addChild(backgroundLayer)

    -- Create the TouchLayer
    local touchLayer = self:createTouchLayer()
    self:addChild(touchLayer)
    
    for i = 1, nRow do
        GameBoard[i] = {}
        icons[i] = {}
        for j = 1, nColumn do
            GameBoard[i][j] = 1
            icons[i][j] = {}
            for k = 1, nType do
                icons[i][j][k] = createNodeByIndex(k)
                icons[i][j][k]:setPosition(centerWidth - myWidth / 2 + (i-1) * 100, centerHeight - myHeight / 2 + (j-1) * 100)
                if k == GameBoard[i][j] then
                    icons[i][j][k]:setVisible(true)
                else
                    icons[i][j][k]:setVisible(false)
                end
                self.addChild(self,icons[i][j][k])
            end
        end
    end

end

-- Create the Background Layer for this panel

function GameBoardPanelDragMode:createBackgroundLayer()

    local backgroundColor = cc.c4b(99, 99, 99, 99)    
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(myWidth, myHeight)
    backgroundLayer:setPosition(centerWidth - myWidth / 2, centerHeight - myHeight / 2)



    return backgroundLayer
end

-- Create the Touch Layer for this panel

function GameBoardPanelDragMode:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height * 0.2)    -- 20% of the screen's height

    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
        local spriteSize = 64

        -- print("x:"..x.." y:"..y)



    end
    -- Register the touch handler and enable touch
    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)

    return touchLayer
end

return GameBoardPanelDragMode