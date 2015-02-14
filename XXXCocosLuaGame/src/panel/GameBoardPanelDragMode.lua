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

local speedSwap = 10.0

local State_Waiting = 1
local State_Waiting_animation = 2
local State_Delete_animation = 3
local State_Falling = 4
local State = State_Waiting

local willDelete = {}

local function fromTo(A, B)
    return {x = B.x - A.x, y = B.y - A.y}
end

local function getCellCenter(i, j)
    local x = centerWidth - myWidth / 2 + (myWidth / nColumn) * (i - 0.5) 
    local y = centerHeight - myHeight / 2 + (myHeight / nRow) * (j - 0.5) 
    return {x = x, y = y}
end

local function falling()
    
    --icons[i][j][GameBoard[i][j]]:setVisible(false)

    for i = 1, nColumn do
        local t_position = {}
        local t_Type = {}
        local now = 0
        for j = 1, nRow do
            icons[i][j][GameBoard[i][j]]:setVisible(false)
            if willDelete[i][j] == false then
                now = now + 1
                t_position[now] = getCellCenter(i,j)
                t_Type[now] = GameBoard[i][j]
            end
        end
        while now < nRow do
            now = now + 1
            t_position[now] = getCellCenter(i,nRow + 1)
            t_Type[now] = math.random(nType)
        end
        for j = 1, nRow do
            GameBoard[i][j] = t_Type[j]
            icons[i][j][GameBoard[i][j]]:setVisible(true)
            iconsPosition[i][j].needChange = true
            iconsPosition[i][j].current = fromTo(getCellCenter(i,j), t_position[j])
            icons[i][j][GameBoard[i][j]].x:setPosition(iconsPosition[i][j].current.x, iconsPosition[i][j].current.y)
            
        end
    end
    
    for i = 1, nColumn do
        for j = 1, nRow do
            local k = GameBoard[i][j]
            icons[i][j][k].x:setOpacity(255)
        end
    end
    
    State = State_Waiting
end

local Skill_Three = function()
    for i = 1, nColumn do
        for j = 1, nRow - 2 do
            if GameBoard[i][j] == GameBoard[i][j+1] and GameBoard[i][j] == GameBoard[i][j+2] then
                willDelete[i][j] = true
                willDelete[i][j+1] = true
                willDelete[i][j+2] = true
            end
        end
    end
    for i = 1, nColumn - 2 do
        for j = 1, nRow do
            if GameBoard[i][j] == GameBoard[i+1][j] and GameBoard[i][j] == GameBoard[i+2][j] then
                willDelete[i][j] = true
                willDelete[i+1][j] = true
                willDelete[i+2][j] = true
            end
        end
    end
end

local Skill_2by2 = function()
    for i = 1, nColumn - 1 do
        for j = 1, nRow - 1 do
            if GameBoard[i][j] == GameBoard[i][j+1] and GameBoard[i][j] == GameBoard[i+1][j] and GameBoard[i][j] == GameBoard[i+1][j+1] then
                willDelete[i][j] = true
                willDelete[i][j+1] = true
                willDelete[i+1][j] = true
                willDelete[i+1][j+1] = true
            end
        end
    end
end

local function haveDelete()
    for i = 1, nColumn do
        for j = 1, nRow do
            willDelete[i][j] = false
        end
    end
    
    Skill_Three()
    Skill_2by2()
    
    local ret = false
    for i = 1, nColumn do
        for j = 1, nRow do
            if willDelete[i][j] then
                ret = true
            end
        end
    end
    
    return ret
end

function GameBoardPanelDragMode.create()
    local panel = GameBoardPanelDragMode.new()
    panel:initPanel()
    return panel
end



local function positionToCell(x, y)
    if x < centerWidth - myWidth / 2 or x > centerWidth + myWidth / 2 or y < centerHeight - myHeight / 2 or y > centerHeight + myHeight / 2 then
        return nil
    end
    
    local i = math.floor((x - (centerWidth - myWidth / 2)) / (myWidth / nColumn)) + 1
    local j = math.floor((y - (centerHeight - myHeight / 2)) / (myHeight / nRow)) + 1
    i = math.max(1, math.min(i, nColumn))
    j = math.max(1, math.min(j, nRow))
    return {i = i, j = j}
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

    if State == State_Waiting then
        
        for i = 1, nColumn do
            for j = 1, nRow do
                local k = GameBoard[i][j]
                
                if iconsPosition[i][j].needChange then
    
                    if abs(iconsPosition[i][j].current.x) + abs(iconsPosition[i][j].current.y) > 3 then
                        local factor = 0.5 ^ (delta * speedSwap)
                        iconsPosition[i][j].current.x = iconsPosition[i][j].current.x * factor
                        iconsPosition[i][j].current.y = iconsPosition[i][j].current.y * factor
                        icons[i][j][k].x:setPosition(iconsPosition[i][j].current.x, iconsPosition[i][j].current.y)
                    else
                        iconsPosition[i][j].needChange = false
                        icons[i][j][k].x:setPosition(0, 0)
                    end
                end
            end
        end
        
        if nowTouch then
            local k = touchType
            iconsTouch[k]:setVisible(true)
            iconsTouch[k]:setPosition(touchPosition.x, touchPosition.y)
        end
    end
    
    
    if State == State_Waiting_animation then
        local haveNotFinish = false
        
        for i = 1, nColumn do
            for j = 1, nRow do
                local k = GameBoard[i][j]

                if iconsPosition[i][j].needChange then

                    if abs(iconsPosition[i][j].current.x) + abs(iconsPosition[i][j].current.y) > 3 then
                        local factor = 0.5 ^ (delta * speedSwap)
                        iconsPosition[i][j].current.x = iconsPosition[i][j].current.x * factor
                        iconsPosition[i][j].current.y = iconsPosition[i][j].current.y * factor
                        icons[i][j][k].x:setPosition(iconsPosition[i][j].current.x, iconsPosition[i][j].current.y)
                    else
                        iconsPosition[i][j].needChange = false
                        icons[i][j][k].x:setPosition(0, 0)
                    end
                end
                
                if iconsPosition[i][j].needChange then
                    haveNotFinish = true
                end
            end
        end
        
        if haveNotFinish == false then
            if haveDelete() then
                State = State_Delete_animation
            else
                State = State_Waiting
            end
        end
        
    end
    
    if State == State_Delete_animation then
        local haveNotFinish = false
        for i = 1, nColumn do
            for j = 1, nRow do
                local k = GameBoard[i][j]
                if willDelete[i][j] then
                    if(icons[i][j][k].x:getOpacity() > 0) then
                        haveNotFinish = true
                        icons[i][j][k].x:setOpacity(math.max(0, icons[i][j][k].x:getOpacity() - delta * 1000))
                    end
                end
            end
        end
        if haveNotFinish == false then
            falling()
            State = State_Waiting_animation
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
        willDelete[i] = {}
        for j = 1, nRow do
            math.randomseed(math.random(os.time()))
            GameBoard[i][j] = math.random(nType)
            icons[i][j] = {}
            willDelete[i][j] = false
            iconsPosition[i][j] = {}
            iconsPosition[i][j].current = {x = 0, y = 0}
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



-- Create the Touch Layer for this panel
local function swapCell(cellA, cellB)
    --print("swap: "..cellA.i..","..cellA.j.." "..cellB.i..","..cellB.j)
    local i, j
    i, j = cellA.i, cellA.j
    icons[i][j][GameBoard[i][j]]:setVisible(false)
    i, j = cellB.i, cellB.j
    icons[i][j][GameBoard[i][j]]:setVisible(false)
    GameBoard[cellA.i][cellA.j], GameBoard[cellB.i][cellB.j] = GameBoard[cellB.i][cellB.j], GameBoard[cellA.i][cellA.j]
    i, j = cellA.i, cellA.j
    icons[i][j][GameBoard[i][j]]:setVisible(true)
    i, j = cellB.i, cellB.j
    icons[i][j][GameBoard[i][j]]:setVisible(true)

    iconsPosition[cellA.i][cellA.j].current = fromTo(getCellCenter(cellA.i,cellA.j), getCellCenter(cellB.i,cellB.j))
    iconsPosition[cellB.i][cellB.j].current = fromTo(getCellCenter(cellB.i,cellB.j), getCellCenter(cellA.i,cellA.j))
    iconsPosition[cellA.i][cellA.j].needChange = true
    iconsPosition[cellB.i][cellB.j].needChange = true
    
end

local function getTargetCell(x, y)
    if x < centerWidth - myWidth * 0.5 then
        x = centerWidth - myWidth * 0.5
    end
    if x > centerWidth + myWidth * 0.5 then
        x = centerWidth + myWidth
    end
    if y < centerHeight - myHeight * 0.5 then
        y = centerHeight - myHeight * 0.5
    end
    if y > centerHeight + myHeight * 0.5 then
        y = centerHeight + myHeight * 0.5
    end

    
    local d = {x = x - getCellCenter(touchCell.i,touchCell.j).x, y = y - getCellCenter(touchCell.i,touchCell.j).y}
    if abs(d.x) <= iconSize / 2 * 1.2 and abs(d.y) <= iconSize / 2 * 1.2 then
        return nil
    end
    local dx = {-1, 0, 1, -1, 1, -1, 0, 1}
    local dy = {-1, -1, -1, 0, 0, 1, 1, 1}
    local maximalProd = -1
    local which = 0
    for i = 1,8 do
       local prod = d.x * dx[i] + d.y * dy[i]
       if abs(dx[i]) + abs(dy[i]) == 2 then
            prod = prod / 2^0.5
       end
       if prod > maximalProd then
            maximalProd = prod
            which = i
       end
    end
    local i = touchCell.i + dx[which]
    local j = touchCell.j + dy[which]
    if 1 <= i and i <= nColumn and 1 <= j and j <= nRow then
        return {i = i, j = j}
    end
    return nil
end

function GameBoardPanelDragMode:createTouchLayer()
    local touchColor = cc.c4b(255, 255, 255, 0)
    local touchLayer = cc.LayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height)

    local function onTouchBegin(x, y)
        if State == State_Waiting then
            local cell = positionToCell(x,y)
            if cell ~= nil then
                local i, j = cell.i, cell.j
                local k = GameBoard[i][j]
                icons[i][j][k].x:setOpacity(touchOpacity)
                
                touchType = GameBoard[i][j]
                nowTouch = true
                touchPosition = {x = x, y = y}
                touchCell = {i = i, j = j}
                return true
            end
        end
        return false
        
    end
    
    local function onTouchMove(x, y)
    
        if State == State_Waiting then
            cell = getTargetCell(x, y)
            if cell ~= nil then
                swapCell(cell, touchCell)
                
                local i, j = touchCell.i, touchCell.j
                local k = GameBoard[i][j]
                icons[i][j][k].x:setOpacity(255)
                
                local i, j = cell.i, cell.j
                touchType = GameBoard[i][j]
                touchPosition = {x = x, y = y}
                touchCell = {i = i, j = j}
                
                local i, j = touchCell.i, touchCell.j
                local k = GameBoard[i][j]
                icons[i][j][k].x:setOpacity(255)

            end
            touchPosition = {x = x, y = y}
            
            return true
        end
        return false
    end
    
    local function onTouchEnd(x, y)
        if State == State_Waiting then
            local i, j = touchCell.i, touchCell.j
            local k = GameBoard[i][j]
            icons[i][j][k].x:setOpacity(255)
            
            nowTouch = false
            iconsTouch[touchType]:setVisible(false)
            
            State = State_Waiting_animation
            
            return true
        end
        return false
    end
    
    -- Implementation of the Touch Event
    local function onTouch(eventType, x, y)
        -- TODO To be Implemented
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