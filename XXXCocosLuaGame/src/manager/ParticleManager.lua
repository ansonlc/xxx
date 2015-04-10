ParticleManager = {}

--monster rune and player's coordnate
local monsterXY = cc.p(1500,1500)
local runeXY = cc.p(100,1500)
local playerXY = cc.p(1500,500)

function ParticleManager.init()
end

--------------------------------
--  display particle from one point to another in some duration
--  @param #cc.p from the start point
--  @param #cc.p to the end point
--  @param #cc.node parentNode the parent node which the new particle will add to
--  @param #float duration the particle effect duration
--  @param #string plist the filename of the particle
--  @param #int actionType 0 means use straight line, 1 means use arc
function ParticleManager.particleDisplay(from,to,parentNode,duration,particleID)
    local particle = MetaManager.getParticle(particleID)
    local particleNode = cc.ParticleSystemQuad:create(particle.path)
    
    
    particleNode:setPosition(from)
    particleNode:setDuration(duration+0.1)
    parentNode:addChild(particleNode)

    local moveToAction = cc.MoveTo:create(duration,to)
    particleNode:runAction(moveToAction)
end

--[[function ParticleManager.particleDisplay(from,to,parentNode,duration,particleID,actionType)
    local particleNode = nil
    if 1001 == particleID   then  
        particleNode = fireNode
    elseif 1002 == particleID  then  
        particleNode = earthNode
    elseif 1004 == particleID   then  
        particleNode = earthNode
    elseif 1005 == particleID  then 
        particleNode = earthNode
    else 
        local particle = MetaManager.getParticle(particleID)
        particleNode = cc.ParticleSystemQuad:create(particle.path)
    end

    particleNode:setPosition(from)
    particleNode:setDuration(duration+0.1)
    parentNode:addChild(particleNode)

    local moveToAction = cc.MoveTo:create(duration,to)
    if 1==actionType then
    end    
    particleNode:runAction(moveToAction)
end]]--

function ParticleManager.monsterUseSkillParticle(parentNode,skill)
    local particle  = MetaManager.getParticle(skill.particleID)
    ParticleManager.particleDisplay(monsterXY,playerXY,parentNode,0.5,particle.path)
    
end

function ParticleManager.playerUseSkillParticle(parentNode,skill)
    local particle  = MetaManager.getParticle(skill.particleID)
    ParticleManager.particleDisplay(runeXY,monsterXY,parentNode,0.5,particle.path)
end
