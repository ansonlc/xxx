local SkillStatus = class();
function SkillStatus:ctor()
    self.skillID = '';
    self.isLearned='';
    self.experience='';
    self.skillLevel = '';  
end


function SkillStatus.create()
    local skillStatus = SkillStatus.new();
    return skillStatus;
end