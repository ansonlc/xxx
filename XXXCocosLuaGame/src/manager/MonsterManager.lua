require("battle/MonsterTable")

MonsterManager={}

function MonsterManager.getMonster(monsterID)
    if MonsterManager.MonsterTable == nil 
    then
        MonsterManager.MonsterTable = getMonsterTable()
    end
    local monster = MonsterManager.MonsterTable[monsterID]
    return monster
end