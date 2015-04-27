local Effect = class();
function Effect:ctor()
    self.effectID = '';
    self.effectTpye='';
    self.elementType='';
end

function Effect.create()
    local effect = Effect.new();
    return effect;
end
