local UserStatus = class();
function UserStatus:ctor()
    self.skillID = '';
    self.skillName='';
    self.runeCostTable='';
    self.animationID = '';
    self.growthRatio = '';
    self.effectTable = '';    
end

function UserStatus.create()
    local userStatus = UserStatus.new();
    return userStatus;
end