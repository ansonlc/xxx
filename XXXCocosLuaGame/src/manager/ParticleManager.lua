ParticleManager = {}

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end

        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--monster rune and player's coordnate
local monsterXY = cc.p(1500,1500)
local runeXY = cc.p(100,1500)
local playerXY = cc.p(1500,500)

function ParticleManager.init()
    --[[local particle = MetaManager.getParticle(1001)
    ParticleManager.particleNode1 = cc.ParticleSystemQuad:create(particle.path)
    particle = MetaManager.getParticle(1002)
    ParticleManager.particleNode2 = cc.ParticleSystemQuad:create(particle.path)
    particle = MetaManager.getParticle(1003)
    ParticleManager.particleNode3 = cc.ParticleSystemQuad:create(particle.path)
    particle = MetaManager.getParticle(1004)
    ParticleManager.particleNode4 = cc.ParticleSystemQuad:create(particle.path)]]--  
    
    --ParticleManager.particleNode = nil 
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

    

    --local frameCache = cc.SpriteFrameCache:getInstance():addSpriteFrames("")
    --local textureCache = cc.TextureCache
  
    --[[if 1001 == particleID then
         ParticleManager.particleNode = ParticleManager.particleNode1
    elseif 1002 == particleID then
         ParticleManager.particleNode = ParticleManager.particleNode2
    elseif 1003 == particleID then
         ParticleManager.particleNode = ParticleManager.particleNode3
    elseif 1004 == particleID then
         ParticleManager.particleNode = ParticleManager.particleNode4
    else
        local particle = MetaManager.getParticle(particleID)
        ParticleManager.particleNode = cc.ParticleSystemQuad:create(particle.path)
    end]]--
    
    local particle = MetaManager.getParticle(particleID)
    local particleNode = cc.ParticleSystemQuad:create(particle.path)
    particleNode:setPosition(from)
    particleNode:setDuration(duration+0.1)
    parentNode:addChild(particleNode)
    
    local moveToAction = cc.MoveTo:create(duration,to)
    --particleNode:runAction(moveToAction)

    local function endOnMoveTo()
        parentNode:removeChild(particleNode,true)
    end  

    local sequence = cc.Sequence:create({moveToAction, cc.CallFunc:create(endOnMoveTo)})
    particleNode:runAction(sequence)
end

function ParticleManager.sysParticleDisplay(from,to,parentNode,duration,id)
    --local fire = cc.TextureCache.addImage()
      
    local particleNode
    if 1001 == id then 
        particleNode = cc.ParticleSun:create()
        particleNode:setStartColor(cc.c4f(1.0,0.2,0.2,1.0))
         
    elseif 1002 == id then
         --particleNode = cc.ParticleSun:create()
        particleNode = cc.ParticleSun:create()
        particleNode:setStartColor(cc.c4f(1.0,1.0,0.4,1.0))
        
    elseif 1004 == id then
         --particleNode = cc.ParticleFlower:create()
        particleNode = cc.ParticleSun:create()
        particleNode:setStartColor(cc.c4f(0.4,1.0,1.0,1.0))
    elseif 1005 == id then
         --particleNode = cc.ParticleGalaxy:create()
        particleNode = cc.ParticleSun:create()
        particleNode:setStartColor(cc.c4f(0.2,0.2,1.0,1.0))
    elseif id == 1003 then
        particleNode = cc.ParticleSun:create()
        particleNode:setStartColor(cc.c4f(1.0,0.2,1.0,1.0))
        to = cc.p(150,1800)
    end
     
    duration = 0.5 

    --particleNode.setTexture(fire)
    particleNode:setPosition(from)
    particleNode:setDuration(-1)
    particleNode:setStartSize(100)
    particleNode:setPosVar(cc.p(20,20))
    particleNode:setEmissionRate(70)
    
    
    parentNode:addChild(particleNode)
    
    local ScaleToAction0 = cc.ScaleTo:create(0.10,4)
    local ScaleToAction1 = cc.ScaleTo:create(0.08,2)
    local moveToAction = cc.MoveTo:create(0.2,to)
    local ScaleToAction = cc.ScaleTo:create(0.2,0)
    --particleNode:runAction(moveToAction)
    
    local function endOnMoveTo()
        --particleNode:removeFromParent()
        parentNode:removeChild(particleNode, true)
    end  
    
    local sequence = cc.Sequence:create({ScaleToAction0, ScaleToAction1, moveToAction, ScaleToAction, cc.CallFunc:create(endOnMoveTo)})
    particleNode:runAction(sequence)

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
