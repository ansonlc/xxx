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
    self.runesTable = {water = 0, air = 0, fire = 0, earth = 0}
    --self.runesTable = {water = 10, air = 10, fire = 10, earth = 10}    -- currently all the runes start from 5
    --self.runesTable = {water = 99, air = 99, fire = 99, earth = 99}
    self.crystalNum = DataManager.getCrystalNum()
    self.playerMaxHP = DataManager.getUserHP()
    self.playerHP = self.playerMaxHP
    self.playerWins = nil
    self.playerSkillLevel = {}
    -- Statistics for the whole battle
    self.skillUsedCount = {}
    self.runeCollectStat = {water = 0, air = 0, fire = 0, earth = 0}
    self.battleDuration = 0
    self.damageCausedByMonster = 0
    self.damageCausedByPlayer = 0
    -- Buff/Debuff Table
    self.playerEffectTable = {}
    self.monsterEffectTable = {}
    -- Silence status track
    self.isPlayerSilenced = false
    self.isMonsterSilenced = false
    -- Rune Collect Bonus
    self.runeCollectingBonus = 0
    -- Shield Ability
    self.playerShellEnergy = 0
    self.monsterShellEnergy = 0
    -- Curse Status
    self.isPlayerCursed = false
    self.runeCollectBound = 0
    -- Attack Bonux
    self.playerDamageBonus = 1.0
    self.monsterDamageBonus = 1.0
    -- Initialization for the GameSkillSlotPanel
    if self.gameSkillSlotMgr == nil then
        self.gameSkillSlotMgr = self:getParent():getChildByName("GameSkillSlotPanel"):getChildByName("SkillSlotManager")  -- Actually it's the manager
    end
    assert(self.gameSkillSlotMgr, "Nil in function GameBattleLogic:initNode()")
    self.gameSkillSlotMgr:updateSkillStatus(self.runesTable)
    
    -- Initialization for the GameBattlePanel
    if self.gameBattlePanel == nil then
        self.gameBattlePanel = self:getParent():getChildByName("GameBattlePanel")
    end
    assert(self.gameBattlePanel, "Nil in function GameBattleLogic:initNode()")
    self.gameBattlePanel:updateRuneNum(self.runesTable)
    self.gameBattlePanel:updateCrystalNum(self.crystalNum)
    
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
    self.monsterID = monsterID
end

--------------------------------
-- Use the skill passed by the GameSkillSlotPanel
-- @function [parent=#logic.GameBattleLogic] playerUseSkill
-- @param self 
-- @param skill type The skill activated by the player
function GameBattleLogic:playerUseSkill(skill)
    if self.isPlayerSilenced then
        cclog("Player is being silenced and cannot use skills!")
        return
    end
    assert(skill, "Nil input in function GameBattleLogic:playerUseSkill")
        
    -- For statistics
    if self.skillUsedCount[skill.skillID] == nil then
        self.skillUsedCount[skill.skillID] = 0
    else
        self.skillUsedCount[skill.skillID] = self.skillUsedCount[skill.skillID] + 1
    end
    
    -- Get the skill level data
    if self.playerSkillLevel[skill.skillID] == nil then
        self.playerSkillLevel[skill.skillID] = DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills[skill.skillID]
        local test = self.playerSkillLevel[skill.skillID]
        local test2 = 0
    end
    
    -- Decrease the rune number
    self.runesTable.water = self.runesTable.water - skill.runeCostTable.water
    self.runesTable.air= self.runesTable.air - skill.runeCostTable.air
    self.runesTable.fire = self.runesTable.fire - skill.runeCostTable.fire
    self.runesTable.earth = self.runesTable.earth - skill.runeCostTable.earth
    
    local damage = 0
    local heal = 0
    local skillLevel = DataManager.expToLevel(self.playerSkillLevel[skill.skillID].exp)
    local newEffect = nil
    local isContinuousSkill = false
    local effectAdded = false
    local causeDamage = false
    local causeHealing = false
    local causeShellAbsorbed = false
    local causeShieldActivated = false
    
    local function calculatePlayerAttackPoint(elementProperty, effectValue, monster)
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
        attackPoint = (100 + math.random(-5,5)) * math.pow(GSkillLevelBonus, skillLevel) * attackPoint / 100;
        --cclog("Attack Power: "..attackPoint )
        return math.floor(attackPoint)
    end
    
    local function playerApplyEffect(effect, effectValue)
        causeDamage = false
        if effect.effectType == 'Attack' then
            damage = damage + calculatePlayerAttackPoint(effect.elementProperty,effectValue,self.monster)   -- bonus calculated in local function
            causeShellAbsorbed = false
            SoundManager.playEffect('attack', false)
        elseif effect.effectType == 'Heal' then
            heal = heal + effectValue * math.pow(GSkillLevelBonus, skillLevel)   -- level matters to the healing value
            causeHealing = true
            SoundManager.playEffect('heal', false)
        elseif effect.effectType == 'Shell' then
            self.playerShellEnergy = effectValue * math.pow(GSkillLevelBonus, skillLevel)    -- level matters to the shell value
            --self.playerShellEnergy = effectValue
            causeShieldActivated = true
            SoundManager.playEffect('skill', false)
        elseif effect.effectType == 'Purify' then
            -- delete all the debuff on the player
            for k, v in pairs(self.playerEffectTable) do
                if v.effectType == 'Curse' or v.effectType == 'Fear' or v.effectType == 'Bleed' then
                    v.effectTimeToLive = 0
                    cclog(v.effectType.." effect removed on player")
                end
                self.gameBattlePanel:removeEffectOnPlayer(effect)
            end
            SoundManager.playEffect('skill', false)
        elseif effect.effectType == 'Disperse' then
            -- delete all the buff on the monster
            self.monsterShellEnergy = 0
            for k, v in pairs(self.monsterEffectTable) do
                if v.effectType == 'Recovery' or v.effectType == 'Bravery' then
                    v.effectTimeToLive = 0
                    cclog(v.effectType.." effect removed on monster")
                end
                self.gameBattlePanel:removeEffectOnPlayer(effect)
            end
            SoundManager.playEffect('skill', false)
            
        else    -- Deal with the effect: Recovery, Bless, Silence, Curse, Bravery, Fear, Bleed
            local effectToAdd = {}
            effectToAdd.effectType = effect.effectType
            effectToAdd.effectValue = effectValue[1]
            effectToAdd.effectTimeCount = 0
            effectToAdd.effectTimeToLive = effectValue[2]
            if effect.effectType == 'Bleed' or effect.effectType == 'Curse' or effect.effectType == 'Fear' or effect.effectType == 'Silence' then
                self.monsterEffectTable[effect.effectType] = effectToAdd
                if effect.effectType == 'Silence' then
                    self.isMonsterSilenced = true
                    -- should notify the AI node
                    if self.monsterAINode == nil then
                        self.monsterAINode = self:getParent():getChildByName("MonsterAILogic")
                    end
                    self.monsterAINode.isAIOn = false
                    SoundManager.playEffect('silence', false)
                elseif effect.effectType == 'Fear' then
                    self.monsterDamageBonus = (1 - effectToAdd.effectValue)     -- TODO: pending for decision
                    SoundManager.playEffect('skill', false)
                elseif effect.effectType == 'Bleed' then
                    effectToAdd.effectValue = effectToAdd.effectValue * math.pow(GSkillLevelBonus, skillLevel)
                    SoundManager.playEffect('bleed', false)
                elseif effect.effectType == 'Curse' then
                    -- should not happend since player cannot use curse
                    SoundManager.playEffect('skill', false)
                end
                self.gameBattlePanel:monsterAddEffect(effectToAdd)
            else    -- Positive effect here
                self.playerEffectTable[effect.effectType] = effectToAdd
                if effect.effectType == 'Bless' then
                    self.runeCollectingBonus = effectToAdd.effectValue;  -- TODO: Pending for decision
                    SoundManager.playEffect('skill', false)
                elseif effect.effectType == 'Bravery' then
                    self.playerDamageBonus = effectToAdd.effectValue    -- TODO: pending for decision
                    SoundManager.playEffect('skill', false)
                elseif effect.effectType == 'Recovery' then
                    effectToAdd.effectValue = effectToAdd.effectValue * math.pow(GSkillLevelBonus, skillLevel)
                    SoundManager.playEffect('recovery', false)
                end
                self.gameBattlePanel:playerAddEffect(effectToAdd)
            end
            --cclog("Effect type: "..effectToAdd.effectType.."; value: "..effectToAdd.effectValue.."; TTL: "..effectToAdd.effectTimeToLive.." by player") 
        end
    end
    
    if skill.effectTable ~= nil then        
        if skill.effectTable.effectID1 == skill.effectTable.effectID2 and skill.effectTable.effectID1 ~= nil then
            isContinuousSkill = true
        end
        
        if isContinuousSkill then
            local effectValue = {}
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            effectValue[1] = skill.effectTable.effectValue1     -- Value
            effectValue[2] = skill.effectTable.effectValue2     -- Duration
            playerApplyEffect(effect1, effectValue)    -- we don't expect a return value for continuous effect
        else
            -- First effect always exists for the skill
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            assert(effect1, "Nil effect id")
            playerApplyEffect(effect1, skill.effectTable.effectValue1)
            
            if skill.effectTable.effectID2 ~= nil then
                local effect2 = MetaManager.getEffect(skill.effectTable.effectID2)
                assert(effect2, "Nil effect id")
                playerApplyEffect(effect2, skill.effectTable.effectValue2)
            end
            
        end
        
        if skill.effectTable.effectID3 ~= nil then
            local effect3 = MetaManager.getEffect(skill.effectTable.effectID3)
            assert(effect3, "Nil effect id")
            playerApplyEffect(effect3, skill.effectTable.effectValue3)
        end
        
        local test = self.playerDamageBonus
        -- First apply the damage bonus
        damage = damage * self.playerDamageBonus
                  
        -- For statistics
        self.damageCausedByPlayer = self.damageCausedByPlayer + damage
        
        if damage > 0 then
            -- do damage to the monster       
            if self.monsterShellEnergy > 0 then
                damage = math.floor(damage / 2.0)
                self.monsterShellEnergy = self.monsterShellEnergy - damage
                causeShellAbsorbed = true
                if self.monsterShellEnergy < 0 then
                    -- Shell Breaks here
                    damage = - self.monsterShellEnergy
                    self.monsterShellEnergy = 0
                    causeShellAbsorbed = false
                    causeDamage = true
                else 
                    damage = 0
                    causeDamage = false
                end
            else
                causeDamage = true
            end
        elseif damage < 0 then
            -- The monster will absorb the damage here (Special case because of the element property)
            causeShellAbsorbed = false
            causeDamage = false
        end
        
        self.monsterHP = self.monsterHP - damage
        
        if self.monsterHP < 0 then
            self.monsterHP = 0
        end
        
        -- heal the player
        self.playerHP = self.playerHP + heal
        
        if self.playerHP > self.playerMaxHP then
            heal = heal - (self.playerHP - self.playerMaxHP)
            self.playerHP = self.playerMaxHP
        end
        
        -- Display the related animation
        if causeDamage then
            self.gameBattlePanel:doDamageToMonster(damage, self.monsterHP / self.monsterMaxHP)
        end
        
        if causeHealing then
            self.gameBattlePanel:healPlayer(self.playerHP / self.playerMaxHP, heal)
        end
        
        if causeShellAbsorbed then
            self.gameBattlePanel:monsterShellAbsorbed()
        end
        
        if causeShieldActivated then
            self.gameBattlePanel:playerShellActivated(self.playerShellEnergy / self.playerMaxHP)
        end
        
        -- Monster status decision        
        if self.monsterHP <= 0 then
            self.playerWins = true
        elseif self.monsterHP >= self.monsterMaxHP then
            self.monsterHP = self.monsterMaxHP
        end
        
        if self.playerWins then
            -- Display the related animation
            self.gameBattlePanel:monsterIsDefeated()
        end
        
        -- nofity the GameSkillSlotPanel to update the skill status
        assert(self.gameSkillSlotMgr, "No SkillSlotManager found")
        self.gameSkillSlotMgr:updateSkillStatus(self.runesTable)
        
        -- notify the GameBattlePanel to update the rune text
        assert(self.gameBattlePanel, "Nil GameBattlePanel in function: GameBattleLogic:updateRunesTable()")
        self.gameBattlePanel:updateRuneNum(self.runesTable)
        
        if self.playerWins ~= nil and self.playerWins then
            self:outputBattleStats()
            self:endGame()
            return
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
    --cclog(skill.skillName)
    if self.isMonsterSilenced then
        cclog("Monster is being silenced and cannot use skills!")
        return
    end
    
    local damage = 0
    local heal = 0
    local shellAbsorbedDamage = 0
    local causeDamage = false
    local causeHealing = false
    local causeShellAbsorbed = false
    local causeShellActivated = false
    local isContinuousSkill = false
    
    if skill.effectTable.effectID1 == skill.effectTable.effectID2 and skill.effectTable.effectID1 ~= nil then
        isContinuousSkill = true
    end
    
    local function monsterApplyEffect(effect, effectValue)
        if effect.effectType == 'Attack' then
            damage = damage + effectValue
            causeDamage = true
            causeShellAbsorbed = true
        elseif effect.effectType == 'Heal' then
            heal = heal + effectValue
            causeHealing = true
        elseif effect.effectType == 'Shell' then
            self.monsterShellEnergy = effectValue[1]
            causeShellActivated = true
        elseif effect.effectType == 'Purify' then
        
        elseif effect.effectType == 'Disperse' then
        
        else    -- Deal with the effect: Recovery, Bless, Silence, Curse, Bravery, Fear, Bleed
            local effectToAdd = {}
            effectToAdd.effectType = effect.effectType
            effectToAdd.effectValue = effectValue[1]
            effectToAdd.effectTimeCount = 0
            effectToAdd.effectTimeToLive = effectValue[2]
            if effect.effectType == 'Bleed' or effect.effectType == 'Curse' or effect.effectType == 'Fear' or effect.effectType == 'Silence' then
                self.playerEffectTable[effect.effectType] = effectToAdd
                if effect.effectType == 'Silence' then
                    self.isPlayerSilenced = true
                    self.gameSkillSlotMgr:disableSkillSlots() -- Disable the skill slot so that the player cannot use skills
                elseif effect.effectType == 'Curse' then
                    --self.runeCollectingBonus = effectToAdd.effectValue
                    self.runeCollectBound = effectToAdd.effectValue
                    self.isPlayerCursed = true
                elseif effect.effectType == 'Fear' then
                    self.playerDamageBonus = (1 - effectToAdd.effectValue)
                end
                self.gameBattlePanel:playerAddEffect(effectToAdd)
            else -- Positive buff for the monster
                if effect.effectType == 'Bravery' then
                    self.monsterDamageBonus = effectToAdd.effectValue
                end
                self.monsterEffectTable[effect.effectType] = effectToAdd
                self.gameBattlePanel:monsterAddEffect(effectToAdd)
            end
            --cclog("Effect type: "..effectToAdd.effectType.."; value: "..effectToAdd.effectValue.."; TTL: "..effectToAdd.effectTimeToLive..' by monster') 
        end
    end
    
    if skill.effectTable ~= nil then        
        if skill.effectTable.effectID1 == skill.effectTable.effectID2 and skill.effectTable.effectID1 ~= nil then
            isContinuousSkill = true
        end

        if isContinuousSkill then
            local effectValue = {}
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            effectValue[1] = skill.effectTable.effectValue1     -- Value
            effectValue[2] = skill.effectTable.effectValue2     -- Duration
            monsterApplyEffect(effect1, effectValue)    -- we don't expect a return value for continuous effect
        else
            -- First effect always exists for the skill
            local effect1 = MetaManager.getEffect(skill.effectTable.effectID1)
            assert(effect1, "Nil effect id")
            monsterApplyEffect(effect1, skill.effectTable.effectValue1)

            if skill.effectTable.effectID2 ~= nil then
                local effect2 = MetaManager.getEffect(skill.effectTable.effectID2)
                assert(effect2, "Nil effect id")
                monsterApplyEffect(effect2, skill.effectTable.effectValue2)
            end

        end

        if skill.effectTable.effectID3 ~= nil then
            local effect3 = MetaManager.getEffect(skill.effectTable.effectID3)
            assert(effect3, "Nil effect id")
            monsterApplyEffect(effect3, skill.effectTable.effectValue3)
        end
        
        -- First apply the damage bonus
        local test = self.monsterDamageBonus
        damage = damage * self.monsterDamageBonus
                
        -- For statistics
        self.damageCausedByMonster = self.damageCausedByMonster + damage
        
        -- Calculate Shell      
        if self.playerShellEnergy > 0 then
            --self.monsterShellEnergy = math.floor(self.monsterShellEnergy - damage / 2)
            damage = math.floor(damage / 2.0)
            shellAbsorbedDamage = damage
            self.playerShellEnergy = self.playerShellEnergy - damage
            if self.playerShellEnergy <= 0 then
                -- Shell Breaks here
                damage = - self.playerShellEnergy   -- Damage after absorbed
                shellAbsorbedDamage = shellAbsorbedDamage - damage    -- Actual damage absorbed
                self.playerShellEnergy = 0
            else 
                damage = 0
                causeDamage = false
            end
        end
        
        
        -- Calculate Damage
        self.playerHP = self.playerHP - damage
        
        if self.playerHP <=0 then
            self.playerWins = false
            self.playerHP = 0
        end
        
        -- Calculate Heal
        self.monsterHP = self.monsterHP + heal
        
        if self.monsterHP > self.monsterMaxHP then
            heal = heal - (self.monsterHP - self.monsterMaxHP)
            self.monsterHP = self.monsterMaxHP
        end
        
        self.gameBattlePanel:healMonster(self.monsterHP / self.monsterMaxHP)
        
        -- Display the related Animation
        
        assert(self.gameBattlePanel, "Nil in self.gameBattlePanel")
        
        if causeShellAbsorbed then
            self.gameBattlePanel:playerShellAbsorbed(self.playerShellEnergy / self.playerMaxHP)
        end
        
        if causeDamage then
            self.gameBattlePanel:doDamageToPlayer(self.playerHP / self.playerMaxHP)
        end      
        
        --self.gameBattlePanel:monsterUseSkill(nil)
        
        if self.playerWins ~= nil and not self.playerWins then
            self:outputBattleStats()
            self:endGame()
            return
        end
    end
    
end

---
--  Called for the player's buff and debuff
function GameBattleLogic:playerUseEffect(effect)
    --cclog("Effect type: "..effect.effectType.."; value: "..effect.effectValue.."; TTL: "..effect.effectTimeToLive.." activated by player") 
    
    if effect.effectType == 'Recovery' then
        local heal = effect.effectValue
        
        self.playerHP = self.playerHP + heal

        if self.playerHP > self.playerMaxHP then
            heal = heal - (self.playerHP - self.playerMaxHP)
            self.playerHP = self.playerMaxHP
        end
        
        self.gameBattlePanel:healPlayer(self.playerHP / self.playerMaxHP)
    elseif effect.effectType == 'Bleed' then
        local damage = effect.effectValue
        local shellAbsorbedDamage = 0
        local causeShellAbsorbed = true
        local causeDamage = true    -- Default to cause damage to the player
        
        -- Calculate Shell      
        if self.playerShellEnergy > 0 then
            damage = math.floor(damage / 2.0)
            shellAbsorbedDamage = damage
            causeShellAbsorbed = true  -- Shield must absord some damage
            self.playerShellEnergy = self.playerShellEnergy - damage
            if self.playerShellEnergy < 0 then
                -- Shell Breaks here
                damage = - self.playerShellEnergy   -- Damage after absorbed
                shellAbsorbedDamage = shellAbsorbedDamage - damage    -- Actual damage absorbed
                self.playerShellEnergy = 0
            else 
                damage = 0
                causeDamage = false
            end
        end
        
        self.playerHP = self.playerHP - damage
        
        if self.playerHP <=0 then
            self.playerHP = 0
            self.playerWins = false
        end
        
        if causeShellAbsorbed then
            self.gameBattlePanel:playerShellAbsorbed(self.playerShellEnergy / self.playerMaxHP)
        end
        
        if causeDamage then
            self.gameBattlePanel:doDamageToPlayer(self.playerHP / self.playerMaxHP)
        end

        -- GameOver Condition
        if self.playerWins ~= nil and not self.playerWins then
            self:outputBattleStats()
            self:endGame()
            return
        end 
    end
end

function GameBattleLogic:monsterUseEffect(effect)
    --cclog("Effect type: "..effect.effectType.."; value: "..effect.effectValue.."; TTL: "..effect.effectTimeToLive.." activated by monster") 

    if effect.effectType == 'Recovery' then
        local heal = effect.effectValue
        heal = math.floor(heal)

        self.monsterHP = self.monsterHP + heal

        if self.monsterHP > self.monsterMaxHP then
            heal = heal - (self.playerHP - self.playerMaxHP)
            self.monsterHP = self.monsterMaxHP
        end

        -- self.gameBattlePanel:healMonster(self.playerHP / self.playerMaxHP)
        
    elseif effect.effectType == 'Bleed' then
        local damage = effect.effectValue
        local causeDamage = false
        local causeShellAbsorbed = false
        
        -- first floor the damage to interger
        damage = math.floor(damage)
           
        -- do damage to the monster       
        if self.monsterShellEnergy > 0 then
            damage = math.floor(damage / 2.0)
            self.monsterShellEnergy = self.monsterShellEnergy - damage
            causeShellAbsorbed = true
            if self.monsterShellEnergy < 0 then
                -- Shell Breaks here
                damage = - self.monsterShellEnergy
                self.monsterShellEnergy = 0
                causeShellAbsorbed = false
                causeDamage = true
            else 
                damage = 0
                causeDamage = false
            end
        else
            causeDamage = true
        end
        
        self.monsterHP = self.monsterHP - damage

        if causeDamage then
            self.gameBattlePanel:doDamageToMonster(damage, self.monsterHP / self.monsterMaxHP)   
        end

        if causeShellAbsorbed then
            self.gameBattlePanel:monsterShellAbsorbed()
        end

        -- GameOver Condition
        if self.monsterHP <= 0 then
            self.gameBattlePanel:monsterIsDefeated()
            self.playerWins = true
        end

        if self.playerWins ~= nil and self.playerWins then
            self:outputBattleStats()
            self:endGame()
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
            local addedRunes = v + self.runeCollectingBonus
            if self.isPlayerCursed then
                addedRunes = math.min(addedRunes, self.runeCollectBound)
            end
            self.runesTable[k] = self.runesTable[k] + addedRunes
            -- for statistics
            self.runeCollectStat[k] = self.runeCollectStat[k] + v + self.runeCollectingBonus
            
            self.runesTable[k] = math.min(GMaxRuneNumber, self.runesTable[k])   -- clamp the rune number to GMaxRuneNumber
        end
    end
    
    -- Debug output
    for k, v in pairs(self.runesTable) do
        print (k,v)
    end
    
    -- notifythe GameSkillSlotPanel to update the skill status
    assert(self.gameSkillSlotMgr, "Nil GameSkillSlotPanel in function: GameBattleLogic:updateRunesTable()")
    self.gameSkillSlotMgr:updateSkillStatus(self.runesTable)
    
    -- notify the GameBattlePanel to update the rune text
    assert(self.gameBattlePanel, "Nil GameBattlePanel in function: GameBattleLogic:updateRunesTable()")
    self.gameBattlePanel:updateRuneNum(self.runesTable)
    
    SoundManager.playEffect('rune',false)
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
    DataManager.setCrystalNum(self.crystalNum)
    
    --print ('get->' .. self.crystalNum)
end

---
-- Get the number of the crystal number
-- @function [parent=#logic.GameBattleLogic] getCrystalNum
-- @param self
-- @return #number crystal number
function GameBattleLogic:getCrystalNum()
    return self.crystalNum
end

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

function GameBattleLogic:endGame()
    -- 1: skill count 2: battle duration 3: player skill level
    local gameResultTable = {}
    gameResultTable[1] = self.skillUsedCount
    gameResultTable[2] = self.battleDuration
    gameResultTable[3] = self.playerSkillLevel
    
    self:getParent():onGameOver(self.playerWins, gameResultTable)
end

---
-- Update event 
-- @function [parent=#logic.GameBattleLogic] onUpdate
-- @param delta num delta time
function GameBattleLogic:onUpdate(delta)
    -- Test purpose:
    if self.test == nil then
        --[[self:playerUseSkill(MetaManager.getSkill(1300))
        self:playerUseSkill(MetaManager.getSkill(1600))
        self:monsterUseSkill(MetaManager.getSkill(1400))
        self:monsterUseSkill(MetaManager.getSkill(1500))--]]
        --self:monsterUseSkill(MetaManager.getSkill(1800))
        --self:monsterUseSkill(MetaManager.getSkill(1400))
        self.test = 0
    end
   
    self.battleDuration = self.battleDuration + delta
    -- refresh the effect table for the player
    for k, v in pairs(self.playerEffectTable) do
        if v ~= nil then
            v.effectTimeCount = v.effectTimeCount + delta
            if v.effectTimeCount > GEffectPublicCD then
                -- activate this effect
                self:playerUseEffect(v)
                v.effectTimeCount = 0
            end
            
            v.effectTimeToLive = v.effectTimeToLive - delta
            if v.effectTimeToLive < 0 then
                if v.effectType == 'Silence' then
                    self.isPlayerSilenced = false
                    self.gameSkillSlotMgr:enableSkillSlots()
                elseif v.effectType == 'Bless' then
                    self.runeCollectingBonus = 0
                elseif v.effectType == 'Curse' then
                    self.isPlayerCursed = false
                    self.runeCollectBound = 0
                elseif v.effectType == 'Bravery' or v.effectType == 'Fear' then
                    self.playerDamageBonus = 1.0
                end
                --cclog("Effect type: "..v.effectType.."; value: "..v.effectValue.." stopped on player") 
                self.playerEffectTable[k] = nil
            end
        end
    end
    -- refresh the effect table for the monster
    for k, v in pairs(self.monsterEffectTable) do
        if v ~= nil then
            v.effectTimeCount = v.effectTimeCount + delta
            if v.effectTimeCount > GEffectPublicCD then
                -- activate this effect
                self:monsterUseEffect(v)
                v.effectTimeCount = 0
            end
            v.effectTimeToLive = v.effectTimeToLive - delta
            if v.effectTimeToLive < 0 then
                if v.effectType == 'Silence' then
                    self.isMonsterSilenced = false
                    -- should notify the AI node
                    if self.monsterAINode == nil then
                        self.monsterAINode = self:getParent():getChildByName("MonsterAILogic")
                    end
                    self.monsterAINode.isAIOn = true
                    
                elseif v.effectType == 'Bravery' or v.effectType == 'Fear' then
                    self.monsterDamageBonus = 1.0
                end
                --cclog("Effect type: "..v.effectType.."; value: "..v.effectValue.." stopped on monster") 
                self.monsterEffectTable[k] = nil
            end
        end
    end
end


return GameBattleLogic