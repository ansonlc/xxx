--------------------------------------------------------------------------------
-- GameBoardPanelCycle.lua - 游戏棋盘面板
-- @author chaomin.zhong
--------------------------------------------------------------------------------

require "logic.GameBoardLogic"
require "core.BaseScene"
require "config.CommonDefine"
--require "src/manager/ParticleManager.lua"

local GameBoardPanel = class("GameBoardPanel", function() return cc.Layer:create() end)
local particleTable =  require "src/config/particle_effect.lua"
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

local parentNode

function GameBoardPanel.create(parent)
    parentNode = parent
    local panel = GameBoardPanel.new()
    panel:initPanel()
    return panel
end

function GameBoardPanel:setTouch(flag)
    self.touchLayer:setTouchEnabled(flag)
end

function GameBoardPanel:initPanel()    
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
function GameBoardPanel:initGameBoardIcon()
    for x=1, GBoardSizeX do
        for y = 1, GBoardSizeY do
            local iconNode = createNodeByCell({x = x, y = y})
            self:addChild(iconNode)
        end
    end
end

--重置之前选中棋子的选中状态״̬
function GameBoardPanel:resetSelectGameIcon()
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
function GameBoardPanel:onClickGameIcon(cell)
    if cell.x == 0 or cell.y == 0 then
        return
    end

    self:resetSelectGameIcon()

    curSelectTag = 10 * cell.x + cell.y

    self:getChildByTag(NODE_TAG_START + curSelectTag):getChildByTag(NORMAL_TAG):setVisible(false)
    self:getChildByTag(NODE_TAG_START + curSelectTag):getChildByTag(SELECT_TAG):setVisible(true)

    AudioEngine.playEffect("sound/A_select.wav")
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
            if moveCellList[i] ~= nil then
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
    local fallCheckFunc = cc.CallFunc:create(cfCheckFallCell)           

    local arrayOfActions = {delay, fallCheckFunc}

    local sequence = cc.Sequence:create(arrayOfActions)

    FallEndCheckNode:runAction(sequence)
end

local function onCheckSuccess(succCellSet)
    isRefreshing = true
    --匹配成功
    cclog("switch success!!!")
    AudioEngine.playEffect("sound/A_combo1.wav")

    --获得邻近格子集合
    local matchCellSet = {}

    --用于检测是否已加入
    local assSet = {}
    for i = 1, #succCellSet do

        local succCell = succCellSet[i]
        
        local fromCellPoint = getCellCenterPoint(succCell)
        local name = nil
        
        --cc.p(165,1350)
        if GameBoard[succCell.x][succCell.y] == 1 then
                    --gameLogicNode.runesTable['Fire'] = gameLogicNode.runesTable['Fire'] + howMuch
            name = "Fire"
        end
        if GameBoard[succCell.x][succCell.y] == 2 then
            --gameLogicNode.runesTable['Earth'] = gameLogicNode.runesTable['Earth'] + howMuch
            name = "Earth"
        end

        if GameBoard[succCell.x][succCell.y] == 4 then
            --gameLogicNode.runesTable['Wind'] = gameLogicNode.runesTable['Wind'] + howMuch
            name = "Air"
        end
        if GameBoard[succCell.x][succCell.y] == 5 then
            --gameLogicNode.runesTable['Water'] = gameLogicNode.runesTable['Water'] + howMuch
            name = "Water"
        end
        if GameBoard[succCell.x][succCell.y] ~= 3 then
            local tmpNode = parentNode.battlePanel
            --:getRunePosition(name)
            local tmpPoint = tmpNode:getRunePosition(name)
            local toCellPoint = cc.p(tmpPoint.x, tmpPoint.y)
            ParticleManager.sysParticleDisplay(fromCellPoint, toCellPoint, parentNode, 0.3, 1000 + GameBoard[succCell.x][succCell.y])
            cclog("parent: CHILD COUNT"..parentNode:getChildrenCount())
        end
        
        local nearbySet = getNearbyCellSet(succCell)
        for i = 1, #nearbySet do
            local cell = nearbySet[i]
            if assSet[10 * cell.x + cell.y] == nil then
                assSet[10 * cell.x + cell.y] = true
                matchCellSet[#matchCellSet + 1] = cell
            end             
        end
    end
    -- getRunes
    
    local gameLogicNode = parentNode:getChildByName("GameBattleLogic")
    local updateTable = {fire = 0, earth = 0, air = 0, water = 0}
    for i = 1, #matchCellSet do
        if gameLogicNode ~= nil then
            if gameLogicNode.runesTable ~= nil then
                cell = matchCellSet[i]
                if GameBoard[cell.x][cell.y] == 1 then
                    --gameLogicNode.runesTable['Fire'] = gameLogicNode.runesTable['Fire'] + howMuch
                    updateTable.fire = updateTable.fire + 1
                end
                if GameBoard[cell.x][cell.y] == 2 then
                    --gameLogicNode.runesTable['Earth'] = gameLogicNode.runesTable['Earth'] + howMuch
                    updateTable.earth = updateTable.earth + 1
                end
                if GameBoard[cell.x][cell.y] == 4 then
                    --gameLogicNode.runesTable['Wind'] = gameLogicNode.runesTable['Wind'] + howMuch
                    updateTable.air = updateTable.air + 1
                end
                if GameBoard[cell.x][cell.y] == 5 then
                    --gameLogicNode.runesTable['Water'] = gameLogicNode.runesTable['Water'] + howMuch
                    updateTable.water = updateTable.water + 1
                end
                cclog(GameBoard[cell.x][cell.y])
            end
        end
    end
    for k, v in pairs(updateTable) do
        updateTable[k] = math.floor(updateTable[k] / 2)
    end
    gameLogicNode:updateRunesTable(updateTable)
    
    removeCellSet(matchCellSet)

    --延迟一段时间后刷新棋盘
    local delay = cc.DelayTime:create(0.2)
    local refreshBoardFunc = cc.CallFunc:create(cfRefreshBoard) 


    local arrayOfActions = {delay, refreshBoardFunc}

    local sequence = cc.Sequence:create(arrayOfActions)

    RefreshBoardNode:runAction(sequence)

end

--检测落下的棋子是否命中
function cfCheckFallCell()
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
    else
        isRefreshing = false
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
        cclog("switch failed...")

        --还原移动并清空交换区
        --board:switchCell(switchCellPair[1], switchCellPair[2], nil)
        --switchCellPair = {}
        AudioEngine.playEffect("sound/A_falsemove.wav")
    else
        onCheckSuccess(succCellSet)
    end
end

--背景层
function GameBoardPanel.createBackLayer()
    local backLayer = cc.Layer:create()
    local backSprite = cc.Sprite:create("imgs/game_bg.png")
    backSprite:setPosition(backSprite:getContentSize().width / 2, backSprite:getContentSize().height / 2)

    backLayer:addChild(backSprite)

    return backLayer
end

--触摸层
function GameBoardPanel:createTouchLayer()

    local touchColor = cc.c4b(255, 255, 255 ,0)
    local touchLayer = cc.LayerColor:create(touchColor)

    touchLayer:changeWidthAndHeight(visibleSize.width, visibleSize.height)

    local board = self
    isRefreshing = false
    local function onTouchBegan(x, y)
        --cclog("touchLayerBegan: %.2f, %.2f", x, y)
        isTouching = true
        touchStartPoint = {x = x, y = y}
        touchStartCell = touchPointToCell(x, y)
        --board:onClickGameIcon(touchStartCell)
        return true
    end
    
    local function onTouchMoved(x, y)
        --cclog("touchLayerMoved: %.2f, %.2f", x, y)
        if isRefreshing then
            return
        end
        local touchCurCell = touchPointToCell(x, y)

        if touchCurCell.x ~= 0 and touchCurCell.y ~= 0 and isTouching 
                and isLinearMoved(touchCurCell, touchStartCell) then
            isTouching = false
            board:movingCells(touchCurCell, touchStartCell, cfCheckSwitchCell)
        end
        return true
    end

    local function onTouchEnded(x, y)   
        cfCheckSwitchCell()
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


function GameBoardPanel:movingCells(cellA, cellB, cfCallBack)
    if isRefreshing then
        return
    end
    isRefreshing = true
    self:resetSelectGameIcon()
    touchStartCell = cellA
    local diff = 0
    local nodes = {}
    local nodesActions = {}
    --local nodes = {}
    --local nodesActions = {}
    nodes = {}
    nodesActions = {}
    local tags = {}
    local elem = {}
    local function resetIsTouchingCallback() 
        isTouching = true
        isRefreshing = false
    end

    local nodePnt = {}
    if cellA.y == cellB.y then
        diff = cellA.x - cellB.x
        --switchCellSet = {}
        for i = 1, GBoardSizeX do
            local cell = {}
            cell.x = i
            cell.y = cellA.y

            local tag = 10 * i + cellA.y
            local node = self:getChildByTag(NODE_TAG_START + tag)

            if node == nil then
                cclog("can't find node!!")
                return
            end
            local destCell = {}
            destCell.x = i + diff
            if destCell.x < 1 then
                destCell.x = destCell.x + GBoardSizeX
            end
            if destCell.x > GBoardSizeX then
                destCell.x = destCell.x - GBoardSizeX
            end
            destCell.y = cellA.y

            destCellPoint = getCellCenterPoint(destCell)
            local moveToDest = cc.MoveTo:create(0.1, destCellPoint)
            cclog("moveTosameY: "..destCellPoint.x.." "..destCellPoint.y)
            
            --node:runAction(moveToDest)
            --node:setPosition(destCellPoint)
            elem[destCell.x] = GameBoard[cell.x][cell.y]
            table.insert(tags, tag) 
            nodes[destCell.x] = node
            nodesActions[destCell.x] = moveToDest
            switchCellSet[#switchCellSet + 1] = cell
        end
        ---
        local arrayOfActions = {}
        table.insert(arrayOfActions, nodesActions[GBoardSizeX])

        local callBack = cc.CallFunc:create(resetIsTouchingCallback)
        table.insert(arrayOfActions, callBack)
        
        local sequence = cc.Sequence:create(arrayOfActions)
        nodesActions[GBoardSizeX] = sequence
        ---
        for j = 1, #nodes do
            nodes[j]:setTag(NODE_TAG_START + tags[j])
            GameBoard[j][cellA.y] = elem[j]
            nodes[j]:runAction(nodesActions[j])
            --
        end
        --resetIsTouchingCallback()
    elseif cellA.x == cellB.x then
        diff = cellA.y - cellB.y
        for i = 1, GBoardSizeY do
            local cell = {}
            cell.y = i
            cell.x = cellA.x

            local tag = 10 * cellA.x + i
            local node = self:getChildByTag(NODE_TAG_START + tag)

            if node == nil then
                cclog("can't find node!!")
                return
            end
            local destCell = {}
            destCell.y = i + diff
            if destCell.y < 1 then
                destCell.y = destCell.y + GBoardSizeY
            end
            if destCell.y > GBoardSizeY then
                destCell.y = destCell.y - GBoardSizeY
            end
            destCell.x = cellA.x

            destCellPoint = getCellCenterPoint(destCell)
            local moveToDest = cc.MoveTo:create(0.1, destCellPoint)
            cclog("moveTosameX: "..destCellPoint.x.." "..destCellPoint.y)
            
            --node:runAction(moveToDest)
            --node:setPosition(destCellPoint)
            elem[destCell.y] = GameBoard[cell.x][cell.y]
            table.insert(tags, tag) 
            nodes[destCell.y] = node
            nodesActions[destCell.y] = moveToDest
            switchCellSet[#switchCellSet + 1] = cell
        end
        local arrayOfActions = {}
        table.insert(arrayOfActions, nodesActions[GBoardSizeY])

        local callBack = cc.CallFunc:create(resetIsTouchingCallback)
        table.insert(arrayOfActions, callBack)
        
        local sequence = cc.Sequence:create(arrayOfActions)
        nodesActions[GBoardSizeX] = sequence
        for j = 1, #nodes do
            nodes[j]:setTag(NODE_TAG_START + tags[j])
            GameBoard[cellA.x][j] = elem[j]
            nodes[j]:runAction(nodesActions[j])
        end
        --resetIsTouchingCallback()
    end
end

return GameBoardPanel
