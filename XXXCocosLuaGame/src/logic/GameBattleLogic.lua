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
end

-- TODO:these callback function should be replaced by the 
-- unified cfUseSkill(node, skillTable).

function cfDoDamage(node, damageValue)
    -- Do the damage to the monster
    node.monsterHP = node.monsterHP - damageValue[1]
    cclog("Monster HP: "..node.monsterHP)
end 

function cfDoHeal(node, healValue)
    -- Do the healing to the player
    
end

return GameBattleLogic