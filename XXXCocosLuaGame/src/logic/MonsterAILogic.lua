local MonsterAILogic = class("MonsterAILogic", function() return cc.Node:create() end)


function MonsterAILogic.create()
    local monsterAI = MonsterAILogic.new()
    --monsterAI:initAI()
    return monsterAI
end

function MonsterAILogic:initAI()
    self.interval = 0
    -- useSkillTimes[i] means the i skill's use times 
    self.useSkillTimes = {0,0,0,0} 
    self.battleLogic = self:getParent():getChildByName("GameBattleLogic")
    self.isAIOn = true
    print(self.battleLogic)
end

function MonsterAILogic:initMonster(monsterID)
    -- Get the monster from the manager and set the monster HP
    self.monster = MetaManager.getMonster(monsterID)
    assert(self.monster, "Nil Monster !")
    --print(self.monster)
end

local times = 0
function MonsterAILogic:getMonsterStatus()
    local HP = self.battleLogic.monsterHP/self.battleLogic.monsterMaxHP
    cclog("HP:"..HP)
    if((0 == times) and (HP<=0.75)) then
        times = times+1
        return true    
    elseif (1==times and HP<=0.5) then
        times = times+1
        return true   
    elseif (2==times and HP<=0.25) then
        return true
    else
        return false
    end
        
end

function MonsterAILogic:getSkill()
    --use random function to get one skill to use
    math.randomseed(os.time())
    local skillID = "SkillID"
    local ID = math.random(2)
    if(self:getMonsterStatus())then
        ID = 3
    end
    skillID = skillID..ID
    --cclog(skillID)    
    self.useSkillTimes[ID] = self.useSkillTimes[ID]+1
    self.useSkillTimes[4] = self.useSkillTimes[4] + 1 
    
    local skill = MetaManager.getSkill(self.monster.skillTable[skillID])
    return skill
end

local actualInterval = GMonsterAIInterval
function MonsterAILogic:onUpdate(delta)  
    --cclog(delta)  
    if not self.isAIOn then
        return
    end
    self.interval=self.interval+delta
    if self.interval > actualInterval then
        math.randomseed(os.time())
        actualInterval = GMonsterAIInterval+2*(math.random()-0.5) 
        self.interval = 0
        --self.useSkillTimes = self.useSkillTimes+1
        local skill = self:getSkill()
        self.battleLogic:monsterUseSkill(skill)
        --cclog("Monster use skill times:"..self.useSkillTimes[4].." ,skillName:"..skill.skillName)
        --cclog("stat: skill1:"..self.useSkillTimes[1]..",skill2:"..self.useSkillTimes[2]..",skill3:"..self.useSkillTimes[3])   
    end    
end

return MonsterAILogic