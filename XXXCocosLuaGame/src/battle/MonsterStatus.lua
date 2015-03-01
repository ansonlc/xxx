local MonsterStatus = class();
function MonsterStatus:ctor()
    self.userID = '';
    self.monsterID = '';
    self.isTamed='';
    self.dropRate='';
    self.killedCount='';
end

function MonsterStatus.create()
    local monsterStatus = MonsterStatus.new();
    return monsterStatus;
end


