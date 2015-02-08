--------------------------------------------------------------------------------
-- GameBattleLogci.lua
-- author: Chicheng Ren
--------------------------------------------------------------------------------

local GameBattleLogic = class("GameBattleLogic", function() return cc.Node:create() end)

-- Monster data
local monsterHP = 100

function GameBattleLogic.create()
    local manager = GameBattleLogic.new()
    manager:initNode()
    return manager
end

function GameBattleLogic:initNode()
    -- Initialization
    monsterHP = 100
end

function GameBattleLogic:cfDoDamage(damage)
    -- Do the damage to the monster
    monsterHP = monsterHP - damage
    print("Current monster HP: "..mosterHP)
end 

return GameBattleLogic