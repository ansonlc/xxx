--------------------------------------------------------------------------------
-- GameBattleLogci.lua
-- author: Chicheng Ren
-- Description:@field [parent=#logic.GameBattleLogic] #type name description
-- This GameBattleLogic Node manages all the game battle data (
--------------------------------------------------------------------------------

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
    self.runesTable = {water = 5, air = 5, fire = 5, earth = 5}    -- currently all the runes start from 5
    self.crystalNum = 0
    self.playerMaxHP = 500
    self.playerHP = self.playerMaxHP
    self.playerWins = nil
    -- Statistics for the whole battle
    self.skillUsedCount = {}
    self.runeCollectStat = {water = 0, air = 0, fire = 0, earth = 0}
    self.battleDuration = 0
    self.damageCausedByMonster = 0
    self.damageCausedByPlayer = 0
    -- Buff/Debuff Table
    self.effectTable = {
        silence = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0},
        heal = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0},
        bless = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0},
        curse = {effectValue = 0, effectTimeCount = 0, effecTimeToLive = 0},
        bravery = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0},
        fear = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0},
        bleed = {effectValue = 0, effectTimeCount = 0, effectTimeToLive = 0}}
    -- Shield Ability
    self.shieldEnergy = nil
    -- Initialization for the GameSkillSlotPanel
    if self.gameSkillSlotPanel == nil then
        self.gameSkillSlotPanel = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")
    end
    assert(self.gameSkillSlotPanel, "Nil in function GameBattleLogic:initNode()")
    self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
    
    -- Initialization for the GameBattlePanel
    if self.gameBattlePanel == nil then
        self.gameBattlePanel = self:getParent():getChildByName("GameBattlePanel")
    end
    assert(self.gameBattlePanel, "Nil in function GameBattleLogic:initNode()")
    self.gameBattlePanel:updateRuneNum(self.runesTable)
    
end

---
-- Initialize the monster info
-- @function [parent=#logic.GameBattleLogic] initMonster
-- @param monsterID num ID of the monster
function GameBattleLogic:initMonster(monsterID)
    -- Get the monster from the manager and set the monster HP
    self.monster = MetaManager.getMonster(monsterID)
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
        
    -- For statistics
    if self.skillUsedCount[skill.skillID] == nil then
        self.skillUsedCount[skill.skillID] = 0
    else
        self.skillUsedCount[skill.skillID] = self.skillUsedCount[skill.skillID] + 1
    end
    
    -- Decrease the rune number
    self.runesTable.water = self.runesTable.water - skill.runeCostTable.water
    self.runesTable.air= self.runesTable.air - skill.runeCostTable.air
    self.runesTable.fire = self.runesTable.fire - skill.runeCostTable.fire
    self.runesTable.earth = self.runesTable.earth - skill.runeCostTable.earth
    
    if skill.effectTable ~= nil then
        -- Go through all the three effects
        -- Skill Effect 1
        local damage = 0
        if skill.effectTable.effectID1 ~= nil then
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            assert(effect1, "Nil effect id")
            local effect1Result = self:playerApplyEffect(effect1, skill.effectTable.effectValue1)
            if effect1.effectType == 'Attack' then
                damage = damage + effect1Result
            end
        end
        -- Skill Effect 2
        if skill.effectTable.effectID2 ~= nil then
            local effect2 = MetaManager.getEffect(skill.effectTable.effectID2)
            assert(effect2, "Nil effect id")
            local effect2Result = self:playerApplyEffect(effect2, skill.effectTable.effectValue2) 
            if effect2.effectType == 'Attack' then
                damage = damage + effect2Result
            end
        end       
        -- Skill Effect 3
        if skill.effectTable.effectID3 ~= nil then
            local effect3 = MetaManager.getEffect(skill.effectTable.effectID3)
            assert(effect3, "Nil effect id")
            local effect3Result = self:playerApplyEffect(effect3, skill.effectTable.effectValue3) 
            if effect3.effectType == 'Attack' then
                damage = damage + effect3Result
            end
        end
                  
        -- For statistics
        self.damageCausedByPlayer = self.damageCausedByPlayer + damage
        
        -- decrease the monster HP
        self.monsterHP = self.monsterHP - damage
        if self.monsterHP <= 0 then
            self.gameBattlePanel:monsterIsDefeated()
            self.playerWins = true
        end
        
        if self.monsterHP >= self.monsterMaxHP then
            self.monsterHP = self.monsterMaxHP
        end
        
        -- nofity the GameSkillSlotPanel to update the skill status
        assert(self.gameSkillSlotPanel, "No SkillSlotManager found")
        self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
        
        -- notify the GameBattlePanel to update the rune text
        assert(self.gameBattlePanel, "Nil GameBattlePanel in function: GameBattleLogic:updateRunesTable()")
        self.gameBattlePanel:updateRuneNum(self.runesTable)
        self.gameBattlePanel:doDamageToMonster(damage)
        
        if self.playerWins ~= nil and self.playerWins then
            self:outputBattleStats()
            -- TODO: Pass the correct params to the result scene
            SceneManager.replaceSceneWithName("ResultScene","Test")
            return
        end
    end
end

function GameBattleLogic:playerApplyEffect(effect, effectValue)
    local result = 0
    if effect.effectType == 'Attack' then
        result = self:calculatePlayerAttackPoint(effect.elementProperty,effectValue,self.monster)
    end
    return result
end    

---
-- Skill used by the monster AI
-- @function [parent=#logic.GameBattleLogic] monsterUseSkill
-- @param self
-- @param skill The skill activated by the monster
function GameBattleLogic:monsterUseSkill(skill)
    assert(skill, "Nil input in function GameBattleLogic:monsterUseSkill")
    --cclog(skill.skillName)
    -- If the player lost the game
    -- TODO: should change to other scene
    if self.playerWins ~= nil and not self.playerWins then
        -- TODO: Pass the correct params to the ending scene
        return
    end
    local damage = 0
    
    if skill.effectTable ~= nil then
        -- Go through all the three effects
        -- Skill Effect 1
        if skill.effectTable.effectID1 ~= nil then
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            assert(effect1, "Nil effect id")
            if effect1.effectType == 'Attack' then
                damage = damage + skill.effectTable.effectValue1
            end
        end
        -- Skill Effect 2
        if skill.effectTable.effectID2 ~= nil then
            local effect2 = MetaManager.getEffect(skill.effectTable.effectID2)
            assert(effect2, "Nil effect id")
            if effect1.effectType == 'Attack' then
                damage = damage + skill.effectTable.effectValue2
            end
        end       
        -- Skill Effect 3
        if skill.effectTable.effectID3 ~= nil then
            local effect3 = MetaManager.getEffect(skill.effectTable.effectID3)
            assert(effect3, "Nil effect id")
            if effect1.effectType == 'Attack' then
                damage = damage + skill.effectTable.effectValue3
            end
        end
        
        -- pass this hit event to the GameBattlePanel
        if self.gameBattlePanel == nil then
            self.gameBattlePanel = self:getParent():getChildByName("GameBattlePanel")
        end
        
        -- For statistics
        self.damageCausedByMonster = self.damageCausedByMonster + damage
        
        self.playerHP = math.max((self.playerHP - damage), 0) -- Clamp the player HP to 0
        
        assert(self.gameBattlePanel, "Nil in self.gameBattlePanel")
        self.gameBattlePanel:doDamageToPlayer(self.playerHP, self.playerMaxHP, damage)
        
        if self.playerHP == 0 then
            self.playerWins = false
        end
        
        if self.playerWins ~= nil and not self.playerWins then
            -- TODO: Pass the correct params to the ending scene
            self:outputBattleStats()
            self:getParent():onGameOver()
            return
        end
    end
    
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
            self.runeCollectStat[k] = self.runeCollectStat[k] + v
            self.runesTable[k] = math.min(GMaxRuneNumber, self.runesTable[k])   -- clamp the rune number to GMaxRuneNumber
        end
    end
    
    -- Debug output
    for k, v in pairs(self.runesTable) do
        print (k,v)
    end
    
    -- notifythe GameSkillSlotPanel to update the skill status
    assert(self.gameSkillSlotPanel, "Nil GameSkillSlotPanel in function: GameBattleLogic:updateRunesTable()")
    self.gameSkillSlotPanel:updateSkillStatus(self.runesTable)
    
    -- notify the GameBattlePanel to update the rune text
    assert(self.gameBattlePanel, "Nil GameBattlePanel in function: GameBattleLogic:updateRunesTable()")
    self.gameBattlePanel:updateRuneNum(self.runesTable)
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

---
-- Calculate the final attack point based on the effect value and monster data
-- @function [parent=#logic.GameBattleLogic] calculatePlayerAttackPoint
function GameBattleLogic:calculatePlayerAttackPoint(elementProperty, effectValue, monster)
    local attackPoint = 0
    if elementProperty == "Physical" then
        attackPoint = effectValue * monster.elementTable.physical
    end
    if elementProperty == "Water" then
        attackPoint = effectValue * monster.elementTable.water
    end
    if elementProperty == "Earth" then
        attackPoint = effectValue * monster.elementTable.earth
    end
    if elementProperty == "Fire" then
        attackPoint = effectValue * monster.elementTable.fire
    end
    if elementProperty == "Air" then
        attackPoint = effectValue * monster.elementTable.air
    end
    -- TODO: Replace skill level with the skill level system
    local skillLevel = 1
    --attackPoint = (1 + math.random(-0.05,0.05)) * skillLevel * attackPoint
    return math.floor(attackPoint)
end

--function GameBattleLogic:calculateMonsterAttackPoint(element)

function GameBattleLogic:outputBattleStats()
    cclog("Battle Duration: "..self.battleDuration)
    cclog("Damage caused by monster: "..self.damageCausedByMonster)
    cclog("Damage caused by player: "..self.damageCausedByPlayer)
    cclog("Skill Stats:")
    for k, v in pairs(self.skillUsedCount) do
        cclog("Skill ID: "..k.." Used Time: "..v)
    end
    cclog("Rune Collection Stats:")
    for k, v in pairs(self.runeCollectStat) do
        cclog(k..": "..v)
    end
end

---
-- Update event 
-- @function [parent=#logic.GameBattleLogic] onUpdate
-- @param delta num delta time
function GameBattleLogic:onUpdate(delta)
    self.battleDuration = self.battleDuration + delta
end


return GameBattleLogic