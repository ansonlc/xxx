--------------------------------------------------------------------------------
-- GameBoardPanelDragMode.lua 
-- @author Gaoyuan Chen
--------------------------------------------------------------------------------

require "manager.GameIcon"

local GameBoardPanelDragMode = class("GameBoardPanelDragMode", function() return cc.Layer:create() end)

-- local variables
local visibleSize = cc.Director:getInstance():getVisibleSize()
local myWidth = visibleSize.width * 0.96 * 0.9
local myHeight = visibleSize.height * 0.45 * 0.9
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

local speedSwap = 20.0

local State_Waiting = 1
local State_Waiting_Countdown = 2
local State_Waiting_animation = 3
local State_Delete_animation = 4
local State_Falling = 5
local State = State_Waiting

local MP = 100
local MP_Bar
local CountDown = 100
local CountDown_Bar
local CountDownReduce = 100
local MP_RecoverPerSecond = 400

local MP_ReduceFirst = 10
local MP_ReduceNext = 1
local MP_ReducePerSecond = 10

local willDelete = {}
local noSwap = true

local mode1, mode2, mode3, mode4, mode5
local modes
local mode = 1

local skillAnimation1Horz
local skillAnimation1Vert
local skillAnimation2
local skillAnimation3

local animationList = {}
local animationTime = 0.1


local function setMode(i)
    if i == 1 then
        modes[mode]:setOpacity(100)
        modes[1]:setOpacity(255)
        MP_ReduceFirst = 10
        MP_ReduceNext = 1
        MP_ReducePerSecond = 10
    end
    if i == 2 then
        modes[mode]:setOpacity(100)
        modes[2]:setOpacity(255)
        MP_ReduceFirst = 10
        MP_ReduceNext = 10
        MP_ReducePerSecond = 40
    end
    if i == 3 then
        modes[mode]:setOpacity(100)
        modes[3]:setOpacity(255)
        MP_ReduceFirst = 0
        MP_ReduceNext = 0
        MP_ReducePerSecond = 0
    end
    if i == 4 then
        modes[mode]:setOpacity(100)
        modes[4]:setOpacity(255)
        MP_ReduceFirst = 60
        MP_ReduceNext = 0
        MP_ReducePerSecond = 10
    end
    if i == 5 then
        modes[mode]:setOpacity(100)
        modes[5]:setOpacity(255)
        MP_ReduceFirst = 100
        MP_ReduceNext = 100
        MP_ReducePerSecond = 100
    end
    mode = i
end

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
                
                animationList.n = animationList.n + 1
                animationList[animationList.n] = {}
                animationList[animationList.n].animation = skillAnimation1Vert
                animationList[animationList.n].x = getCellCenter(i,j).x
                animationList[animationList.n].y = getCellCenter(i,j).y
                
                willDelete[i][j] = true
                willDelete[i][j+1] = true
                willDelete[i][j+2] = true
            end
        end
    end
    for i = 1, nColumn - 2 do
        for j = 1, nRow do
            if GameBoard[i][j] == GameBoard[i+1][j] and GameBoard[i][j] == GameBoard[i+2][j] then
                
                animationList.n = animationList.n + 1
                animationList[animationList.n] = {}
                animationList[animationList.n].animation = skillAnimation1Horz
                animationList[animationList.n].x = getCellCenter(i,j).x
                animationList[animationList.n].y = getCellCenter(i,j).y
                
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
            
                animationList.n = animationList.n + 1
                animationList[animationList.n] = {}
                animationList[animationList.n].animation = skillAnimation2
                animationList[animationList.n].x = getCellCenter(i,j).x
                animationList[animationList.n].y = getCellCenter(i,j).y
                
                willDelete[i][j] = true
                willDelete[i][j+1] = true
                willDelete[i+1][j] = true
                willDelete[i+1][j+1] = true
            end
        end
    end
end



local Skill_Cross = function()
    for i = 1, nColumn - 2 do
        for j = 1, nRow - 2 do
            local t = GameBoard[i+1][j]
            if t == GameBoard[i+0][j+1] and t == GameBoard[i+1][j+1] and t == GameBoard[i+2][j+1] and t == GameBoard[i+1][j+2] then

                animationList.n = animationList.n + 1
                animationList[animationList.n] = {}
                animationList[animationList.n].animation = skillAnimation3
                animationList[animationList.n].x = getCellCenter(i,j).x
                animationList[animationList.n].y = getCellCenter(i,j).y

                willDelete[i+1][j] = true
                willDelete[i+0][j+1] = true
                willDelete[i+1][j+1] = true
                willDelete[i+2][j+1] = true
                willDelete[i+1][j+2] = true
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
    Skill_Cross()
    
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

local function touchEndFunction()
    local i, j = touchCell.i, touchCell.j
    icons[i][j][GameBoard[i][j]].x:setOpacity(255)
    nowTouch = false
    iconsTouch[touchType]:setVisible(false)
    noSwap = true
end

function GameBoardPanelDragMode.update(delta)
    
    if State == State_Waiting and nowTouch == false then
        MP = MP + delta * MP_RecoverPerSecond
        if MP > 100 then 
            MP = 100
        end
    end

    if nowTouch == true and (noSwap == false or State == State_Waiting_Countdown) then
        MP = MP - delta * MP_ReducePerSecond
        if MP < 0 then
            MP = 0
            touchEndFunction()
            State = State_Waiting_animation
        end
    end
    
    if State == State_Waiting_Countdown and nowTouch == false then
        CountDown = CountDown - delta * CountDownReduce
        if CountDown < 0 then
            CountDown = 0
            State = State_Waiting_animation
        end
    else
        CountDown = MP
    end
    
    MP_Bar:changeWidthAndHeight(myWidth * MP / 100, 20)
    CountDown_Bar:changeWidthAndHeight(myWidth * CountDown / 100, 20)
    
    
    
    if State == State_Waiting or State_Waiting_Countdown then
        
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
                animationList.current = 0
                animationList.remain = 0
                for i = 1, animationList.n do
                    local j = math.random(i, animationList.n)
                    animationList[i], animationList[j] = animationList[j], animationList[i] 
                end
            else
                State = State_Waiting
            end
        end
        
    end
    
    if State == State_Delete_animation then
        
        if animationList.current <= animationList.n then
            animationList.remain = animationList.remain - delta
            if animationList.remain <= 0 then
                if animationList.current > 0 then
                    animationList[animationList.current].animation:setVisible(false)
                end
                animationList.remain = animationTime
                animationList.current = animationList.current + 1
                if animationList.current <= animationList.n then
                    animationList[animationList.current].animation:setPosition(animationList[animationList.current].x, animationList[animationList.current].y)
                    animationList[animationList.current].animation:setVisible(true)
                end
            end
        end
        
        if animationList.current > animationList.n then
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
                animationList.n = 0
            end
            
            
            
        end
        
    end
    
    
    
    
end

function GameBoardPanelDragMode:initPanel()

    --self:registerScriptUpdateHandler(update)
    --self:setUpdateEnabled(true)
    
    loadGameIcon()
    
    animationList.n = 0
    
    --self.scheduleUpdate()
    
    -- Create the BackgroundLayer
    local backgroundLayer = self:createBackgroundLayer()
    self:addChild(backgroundLayer)

    -- Create the TouchLayer
    local touchLayer = self:createTouchLayer()
    self:addChild(touchLayer)
    
    MP_Bar = cc.LayerColor:create(cc.c4b(0, 100, 255, 200))
    MP_Bar:changeWidthAndHeight(myWidth, 20)
    MP_Bar:setPosition(centerWidth - myWidth / 2, centerHeight + myHeight / 2 + 20)
    self:addChild(MP_Bar)
    
    CountDown_Bar = cc.LayerColor:create(cc.c4b(255, 255, 255, 200))
    CountDown_Bar:changeWidthAndHeight(myWidth, 20)
    CountDown_Bar:setPosition(centerWidth - myWidth / 2, centerHeight + myHeight / 2 + 40)
    self:addChild(CountDown_Bar)
    
    local t
    skillAnimation1Horz = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))
    skillAnimation1Horz:setPosition(getCellCenter(2,1).x, getCellCenter(2,1).y)
    skillAnimation1Horz:setVisible(false)
    self:addChild(skillAnimation1Horz, 100)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation1Horz:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation1Horz:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (2 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation1Horz:addChild(t)
    
    
    skillAnimation1Vert = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))
    skillAnimation1Vert:setPosition(getCellCenter(3,3).x, getCellCenter(3,3).y)
    skillAnimation1Vert:setVisible(false)
    self:addChild(skillAnimation1Vert, 100)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation1Vert:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation1Vert:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 100, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (2 - 0.5))
    skillAnimation1Vert:addChild(t)

    
    skillAnimation2 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))
    skillAnimation2:setPosition(getCellCenter(4,4).x, getCellCenter(4,4).y)
    skillAnimation2:setVisible(false)
    self:addChild(skillAnimation2, 100)
    t = cc.LayerColor:create(cc.c4b(100, 100, 255, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation2:addChild(t)
    t = cc.LayerColor:create(cc.c4b(100, 100, 255, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation2:addChild(t)
    t = cc.LayerColor:create(cc.c4b(100, 100, 255, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation2:addChild(t)
    t = cc.LayerColor:create(cc.c4b(100, 100, 255, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation2:addChild(t)
    
    skillAnimation3 = cc.LayerColor:create(cc.c4b(0, 0, 0, 0))
    skillAnimation3:setPosition(getCellCenter(4,4).x, getCellCenter(4,4).y)
    skillAnimation3:setVisible(false)
    self:addChild(skillAnimation3, 100)
    t = cc.LayerColor:create(cc.c4b(255, 255, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (0 - 0.5))
    skillAnimation3:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 255, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (0 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation3:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 255, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation3:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 255, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (2 - 0.5), myWidth / nColumn * (1 - 0.5))
    skillAnimation3:addChild(t)
    t = cc.LayerColor:create(cc.c4b(255, 255, 100, 150))
    t:changeWidthAndHeight(myWidth / nColumn, myHeight / nRow)
    t:setPosition(myWidth / nColumn * (1 - 0.5), myWidth / nColumn * (2 - 0.5))
    skillAnimation3:addChild(t)
    
    
    mode1 = cc.Sprite:create("res/imgs/temp/Easy.png")
    mode1:setPosition(centerWidth - myWidth / 2 - 60 + 110 * 1, centerHeight - myHeight / 2 - 60)
    self:addChild(mode1)

    mode2 = cc.Sprite:create("res/imgs/temp/Hard.png")
    mode2:setPosition(centerWidth - myWidth / 2 - 60 + 110 * 2, centerHeight - myHeight / 2 - 60)
    mode2:setOpacity(100)
    self:addChild(mode2)

    mode3 = cc.Sprite:create("res/imgs/temp/INF.png")
    mode3:setPosition(centerWidth - myWidth / 2 - 60 + 110 * 3, centerHeight - myHeight / 2 - 60)
    mode3:setOpacity(100)
    self:addChild(mode3)

    mode4 = cc.Sprite:create("res/imgs/temp/PAD.png")
    mode4:setPosition(centerWidth - myWidth / 2 - 60 + 110 * 4, centerHeight - myHeight / 2 - 60)
    mode4:setOpacity(100)
    self:addChild(mode4)

    mode5 = cc.Sprite:create("res/imgs/temp/Switch.png")
    mode5:setPosition(centerWidth - myWidth / 2 - 60 + 110 * 5, centerHeight - myHeight / 2 - 60)
    mode5:setOpacity(100)
    self:addChild(mode5)

    modes = {mode1, mode2, mode3, mode4, mode5}
    
    
    for i = 1, nColumn do
        willDelete[i] = {}
        for j = 1, nRow do
            willDelete[i][j] = false
        end
    end
        
    local ok = false
    while ok == false do
        for i = 1, nColumn do
            GameBoard[i] = {}
            for j = 1, nRow do
                GameBoard[i][j] = math.random(nType)
            end
        end
        if haveDelete() == false then
            ok = true
        end
    end
    
    for i = 1, nColumn do
        icons[i] = {}
        iconsPosition[i] = {}
        for j = 1, nRow do
            math.randomseed(math.random(os.time()))
            --
            icons[i][j] = {}
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
        for i = 1, 5 do
            local cx = centerWidth - myWidth / 2 - 60 + 110 * i
            local cy = centerHeight - myHeight / 2 - 60
            if cx - 50 < x and x < cx + 50 and cy - 50 < y and y < cy + 50 then
                setMode(i)
            end
        end
    
    
        if (State == State_Waiting or State == State_Waiting_Countdown) and MP >= MP_ReduceFirst then
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
    end
    
    local function onTouchMove(x, y)
        if (State == State_Waiting or State == State_Waiting_Countdown) and nowTouch then
            cell = getTargetCell(x, y)
            if cell ~= nil then
            
                local cost = 0
                if noSwap then
                    cost = MP_ReduceFirst
                else
                    cost = MP_ReduceNext
                end
                if MP >= cost then
                    MP = MP - cost
                    noSwap = false
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

            end
            touchPosition = {x = x, y = y}
            
            return true
        end
        
    end
    
    local function onTouchEnd(x, y)
        if (State == State_Waiting or State == State_Waiting_Countdown) and nowTouch then
            if State == State_Waiting and noSwap == false then
                State = State_Waiting_Countdown
            end
            touchEndFunction()
            return true
        end
        
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