ParticleManager = {}

--------------------------------
--  display particle from one point to another in some duration
--  @param #cc.p from the start point
--  @param #cc.p to the end point
--  @param #cc.node parentNode the parent node which the new particle will add to
--  @param #float duration the particle effect duration
--  @param #string plist the filename of the particle
--  @param #int actionType 0 means use straight line, 1 means use arc
function ParticleManager.particleDisplay(from,to,parentNode,duration,plist)
    local particle = cc.ParticleSystemQuad:create(plist)
    particle:setPosition(from)
    particle:setDuration(duration+0.1)
    parentNode:addChild(particle)

    local moveToAction = cc.MoveTo:create(duration,to)
    particle:runAction(moveToAction)
end

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
