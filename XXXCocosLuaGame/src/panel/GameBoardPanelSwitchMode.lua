--------------------------------------------------------------------------------
-- GameBoardPanelSwitchMode.lua - 游戏棋盘面板
-- @author fangzhou.long
--------------------------------------------------------------------------------

require "logic.GameBoardLogic"
require "core.BaseScene"

local GameBoardPanelSwitchMode = class("GameBoardPanelSwitchMode", function() return cc.Layer:create() end)

local curSelectTag = nil

local NODE_TAG_START = 10000
local NORMAL_TAG = 10
local MATCH_TAG = 30
local SELECT_TAG = 40

local REMOVED_TAG = 20000
local FALLING_TAG = 30000

local isTouching = false
local isMoving = false
local isRefreshing = false

local touchStartPoint = {}
local touchEndPoint = {}

local touchStartCell = {}
local touchEndCell = {}

local succCellSet = {}
local switchCellSet = {}
local fallCellSet = {}

--用于存储执行交换结点
local switchCellPair = {}

--执行各种函数的辅助node
local RefreshBoardNode = nil
local FallEndCheckNode = nil

local visibleSize = cc.Director:getInstance():getVisibleSize()

function GameBoardPanelSwitchMode.create()
    local panel = GameBoardPanelSwitchMode.new()
    panel:initPanel()
    return panel
end

function GameBoardPanelSwitchMode:setTouch(flag)
    self.touchLayer:setTouchEnabled(flag)
end

function GameBoardPanelSwitchMode:initPanel()    
    --loadGameIcon()
    initGameBoard()
    self:initGameBoardIcon()

    self.touchLayer = self:createTouchLayer()
    self:addChild(self.touchLayer, 1000)

    --创建用于延迟执行刷新棋盘函数的节点
    RefreshBoardNode = cc.Node:create()
    self:addChild(RefreshBoardNode)

    FallEndCheckNode = cc.Node:create()
    self:addChild(FallEndCheckNode)
end

--根据index创建某类型结点，不包含额外信息
local function createNodeByIndex(index)
    local iconNormalSprite = GameIconManager.getTileIconSprite(GIconNormalType, index)
    local iconMatchSprite = GameIconManager.getTileIconSprite(GIconMatchType, index)
    local iconSelectSprite = GameIconManager.getTileIconSprite(GIconSelectType, index)

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

--创建某个位置上的结点图标
local function createNodeByCell(cell)
    local index = GameBoard[cell.x][cell.y]
    local iconNode = createNodeByIndex(index)

    iconNode:setTag(NODE_TAG_START + 10 * cell.x + cell.y)

    local cellPoint = getCellCenterPoint(cell)
    iconNode:setPosition(cc.p(cellPoint.x, cellPoint.y))

    return iconNode
end

--初始化棋盘图标
function GameBoardPanelSwitchMode:initGameBoardIcon()
    for x=1, GBoardSizeX do
        for y = 1, GBoardSizeY do
            local iconNode = createNodeByCell({x = x, y = y})
            self:addChild(iconNode)
        end
    end
end

--重置之前选中棋子的选中状态״̬
function GameBoardPanelSwitchMode:resetSelectGameIcon()
    if curSelectTag ~= nil then
        local cellNode = self:getChildByTag(NODE_TAG_START + curSelectTag)
        if cellNode ~= nil then
            local normalSprite = cellNode:getChildByTag(NORMAL_TAG)
            local selectSprite = cellNode:getChildByTag(SELECT_TAG)
            if normalSprite ~= nil then 
                normalSprite:setVisible(true)
            end 

            if selectSprite ~= nil then
                selectSprite:setVisible(false)
            end
        end
        curSelectTag = nil
    end
end

--点击棋子更换图标效果
function GameBoardPanelSwitchMode:onClickGameIcon(cell)
    if cell.x == 0 or cell.y == 0 then
        return
    end

    self:resetSelectGameIcon()

    curSelectTag = 10 * cell.x + cell.y
    
    print("Cur select " .. curSelectTag)
    
    local thisCell = self:getChildByTag(NODE_TAG_START + curSelectTag)
    if thisCell then
        thisCell:getChildByTag(NORMAL_TAG):setVisible(false)
        thisCell:getChildByTag(SELECT_TAG):setVisible(true)
        AudioEngine.playEffect("sound/A_select.wav")
    end
end


--交换相邻棋子，并执行回调函数(一般为检测是否命中)
function GameBoardPanelSwitchMode:switchCell(cellA, cellB, cfCallBack)
    --cclog("switchCell...")
    --cclog("cellA.."..cellA.x.." "..cellA.y)
    --cclog("cellB.."..cellB.x.." "..cellB.y)
    isTouching = false

    self:resetSelectGameIcon()

    local tagA = 10 * cellA.x + cellA.y
    local tagB = 10 * cellB.x + cellB.y

    local cellPointA = getCellCenterPoint(cellA)
    local cellPointB = getCellCenterPoint(cellB)

    local nodeA = self:getChildByTag(NODE_TAG_START + tagA)
    local nodeB = self:getChildByTag(NODE_TAG_START + tagB)

    if nodeA == nil or nodeB == nil then
        cclog("can't find node!!")
        return
    end

    local moveToA = cc.MoveTo:create(0.1, cc.p(cellPointA.x, cellPointA.y)) 

    --将检测的回调函数绑定在A cell上
    local function moveAWithCallBack()

        local arrayOfActions = {}

        local moveToB = cc.MoveTo:create(0.1, cc.p(cellPointB.x, cellPointB.y))
        table.insert(arrayOfActions, moveToB)

        if cfCallBack ~= nil then
            --cclog("move with call back..")
            local callBack = cc.CallFunc:create(cfCallBack)

            table.insert(arrayOfActions, callBack)
        end

        local sequence = cc.Sequence:create(arrayOfActions)
        nodeA:runAction(sequence)
    end

    moveAWithCallBack()
    nodeB:runAction(moveToA)

    --swap tag
    nodeA:setTag(NODE_TAG_START + tagB)
    nodeB:setTag(NODE_TAG_START + tagA)

    --swap index
    GameBoard[cellA.x][cellA.y], GameBoard[cellB.x][cellB.y] = GameBoard[cellB.x][cellB.y], GameBoard[cellA.x][cellA.y]
end

--移除格子回调函数
local function cfRemoveSelf(matchSprite)
    --cclog("cf remove self")
    if matchSprite == nil then
        cclog("remove failed")
    else
        local parentNode = matchSprite:getParent()
        parentNode:removeFromParent()
    end
end

--变为匹配图标并渐隐回调
local function cfMatchAndFade(node)
    if node ~= nil then
        local normalSprite = node:getChildByTag(NORMAL_TAG)
        local matchSprite = node:getChildByTag(MATCH_TAG)
        local selectSprite = node:getChildByTag(SELECT_TAG)
        if normalSprite ~= nil then 
            normalSprite:setVisible(false)
        end 

        if selectSprite ~= nil then
            selectSprite:setVisible(false)
        end

        if matchSprite ~= nil then
            matchSprite:setVisible(true)
            
            local fade = cc.FadeOut:create(0.2)
            local removeFunc = cc.CallFunc:create(cfRemoveSelf)         

            local arrayOfActions = {fade, removeFunc}

            local sequence = cc.Sequence:create(arrayOfActions)

            matchSprite:runAction(sequence)
        end
    end
end

--将某个集合的格子渐隐并移除
local function removeCellSet(cellSet)
    for i = 1, #cellSet do
        --cclog("remove.."..cellSet[i].x.."  "..cellSet[i].y)
        local tag = 10 * cellSet[i].x + cellSet[i].y
        local board = cc.Director:getInstance():getRunningScene().gameBoard
        local node = board:getChildByTag(NODE_TAG_START + tag)

        --此时直接清除数据
        node:setTag(REMOVED_TAG + tag)
        GameBoard[cellSet[i].x][cellSet[i].y] = 0
        node:runAction(cc.CallFunc:create(cfMatchAndFade))
    end
end

--匹配消除后刷新游戏面板
local function cfRefreshBoard()
    --cclog("cfRefreshBoard..")
    local firstEmptyCell = nil
    local addCellList = nil
    local moveCellList = nil
    local board = cc.Director:getInstance():getRunningScene().gameBoard

    firstEmptyCell, addCellList, moveCellList = getRefreshBoardData()

    local actionNodeList = {}
    --遍历每一列
    for i = 1, GBoardSizeX do
        if firstEmptyCell[i] ~= nil then
            --cclog("firstEmptyCell.."..i..".."..firstEmptyCell[i].x..firstEmptyCell[i].y)
            local nextDesCell = {x = firstEmptyCell[i].x, y = firstEmptyCell[i].y}
            for j = 1, #(moveCellList[i]) do

                local cell = {x = moveCellList[i][j].x, y = moveCellList[i][j].y}
                --cclog("moveCellList"..i..".."..cell.x..cell.y)
                local tag = 10 * cell.x + cell.y
                local node = board:getChildByTag(NODE_TAG_START + tag)

                local desTag = 100 * GameBoard[cell.x][cell.y] + 10 * nextDesCell.x + nextDesCell.y
                node:setTag(FALLING_TAG + desTag)

                actionNodeList[#actionNodeList + 1] = {}
                actionNodeList[#actionNodeList][1] = node
                actionNodeList[#actionNodeList][2] = nextDesCell
                nextDesCell = {x = nextDesCell.x, y = nextDesCell.y + 1}
                --local desCell = 
            end

            for j = 1, #(addCellList[i]) do
                --cclog("addCellList"..i..".."..addCellList[i][j])

                local node = createNodeByIndex(addCellList[i][j])
                local bornPoint = getCellCenterPoint({x = i, y = 10})

                node:setPosition(cc.p(bornPoint.x, bornPoint.y))

                --新加的结点tag中包含自己的index信息
                local desTag = 100 * addCellList[i][j] + 10 * nextDesCell.x + nextDesCell.y
                node:setTag(FALLING_TAG + desTag)
                board:addChild(node)

                actionNodeList[#actionNodeList + 1] = {}
                actionNodeList[#actionNodeList][1] = node
                actionNodeList[#actionNodeList][2] = nextDesCell
                nextDesCell = {x = nextDesCell.x, y = nextDesCell.y + 1}
            end
        end     
    end

    --移动完毕后的回调函数
    local function cfOnFallDownEnd(node)
        --cclog("fall down end...")
        local tag = node:getTag() - FALLING_TAG
        --cclog("tag.."..tag)
        local index = math.modf(tag / 100)

        --提取并去除index信息
        tag = tag - index * 100
        local x = math.modf(tag / 10)
        local y = tag % 10

        GameBoard[x][y] = index
        --cclog("nowTag.."..tag)
        node:setTag(NODE_TAG_START + tag)
    end

    --执行下落到棋盘操作
    for i = 1, #actionNodeList do
        local node = actionNodeList[i][1]
        local desCell = actionNodeList[i][2]
        local desPos = getCellCenterPoint(desCell)
        local desPoint = cc.p(desPos.x, desPos.y)

        local move = cc.MoveTo:create(0.1, desPoint)
        local fallDownEndFunc = cc.CallFunc:create(cfOnFallDownEnd)         

        local arrayOfActions = {move, fallDownEndFunc}

        local sequence = cc.Sequence:create(arrayOfActions)

        node:runAction(sequence)

        --加入下落完成检测集合
        fallCellSet[#fallCellSet + 1] = desCell
    end

    actionNodeList = {}

    --下落后检查是否有新的命中
    local delay = cc.DelayTime:create(0.2)
    local fallCheckFunc = cc.CallFunc:create(cfSwitchCheckFallCell)           

    local arrayOfActions = {delay, fallCheckFunc}

    local sequence = cc.Sequence:create(arrayOfActions)

    FallEndCheckNode:runAction(sequence)
end

local boardlock = 0

local function onCheckSuccess(succCellSet)
    boardlock = boardlock + 1
    cclog(boardlock)
    if #succCellSet == 0 then
        return
    end

    --匹配成功
    --cclog("switch success!!!")
    AudioEngine.playEffect("sound/A_combo1.wav")

    --获得邻近格子集合
    local matchCellSet = {}

    --用于检测是否已加入
    local assSet = {}
    for i = 1, #succCellSet do
        local succCell = succCellSet[i]
        local nearbySet = getNearbyCellSet(succCell)
        for i = 1, #nearbySet do
            local cell = nearbySet[i]
            if assSet[10 * cell.x + cell.y] == nil then
                assSet[10 * cell.x + cell.y] = true
                matchCellSet[#matchCellSet + 1] = cell
            end             
        end
    end
    removeCellSet(matchCellSet)

    --延迟一段时间后刷新棋盘
    local delay = cc.DelayTime:create(0.2)
    local refreshBoardFunc = cc.CallFunc:create(cfRefreshBoard) 
    local unloackBoardFunc = cc.CallFunc:create(function()
        boardlock = boardlock - 1
        cclog(boardlock)
    end)

    local arrayOfActions = {delay, refreshBoardFunc, unloackBoardFunc}

    local sequence = cc.Sequence:create(arrayOfActions)

    RefreshBoardNode:runAction(sequence)
end

--检测落下的棋子是否命中
function cfSwitchCheckFallCell()
    cclog("cfCheckFallCell...")
    local boardMovable , succList= checkBoardMovable()

    --复制为局部变量
    local checkSet = {}
    for i = 1, #fallCellSet do
        checkSet[#checkSet + 1] = fallCellSet[i]
    end

    --重置全局table
    switchCellSet = {}

    --匹配成功的格子点
    succCellSet = {}
    for i = 1, #checkSet do
        if checkCell(checkSet[i]) then
            succCellSet[#succCellSet + 1] = checkSet[i]
        end
    end

    if #succCellSet ~= 0 then
        onCheckSuccess(succCellSet)
    end 
end

--检测互相交换的两个格子是否命中
local function cfCheckSwitchCell()
    --cclog("cfCheckSwitchCell...")

    local board = cc.Director:getInstance():getRunningScene().gameBoard

    --复制为局部变量
    local checkSet = {}
    for i = 1, #switchCellSet do
        checkSet[#checkSet + 1] = switchCellSet[i]
    end

    --重置全局table
    switchCellSet = {}

    if #checkSet < 2 then
        return
    end

    --匹配成功的格子点
    succCellSet = {}
    for i = 1, #checkSet do
        if checkCell(checkSet[i]) then
            succCellSet[#succCellSet + 1] = checkSet[i]
        end
    end

    if #succCellSet == 0 then
        --匹配失败
        --cclog("switch failed...")

        --还原移动并清空交换区
        board:switchCell(switchCellPair[1], switchCellPair[2], nil)
        switchCellPair = {}

        AudioEngine.playEffect("sound/A_falsemove.wav")
    else
        onCheckSuccess(succCellSet)
    end
end

--背景层
function GameBoardPanelSwitchMode.createBackLayer()
    local backLayer = cc.Layer:create()

    local backSprite = cc.Sprite:create("imgs/game_bg.png")
    backSprite:setPosition(backSprite:getContentSize().width / 2, backSprite:getContentSize().height / 2)

    backLayer:addChild(backSprite)

    return backLayer
end

--触摸层
function GameBoardPanelSwitchMode:createTouchLayer()

    local touchColor = cc.c4b(255, 255, 255 ,0)
    local touchLayer = cc.LayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height)

    local board = self

    local function onTouchBegan(x, y)
        --cclog("touchLayerBegan: %.2f, %.2f", x, y)
        isTouching = true
        touchStartPoint = {x = x, y = y}
        touchStartCell = touchPointToCell(x, y)
        if curSelectTag ~= nil then
            local curSelectCell = {x = math.modf(curSelectTag / 10), y = curSelectTag % 10}
            if isTwoCellNearby(curSelectCell, touchStartCell) then
                switchCellSet = {}
                switchCellSet[#switchCellSet + 1] = curSelectCell
                switchCellSet[#switchCellSet + 1] = touchStartCell

                switchCellPair[1] = curSelectCell
                switchCellPair[2] = touchStartCell
                board:switchCell(curSelectCell, touchStartCell, cfCheckSwitchCell)

                return true
            end
        end

        board:onClickGameIcon(touchStartCell)

        return true
    end

    local function onTouchMoved(x, y)
        --cclog("touchLayerMoved: %.2f, %.2f", x, y)
        local touchCurCell = touchPointToCell(x, y)
        if  isTouching then
            if isTwoCellNearby(touchCurCell, touchStartCell) then
                switchCellSet = {}
                switchCellSet[#switchCellSet + 1] = touchCurCell
                switchCellSet[#switchCellSet + 1] = touchStartCell

                switchCellPair[1] = touchCurCell
                switchCellPair[2] = touchStartCell
                board:switchCell(touchCurCell, touchStartCell, cfCheckSwitchCell)
            end
        end     
    end

    local function onTouchEnded(x, y)
        --cclog("touchLayerEnded: %.2f, %.2f", x, y)
        touchEndPoint = {x = x, y = y}
        touchEndCell = touchPointToCell(x, y)
        isTouching = false
    end


    local function onTouch(eventType, x, y)
        if eventType == "began" then   
            return onTouchBegan(x, y)
        elseif eventType == "moved" then
            return onTouchMoved(x, y)
        elseif eventType == "ended" then
            return onTouchEnded(x, y)
        end
        
    end

    touchLayer:registerScriptTouchHandler(onTouch)
    touchLayer:setTouchEnabled(true)

    return touchLayer
end

return GameBoardPanelSwitchMode
