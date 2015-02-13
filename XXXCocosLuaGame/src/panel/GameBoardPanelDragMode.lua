--------------------------------------------------------------------------------
-- GameBoardPanelDragMode.lua 
-- @author Gaoyuan Chen
--------------------------------------------------------------------------------

require "manager.GameIcon"

local GameBoardPanelDragMode = class("GameBoardPanelDragMode", function() return cc.Layer:create() end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()
local myWidth = visibleSize.width * 0.88
local myHeight = visibleSize.height * 0.45
local centerWidth = visibleSize.width * 0.5
local centerHeight = visibleSize.height * 0.5
local iconSize = 150

local nColumn = 6
local nRow = 5
local nType = 5

local GameBoard = {}

local NORMAL_TAG = 10
local MATCH_TAG = 30
local SELECT_TAG = 40

local icons = {}
local iconsPosition = {}
local iconsTouch = {}

local nowTouch = false
local touchPosition = {}
local touchCell
local touchType
local touchOpacity = 150

function GameBoardPanelDragMode.create()
    local panel = GameBoardPanelDragMode.new()
    panel:initPanel()
    return panel
end


local function getCellCenter(i, j)
    local x = centerWidth - myWidth / 2 + (myWidth / nColumn) * (i - 0.5) 
    local y = centerHeight - myHeight / 2 + (myHeight / nRow) * (j - 0.5) 
    return {x = x, y = y}
end

local function positionToCell(x, y)
    for i = 1, nColumn do
        for j = 1, nRow do
            local cx = getCellCenter(i ,j).x
            local cy = getCellCenter(i ,j).y
            local xSize = (myWidth / nColumn) * 0.5
            local ySize = (myHeight / nRow) * 0.5
            if cx - xSize <= x and x <= cx + xSize then
                if cy - ySize <= y and y <= cy + ySize then
                    return {i=i, j=j}
                end
            end
        end
    end
    return nil
end


--根据index创建某类型结点，不包含额外信息
local function createNodeByIndex(index, opacity)
    local iconNormalSprite = getGameIconSprite(GIconNormalType, index)
    local iconMatchSprite = getGameIconSprite(GIconMatchType, index)
    local iconSelectSprite = getGameIconSprite(GIconSelectType, index)

    iconNormalSprite:setTag(NORMAL_TAG)
    iconMatchSprite:setTag(MATCH_TAG)
    iconSelectSprite:setTag(SELECT_TAG)
    
    iconNormalSprite:setScale(iconSize / iconNormalSprite:getContentSize().width, iconSize / iconNormalSprite:getContentSize().height)
    iconMatchSprite:setScale(iconSize / iconMatchSprite:getContentSize().width, iconSize / iconMatchSprite:getContentSize().height)
    iconSelectSprite:setScale(iconSize / iconSelectSprite:getContentSize().width, iconSize / iconSelectSprite:getContentSize().height)
    iconNormalSprite:setOpacity(opacity)
    iconMatchSprite:setVisible(false)
    iconSelectSprite:setVisible(false)

    

    local iconNode = cc.Node:create()
    iconNode:addChild(iconNormalSprite)
    iconNode:addChild(iconMatchSprite)
    iconNode:addChild(iconSelectSprite)
    
    iconNode.x = iconNormalSprite

    return iconNode
end

local icon1
local x = 0

local function abs(x)
    if x < 0 then
        return -x
    else
        return x
    end
end

function GameBoardPanelDragMode.update(delta)

    for i = 1, nColumn do
        for j = 1, nRow do
            local k = GameBoard[i][j]
            
            if iconsPosition[i][j].needChange then
                if abs(iconsPosition[i][j].current.x - iconsPosition[i][j].want.x) + abs(iconsPosition[i][j].current.y - iconsPosition[i][j].want.y) > 1e-6 then
                    local factor = 0.1
                    --iconsPosition[i][j].current.x = iconsPosition[i][j].current.x * (1 - factor) + iconsPosition[i][j].want.x * factor;
                    --iconsPosition[i][j].current.y = iconsPosition[i][j].current.y * (1 - factor) + iconsPosition[i][j].want.y * factor;
                    icons[i][j][k].x:setPosition(iconsPosition[i][j].current.x, iconsPosition[i][j].current.y)
                    print(iconsPosition[i][j].current.x .. " " .. iconsPosition[i][j].current.y)
                else
                    iconsPosition[i][j].needChange = false
                end
            end
            
            if touchCell ~= nil and i == touchCell.i and j == touchCell.j and nowTouch then
                icons[i][j][k].x:setOpacity(touchOpacity)
            else
                if icons[i][j][k].x ~= nil then
                    icons[i][j][k].x:setOpacity(255)
                end
            end
        end
    end
    
    for k = 1, nType do
        if nowTouch and touchType == k then
            iconsTouch[k]:setVisible(true)
            iconsTouch[k]:setPosition(touchPosition.x, touchPosition.y)
        else
            iconsTouch[k]:setVisible(false)
        end
    end
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
    
    for i = 1, nColumn do
        GameBoard[i] = {}
        icons[i] = {}
        iconsPosition[i] = {}
        for j = 1, nRow do
            math.randomseed(math.random(os.time()))
            GameBoard[i][j] = math.random(nType)
            icons[i][j] = {}
            
            iconsPosition[i][j] = {}
            iconsPosition[i][j].current = getCellCenter(i, j)
            iconsPosition[i][j].want = getCellCenter(i, j)
            iconsPosition[i][j].needChange = false
            
            for k = 1, nType do
                icons[i][j][k] = createNodeByIndex(k, 255)
                icons[i][j][k]:setPosition(getCellCenter(i,j).x, getCellCenter(i,j).y)
                if k == GameBoard[i][j] then
                    icons[i][j][k]:setVisible(true)
                else
                    icons[i][j][k]:setVisible(false)
                end
                self.addChild(self,icons[i][j][k])
            end
        end
    end
    
    for k = 1, nType do
        iconsTouch[k] = createNodeByIndex(k, touchOpacity)
        iconsTouch[k]:setVisible(false)
        self.addChild(self,iconsTouch[k])
    end
    
    self.onUpdateEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(self.update, 0, false)

end

-- Create the Background Layer for this panel

function GameBoardPanelDragMode:createBackgroundLayer()

    local backgroundColor = cc.c4b(99, 99, 99, 99)    
    local backgroundLayer = cc.LayerColor:create(backgroundColor)

    backgroundLayer:changeWidthAndHeight(myWidth, myHeight)
    backgroundLayer:setPosition(centerWidth - myWidth / 2, centerHeight - myHeight / 2)



    return backgroundLayer
end

local function fromTo(A, B)
    return {x = B.x - A.x, y = B.y - A.y}
end

-- Create the Touch Layer for this panel
local function swapCell(cellA, cellB)
    print("swap: "..cellA.i..","..cellA.j.." "..cellB.i..","..cellB.j)
    local i, j
    i, j = cellA.i, cellA.j
    print(i.." "..j.." "..GameBoard[i][j])
    icons[i][j][GameBoard[i][j]]:setVisible(false)
    i, j = cellB.i, cellB.j
    print(i.." "..j.." "..GameBoard[i][j])
    icons[i][j][GameBoard[i][j]]:setVisible(false)
    GameBoard[cellA.i][cellA.j], GameBoard[cellB.i][cellB.j] = GameBoard[cellB.i][cellB.j], GameBoard[cellA.i][cellA.j]
    i, j = cellA.i, cellA.j
    print(i.." "..j.." "..GameBoard[i][j])
    icons[i][j][GameBoard[i][j]]:setVisible(true)
    i, j = cellB.i, cellB.j
    print(i.." "..j.." "..GameBoard[i][j])
    icons[i][j][GameBoard[i][j]]:setVisible(true)

    iconsPosition[cellA.i][cellA.j].want = fromTo(getCellCenter(cellA.i,cellA.j), getCellCenter(cellB.i,cellB.j))
    iconsPosition[cellB.i][cellB.j].want = fromTo(getCellCenter(cellB.i,cellB.j), getCellCenter(cellA.i,cellA.j))
end

function GameBoardPanelDragMode:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height)

    local function onTouchBegin(x, y)
        local cell = positionToCell(x,y)
        if cell ~= nil then
            local i, j = cell.i, cell.j
            
            touchType = GameBoard[i][j]
            nowTouch = true
            touchPosition = {x = x, y = y}
            touchCell = {i = i, j = j}
            return true
        end
    end
    
    local function onTouchMove(x, y)
        local cell = positionToCell(x,y)
        if cell ~= nil then
            if abs(cell.i - touchCell.i) + abs(cell.j - touchCell.j) == 1 then
                swapCell(cell, touchCell)
                local i, j = cell.i, cell.j
                touchType = GameBoard[i][j]
                touchPosition = {x = x, y = y}
                touchCell = {i = i, j = j}
            end
        end
        touchPosition = {x = x, y = y}
        
        return true
    end
    
    local function onTouchEnd(x, y)
        nowTouch = false
        return true
    end

    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
        -- print("x:"..x.." y:"..y)
        --print (eventType.." "..x.." "..y)
        if eventType == "began" then   
            return onTouchBegin(x, y)
        elseif eventType == "moved" then
            return onTouchMove(x, y)
        elseif eventType == "ended" then
            return onTouchEnd(x, y)
        end

    end
    -- Register the touch handler and enable touch
    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)

    return touchLayer
end


function GameBoardPanelDragMode:doExit()
    cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.onUpdateEntry)
end


return GameBoardPanelDragMode