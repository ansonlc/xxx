--------------------------------------------------------------------------------
-- GameBattleLogci.lua
-- author: Chicheng Ren
-- Description:@field [parent=#logic.GameBattleLogic] #type name description
-- This GameBattleLogic Node manages all the game battle data (
--------------------------------------------------------------------------------
require "manager.EffectManager.lua"
require "manager.MonsterManager.lua"

local GameBattleLogic = class("GameBattleLogic", function() return cc.Node:create() end)

function GameBattleLogic.create()
    local manager = GameBattleLogic.new()
    return manager
end

---
-- Init the logic node; Should be called after all the other panels are inited
-- @function [parent=#logic.GameBattleLogic] initNode
-- @param self
function GameBattleLogic:initNode()
    -- Initialization
    self.runesTable = {water = 3, air = 3, fire = 3, earth = 3}    -- currently all the runes start from 50
    self.crystalNum = 0
    
    -- Initialization for the GameSkillSlotPanel
    if self.gameSkillSlotPanel == nil then
        self.gameSkillSlotPanel = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")
    end
    assert(self.gameSkillSlotPanel, "Nil !!!")
    self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
end

---
-- Initialize the monster info
-- @function [parent=#logic.GameBattleLogic] initMonster
-- @param monsterID num ID of the monster
function GameBattleLogic:initMonster(monsterID)
    -- Get the monster from the manager and set the monster HP
    self.monster = MonsterManager.getMonster(monsterID)
    assert(self.monster, "Nil Monster !")
    self.monsterMaxHP = self.monster.monsterHP
    self.monsterHP = self.monster.monsterHP
end

--------------------------------
-- Use the skill passed by the GameSkillSlotPanel
-- @function [parent=#logic.GameBattleLogic] playerUseSkill
-- @param self 
-- @param skill type The skill activated by the player
function GameBattleLogic:playerUseSkill(skill)
    assert(skill, "Nil input in function GameBattleLogic:playerUseSkill")
    cclog(skill.skillName)
    if self.isGameOver ~= nil and self.isGameOver then
        cclog("The monster is already dead, please be a nice person!")
        return
    end
    
    if skill.effectTable ~= nil then
        -- Go through all the three effects
        if skill.effectTable.effectID1 ~= nil then
            local effect1 = EffectManager.getEffect(skill.effectTable.effectID1)
            assert(effect1, "Nil effect id")
            -- TODO: take the property into account
            if effect1.effectType == 'Attack' then
                self.monsterHP = self.monsterHP - 10
                self.runesTable.water = self.runesTable.water - skill.runeCostTable.water
                self.runesTable.air= self.runesTable.air - skill.runeCostTable.air
                self.runesTable.fire = self.runesTable.fire - skill.runeCostTable.fire
                self.runesTable.earth = self.runesTable.earth - skill.runeCostTable.earth
                -- pass this hit event to the GameBattlePanel
                if self.gameBattlePanel == nil then
                    self.gameBattlePanel = self:getParent():getChildByName("GameBattlePanel")
                end
                assert(self.gameBattlePanel, "Nil in self.gameBattlePanel")
                self.gameBattlePanel:doDamageToMonster(10)
            end
        end
        
        if self.monsterHP <= 0 then
            self.gameBattlePanel:monsterIsDefeated()
            self.isGameOver = true
        end
        
        -- nofity the GameSkillSlotPanel to update the skill status
        if self.gameSkillSlotPanel == nil then
            self.gameSkillSlotPanel = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")
        end
        assert(self.gameSkillSlotPanel, "No SkillSlotManager found")
        self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
    end
end

---
-- Skill used by the monster AI
-- @function [parent=#logic.GameBattleLogic] monsterUseSkill
-- @param self
-- @param skill The skill activated by the monster
function GameBattleLogic:monsterUseSkill(skill)
    assert(skill, "Nil input in function GameBattleLogic:monsterUseSkill")
    --cclog(skill.name)
end


---
-- Update the rune table in the Game BattleLogic; Add the a certain
-- of new runes into the GameBattleLogic
-- @function [parent=#logic.GameBattleLogic] updateRunesTable
-- @param self 
-- @param runesTable table Input: {water = num1, fire = num2 ...}
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