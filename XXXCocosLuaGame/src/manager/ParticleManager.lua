ParticleManager = {}

local monsterXY = cc.p(1500,1500)
local runeXY = cc.p(100,1500)
local playerXY = cc.p(1500,500)

--------------------------------
--  display particle from one point to another in some duration
--  @param #cc.p from the start point
--  @param #cc.p to the end point
--  @param #cc.node parentNode the parent node which the new particle will add to
--  @param #float duration the particle effect duration
--  @param #string plist the filename of the particle
--  @param #int actionType 0 means use straight line, 1 means use arc
--function ParticleManager.particleDisplay(from,to,parentNode,duration,plist)
--    local particle = cc.ParticleSystemQuad:create(plist)
--    particle:setPosition(from)
--    particle:setDuration(duration+0.1)
--    parentNode:addChild(particle)
--    local moveToAction = cc.MoveTo:create(duration,to)
--    particle:runAction(moveToAction)
--end

function ParticleManager.particleDisplay(from,to,parentNode,duration,particleID)
   
    local particle = MetaManager.getParticle(particleID)
    local particleNode = cc.ParticleSystemQuad:create(particle.path)
    particleNode:setPosition(from)
    particleNode:setDuration(duration+0.1)
    parentNode:addChild(particleNode)

    local moveToAction = cc.MoveTo:create(duration,to)
    particleNode:runAction(moveToAction)
end

--[[function ParticleManager.particleDisplay(from,to,parentNode,duration,plist,actionType)
--    local particle = cc.ParticleSystemQuad:create(plist)
--    particle:setPosition(from)
--    particle:setDuration(duration+0.1)
--    parentNode:addChild(particle)
--    local moveAction = cc.MoveTo:create(duration,to)
--    if 1==actionType then
--    end    
--    particle:runAction(moveAction)
--end--]]


--[[
function ParticleManager.particleDisplay(from,to,parentNode,duration,plist,actionType)
    local particle = cc.ParticleSystemQuad:create(plist)
    particle:setPosition(from)
    particle:setDuration(duration+0.1)
    parentNode:addChild(particle)

    local moveAction = cc.MoveTo:create(duration,to)
    if 1==actionType then
    end    
    particle:runAction(moveAction)
end
]]--

function ParticleManager.monsterUseSkillParticle(parentNode,skill)
    local particle  = MetaManager.getParticle(skill.particleID)
    ParticleManager.particleDisplay(monsterXY,playerXY,parentNode,0.5,particle.path)
    
end

function ParticleManager.playerUseSkillParticle(parentNode,skill)
    local particle  = MetaManager.getParticle(skill.particleID)
    ParticleManager.particleDisplay(runeXY,monsterXY,parentNode,0.5,particle.path)
end
