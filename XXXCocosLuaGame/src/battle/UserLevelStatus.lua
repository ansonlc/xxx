local UserLevelStatus = class();
function UserLevelStatus:ctor()
    self.userID = '';
    self.levelNum='';
    self.score = '';
end

function UserLevelStatus.create()
    local userLevelStatus = UserLevelStatus.new();
    return userLevelStatus;
end