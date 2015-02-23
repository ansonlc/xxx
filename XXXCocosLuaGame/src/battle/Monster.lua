local Monster = class();
function Monster:ctor()
    self.monsterID = '';
    self.monsterName='';
    self.monsterHP='';
    self.elementTable='';
    self.skillTable='';
end

function Monster.create()
    local monster = Monster.new();
    return monster;
end