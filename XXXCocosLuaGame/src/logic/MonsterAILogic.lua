local MonsterAILogic = class("MonsterAILogic", function() return cc.Node:create() end)


function MonsterAILogic.create()
    local monsterAI = MonsterAILogic.new()
    --monsterAI:initAI()
    return monsterAI
end

function MonsterAILogic:initAI()
    self.interval = 0
    self.useSkillTimes = 0
    self.battleLogic = self:getParent():getChildByName("GameBattleLogic")
    print(self.battleLogic)
end

function MonsterAILogic:initMonster(monsterID)
    -- Get the monster from the manager and set the monster HP
    self.monster = MetaManager.getMonster(monsterID)
    assert(self.monster, "Nil Monster !")
    --print(self.monster)
end

function MonsterAILogic:getSkill()
    --use random function to get one skill to use
    math.randomseed(os.time())
    local skillID = "SkillID"
    skillID = skillID..math.random(3)
    --cclog(skillID)
    local skill = MetaManager.getSkill(self.monster.skillTable[skillID])
    return skill
end

local actualInterval = GMonsterAIInterval
function MonsterAILogic:onUpdate(delta)  
    --cclog(delta)  
    self.interval=self.interval+delta
    if self.interval > actualInterval then
        math.randomseed(os.time())
        actualInterval = GMonsterAIInterval+2*(math.random()-0.5) 
        self.interval = 0
        self.useSkillTimes = self.useSkillTimes+1
        local skill = self:getSkill()
        self.battleLogic:monsterUseSkill(skill)
        cclog("Monster use skill times:"..self.useSkillTimes.." ,skillName:"..skill.skillName)   
    end    
end

return MonsterAILogic