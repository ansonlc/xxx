--------------------------------------------------------------------------------
-- GameBattleLogci.lua
-- author: Chicheng Ren
-- Description:@field [parent=#logic.GameBattleLogic] #type name description
-- This GameBattleLogic Node manages all the game battle data (
--------------------------------------------------------------------------------

local GameBattleLogic = class("GameBattleLogic", function() return cc.Node:create() end)

function GameBattleLogic.create()
    local manager = GameBattleLogic.new()
    --manager:initNode()
    return manager
end

---
-- Init the logic node; Should be called after all the other panels are inited
-- @function [parent=#logic.GameBattleLogic] initNode
-- @param self
function GameBattleLogic:initNode()
    -- Initialization
    self.monsterHP = 100
    self.runesTable = {["Water"] = 50, ["Wind"] = 50, ["Fire"] = 50, ["Earth"] = 50}    -- currently all the runes start from 50
    self.crystalNum = 0
    
    -- Initialization for the GameSkillSlotPanel
    if self.gameSkillSlotPanel == nil then
        local panelNode = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")
        self.gameSkillSlotPanel = panelNode
    end
    assert(self.gameSkillSlotPanel, "Nil !!!")
    self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
end

--------------------------------
-- Use the skill passed by the GameSkillSlotPanel
-- @function [parent=#logic.GameBattleLogic] playerUseSkill
-- @param self 
-- @param skill type The skill activated by the player
function GameBattleLogic:playerUseSkill(skill)
    assert(skill, "Nil input in function GameBattleLogic:playerUseSkill")
    cclog(skill.name)
    if skill.effectType == "Attack" then
        self.monsterHP = self.monsterHP - skill.effectValue
        cclog("Monster current HP: "..self.monsterHP)
        self.runesTable["Water"] = self.runesTable["Water"] - skill.runeCostTable["Water"]
        self.runesTable["Wind"] = self.runesTable["Wind"] - skill.runeCostTable["Wind"]
        self.runesTable["Fire"] = self.runesTable["Fire"] - skill.runeCostTable["Fire"]
        self.runesTable["Earth"] = self.runesTable["Earth"] - skill.runeCostTable["Earth"]
        -- debug info for the current runes table
        for k, v in pairs(self.runesTable) do
            print (k,v)
        end
    end
end

---
-- Skill used by the monster AI
-- @function [parent=#logic.GameBattleLogic] monsterUseSkill
-- @param self
-- @param skill The skill activated by the monster
function GameBattleLogic:monsterUseSkill(skill)
    assert(skill, "Nil input in function GameBattleLogic:monsterUseSkill")
    cclog(skill.name)
end

---
-- Update the rune table in the Game BattleLogic; Add the a certain
-- of new runes into the GameBattleLogic
-- @function [parent=#logic.GameBattleLogic] updateRunesTable
-- @param self 
-- @param runesTable table Input: {["Water"] = num1, ["Fire"] = num2 ...}
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
    
    -- nofity the GameSkillSlotPanel to update the skill status
    if self.gameSkillSlotPanel == nil then
        self.gameSkillSlotPanel = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")
    end
    assert(self.gameSkillSlotPanel, "No SkillSlotManager found")
    self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
end

---
-- Get the runes table data; Return the runes table
-- @function [parent=#logic.GameBattleLogic] getRunesTable
-- @param self type description
-- @return #table runes table
function GameBattleLogic:getRunesTable()
    return self.runesTable
end

--- 
-- Update the crystal number
-- @function [parent=#logic.GameBattleLogic] updateCrystalNum
-- @param self
-- @param num number crystal number added
function GameBattleLogic:updateCrystalNum(num)
    self.crystalNum = self.crystalNum + num
end

---
-- Get the number of the crystal number
-- @function [parent=#logic.GameBattleLogic] getCrystalNum
-- @param self
-- @return #number crystal number
function GameBattleLogic:getCrystalNum()
    return self.crystalNum
end


return GameBattleLogic