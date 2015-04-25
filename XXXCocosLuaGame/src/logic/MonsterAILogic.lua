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
    self.battlePanel = self:getParent():getChildByName("GameBattlePanel")
    self.monsterNode = self.battlePanel:getMonsterNode()
    self.isAIOn = true
    print(self.battleLogic)
end


function MonsterAILogic:initMonster(monsterID)
    -- Get the monster from the manager and set the monster HP
    self.monsterID = monsterID
    self.monster = MetaManager.getMonster(monsterID)
    assert(self.monster, "Nil Monster !")
    self:onInitLevel2()
    self:onInitLevel3()
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

function MonsterAILogic:prepareUseSkill(monsterNode)
    local actionByLeft = cc.MoveBy:create(0.1,cc.p(-50,0))
    local actionByLeftBack  = actionByLeft:reverse()
    local actionByRight = cc.MoveBy:create(0.1,cc.p(50,0))
    local actionByRightBack  = actionByRight:reverse()   
    local actionScaleBy = cc.ScaleBy:create(0.2, 1.25, 1.25, 1.25)
    local actionScaleByBack = actionScaleBy:reverse()
    
    local skill = self:getSkill()
    local function monsterUseSkill()
        self.battleLogic:monsterUseSkill(skill)
    end
    
    local actionSeq = cc.Sequence:create(cc.Blink:create(0.8, 5),actionByLeft,actionByLeftBack,actionByRight,actionByRightBack,actionScaleBy,actionScaleByBack, cc.CallFunc:create(monsterUseSkill))
        
    monsterNode:runAction(actionSeq)
end

local actualInterval = 0


local monsterSkill = function(eff1, eff2, eff3)
    local effectTable = {}
    if eff1 ~= nil then
        local t = eff1
        effectTable.effectID1 = t[1]
        effectTable.effectValue1 = t[2]
    end
    if eff2 ~= nil then
        local t = eff2
        effectTable.effectID2 = t[1]
        effectTable.effectValue2 = t[2]
    end
    if eff3 ~= nil then
        local t = eff3
        effectTable.effectID3 = t[1]
        effectTable.effectValue3 = t[2]
    end
    ret = {effectTable = effectTable}
    return ret
end

local damage = 1001
local heal = 1010
local shell = 1020
local recovery = 1030
local bleed = 1040
local silence = 1050
local bravery = 1080

function MonsterAILogic:onUpdateLevel1()
    
    local HP = self.battleLogic.monsterHP/self.battleLogic.monsterMaxHP

    
    local speed = math.max(HP, 0.3)
    
    self.monsterNode:runAction(cc.Sequence:create(
        cc.CallFunc:create(function() actualInterval = 3 * speed end)
        --,cc.Blink:create(0.1 * speed, 2)
        ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75))
        ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)):reverse(), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75):reverse())
        ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25))
        ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25):reverse())
        --,cc.ScaleBy:create(0.2 * speed, 1.25, 1.25, 1.25)
        --,cc.ScaleBy:create(0.2 * speed, 1.25, 1.25, 1.25):reverse()
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 10}, nil, nil)) end)
        ))
     
end


function MonsterAILogic:onInitLevel2()
    self.firstTime = true
    self.secondTime = true
    self.recover = 2
end

function MonsterAILogic:onUpdateLevel2()

    local HP = self.battleLogic.monsterHP/self.battleLogic.monsterMaxHP

    local speed = math.max(HP, 0.8)
    
    if self.firstTime or (self.secondTime and HP < 0.5) then
        if self.firstTime then
            self.firstTime = false  
        else
            self.secondTime = false
        end
        self.monsterNode:runAction(cc.Sequence:create(
            cc.CallFunc:create(function() actualInterval = 3 * speed end)
            ,cc.Spawn:create( cc.RotateBy:create(0.3 * speed,80), cc.ScaleBy:create(0.3 * speed, 0.75, 0.75, 0.75))
            ,cc.Spawn:create( cc.RotateBy:create(0.2 * speed,80):reverse(), cc.ScaleBy:create(0.2 * speed, 0.75, 0.75, 0.75):reverse())
            ,cc.Spawn:create( cc.RotateBy:create(0.3 * speed,-20), cc.ScaleBy:create(0.3 * speed, 1.75, 1.75, 1.75))
            ,cc.Blink:create(0.5 * speed,2)
            ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({bleed, 40}, {bleed, 200}, nil)) end)
            ,cc.Spawn:create( cc.RotateBy:create(0.2 * speed,-20):reverse(), cc.ScaleBy:create(0.2 * speed, 1.75, 1.75, 1.75):reverse())            
        ))
    elseif HP < 0.25 and self.recover > 0 then
        self.recover = self.recover - 1
        self.monsterNode:runAction(cc.Sequence:create(
            cc.CallFunc:create(function() actualInterval = 3 * speed end)
            ,cc.ScaleBy:create(0.2 * speed, 1.5, 1.5, 1.5)
            ,cc.Blink:create(0.3 * speed,1)
            ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
            ,cc.Blink:create(0.3 * speed,1)
            ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
            ,cc.Blink:create(0.3 * speed,1)
            ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
            ,cc.ScaleBy:create(0.2 * speed, 1.5, 1.5, 1.5):reverse()
        ))
    else
        self.monsterNode:runAction(cc.Sequence:create(
            cc.CallFunc:create(function() actualInterval = 2 end)
            ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75))
            ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)):reverse(), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75):reverse())
            ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25))
            ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25):reverse())
            ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 1}, nil, nil)) end)
        ))
        
    end
end




function MonsterAILogic:onInitLevel3()
    self.superSkill = true
end

function MonsterAILogic:onUpdateLevel3()

    local HP = self.battleLogic.monsterHP/self.battleLogic.monsterMaxHP

    local speed = math.max(HP, 0.8)
    
    if HP < 0.5 and self.superSkill then
        self.superSkill = false
        self.monsterNode:runAction(cc.Sequence:create(
        
        cc.CallFunc:create(function() actualInterval = 12 end)
        
        ,cc.MoveBy:create(0.2,cc.p(0,-100))
        ,cc.Blink:create(1.0,5)
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({silence, 0}, {silence, 8}, nil)) end)
        ,cc.MoveBy:create(0.3,cc.p(0,-100)):reverse()
        ,cc.RotateBy:create(0.3,-30)
        ,cc.RotateBy:create(0.3,60)
        ,cc.RotateBy:create(0.2,-60)
        ,cc.RotateBy:create(0.2,60)
        ,cc.RotateBy:create(0.1,-60)
        ,cc.RotateBy:create(0.1,30)
        
        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
                
        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
        
        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)

        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)

        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)

        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)

        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)

        
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 30}, nil, nil)) end)
        ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 50}, nil, nil)) end)
        
        
        ,cc.MoveBy:create(0.2,cc.p(0,-100))
        ,cc.Blink:create(1.0,5)
        ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({bravery, 3.0}, {bravery, 1000}, nil)) end)
        ,cc.MoveBy:create(0.3,cc.p(0,-100)):reverse()         
    ))
    
    else
        
        
        if((math.random(3)) == 1) then
       
        
            self.monsterNode:runAction(cc.Sequence:create(
                 cc.CallFunc:create(function() actualInterval = 3 end)
                ,cc.Blink:create(0.5,2)
                ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25))
                ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 10}, nil, nil)) end)
                ,cc.Spawn:create( cc.MoveBy:create(0.3,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.3, 1.25, 1.25, 1.25):reverse())
                ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({heal, 10}, nil, nil)) end)
            ))
        
        else
        
            self.monsterNode:runAction(cc.Sequence:create(
                cc.CallFunc:create(function() actualInterval = 2 end)
                ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75))
                ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,150)):reverse(), cc.ScaleBy:create(0.1 * speed, 0.75, 0.75, 0.75):reverse())
                ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25))
                ,cc.Spawn:create( cc.MoveBy:create(0.1 * speed,cc.p(0,-100)):reverse(), cc.ScaleBy:create(0.1 * speed, 1.25, 1.25, 1.25):reverse())
                ,cc.CallFunc:create(function() self.battleLogic:monsterUseSkill(monsterSkill({damage, 5}, nil, nil)) end)
                ))
                
        end
    
    
    end
   
end




function MonsterAILogic:onUpdate(delta)  
    --cclog(delta)  
    if not self.isAIOn then
        return
    end

    


    self.interval=self.interval+delta
    if self.interval > actualInterval then
        self.interval = 0

        if self.monsterID == 1001 then
            self:onUpdateLevel1()
            return
        end
        
        
        if self.monsterID == 1002 then
            self:onUpdateLevel2()
            return
        end

        if self.monsterID == 1003 then
            self:onUpdateLevel3()
            return
        end


        math.randomseed(os.time())
        actualInterval = GMonsterAIInterval+2*(math.random()-0.5) 
        
        --self.useSkillTimes = self.useSkillTimes+1
        local skill = self:getSkill()
        self:prepareUseSkill(self.monsterNode)
       
        --self.battleLogic:monsterUseSkill(skill)
        --cclog("Monster use skill times:"..self.useSkillTimes[4].." ,skillName:"..skill.skillName)
        --cclog("stat: skill1:"..self.useSkillTimes[1]..",skill2:"..self.useSkillTimes[2]..",skill3:"..self.useSkillTimes[3])   
    end    
end

return MonsterAILogic