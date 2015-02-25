local UserStatus = class();
function UserStatus:ctor()
    self.userId = '';
    self.userName='';
    self.userLevel='';
    self.userHP = '';
    self.CrystalNum = '';
    self.EndlessScore = '';    
	self.ItemTable = '';
end

function UserStatus.create()
    local userStatus = UserStatus.new();
    return userStatus;
end