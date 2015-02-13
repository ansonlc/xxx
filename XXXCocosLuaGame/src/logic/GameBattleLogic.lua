--------------------------------------------------------------------------------
-- GameBattleLogci.lua
-- author: Chicheng Ren
-- Description:@field [parent=#logic.GameBattleLogic] #type name description
-- This GameBattleLogic Node manages all the game battle data (
--------------------------------------------------------------------------------

local GameBattleLogic = class("GameBattleLogic", function() return cc.Node:create() end)

function GameBattleLogic.create()
    local manager = GameBattleLogic.new()
    manager:initNode()
    return manager
end

function GameBattleLogic:initNode()
    -- Initialization
    self.monsterHP = 100
    self.runesTable = {["Water"] = 0, ["Wind"] = 0, ["Fire"] = 0, ["Earth"] = 0}
    self.crystalNum = 0
end

-- DoDamage function, should be later replaced by 
-- useSkill function
-- input: num
function GameBattleLogic:doDamage(damage)
    assert(damage, "Nil input in function: GameBattleLogic:doDamage()")
    self.monsterHP = self.monsterHP - damage
    cclog("Monster HP:"..self.monsterHP)
end

-- Update the runes table in the GameBattleLogic
-- Input: {["Water"] = num1, ["Fire"] = num2 ...}
function GameBattleLogic:updateRunesTable(runesTable)
    assert(runesTable, "Nil input in function: GameBattleLogic:updateRunesTable()")
    
    for k, v in pairs(runesTable) do 
        if self.runesTable[k] ~= nil then
            self.runesTable[k] = self.runesTable[k] + v
        end
    end
    
    -- Debug output
    for k, v in pairs(self.runesTable) do
        print (k,v)
    end
end

-- Get the runes table data
-- Return the runes table
function GameBattleLogic:getRunesTable()
    return self.runesTable
end

-- Update the crystal number
-- Input: num
function GameBattleLogic:updateCrystalNum(num)
    self.crystalNum = self.crystalNum + num
end

-- Get the crystal number
function GameBattleLogic:getCrystalNum()
    return self.crystalNum
end


return GameBattleLogic