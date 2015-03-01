local UserLevelStatus = class();
function UserLevelStatus:ctor()
    self.userId = '';
    self.levelNum='';
    self.score = '';
end

function UserLevelStatus.create()
    local userLevelStatus = UserLevelStatus.new();
    return userLevelStatus;
end