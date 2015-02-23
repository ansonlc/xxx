require("battle.EffectTable")

EffectManager={}

function EffectManager.getEffect(effectID)
    if EffectManager.EffectTable == nil then
        EffectManager.EffectTable = getEffectTable()
    end
    local effect = EffectManager.EffectTable[effectID]
    return effect
end
