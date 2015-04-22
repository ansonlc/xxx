--------------------------------
-- AnimationManager.lua - 游戏动画管理器
-- @author fangzhou.long
--------------------------------

AnimationManager = {}

local Animations = require("config.animation")

function AnimationManager.loadAnime(name)
    local cacheInst = cc.SpriteFrameCache:getInstance()
    cacheInst:addSpriteFrames(Animations[name].src)
end

function AnimationManager.init()
    AnimationManager.loadAnime("Attack1")
end

function AnimationManager.create(name, delay, loops)
    local cacheInst = cc.SpriteFrameCache:getInstance()
    local spriteFrame = cacheInst:getSpriteFrame(name .. "_01.png")
    
    --Test if the animation is loaded
    if not spriteFrame then
        cclog("Error: Animation - " .. name .. " isn't loaded. Load it in Animation.init()!")
        local sprite = cc.Sprite:create()
        sprite.runAnimation = function (self)
            cclog("Error: Running an uninitialized animation!")
        end
        return sprite
    end
    
    --Load the sprite
    local sprite = cc.Sprite:createWithSpriteFrame(spriteFrame)
    
    --Load frames from cache
    local frames = {}
    for i=1, Animations[name].frames do
        frames[i] = cacheInst:getSpriteFrame(name .. "_"
        .. ((i>10) and i or ("0" .. i))
        .. ".png")
    end
    
    --Assemble animation
    local animation = cc.Animation:createWithSpriteFrames(frames,
        delay and delay or 0.1,
        loops and loops or 1)
    animation:setRestoreOriginalFrame(false)
    local animate = cc.Animate:create(animation)
    local function endOnAnimation()
        sprite:removeFromParent(true) --And clean up
    end  
    local sequence = cc.Sequence:create({animate, cc.CallFunc:create(endOnAnimation)})
    
    --Add runAnimation method to the sprite
    sprite.runAnimation = function (self)
        self:runAction(sequence)
    end
    
    return sprite
end
