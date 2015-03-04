local Level = class();
function Level:ctor()
    self.levelNum = '';
    self.monsterID='';
    self.Description='';
end

function Level.create()
    local level = Level.new();
    return level;
end