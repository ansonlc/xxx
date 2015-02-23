local MonsterStatus = class();
function MonsterStatus:ctor()
    self.monsterID = '';
    self.isGained='';
    self.dropRate='';
    self.defeatNum='';
end

function MonsterStatus.create()
    local monsterStatus = MonsterStatus.new();
    return monsterStatus;
end


