local Skill = class();
function Skill:ctor()
    self.skillID = '';
    self.skillName='';
    self.runeCostTable='';
    self.animationID = '';
    self.growthRatio = '';
    self.effectTable = '';    
end

function Skill.create()
    local skill = Skill.new();
    return skill;
end