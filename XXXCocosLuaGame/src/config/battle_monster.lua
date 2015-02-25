local MonsterTable = {
    [1001] = {monsterID =1001,monsterName='Air Fairy',monsterHP=500,elementTable={physical=0.75,air=-1.0,earth=0.0,water=0.5,fire=0.5},skillTable={SkillID1=1001,SkillID2=1002,SkillID3=1003}},
    [1002] = {monsterID =1002,monsterName='Earth Fairy',monsterHP=500,elementTable={physical=0.75,air=1.0,earth=-1.0,water=0.0,fire=0.5},skillTable={SkillID1=1001,SkillID2=1004,SkillID3=1005}},
    [1003] = {monsterID =1003,monsterName='Water Fairy',monsterHP=600,elementTable={physical=0.5,air=0.5,earth=1.0,water=-1.0,fire=0.0},skillTable={SkillID1=1001,SkillID2=1006,SkillID3=1007}},
    [1004] = {monsterID =1004,monsterName='Fire Fairy',monsterHP=400,elementTable={physical=0.5,air=0,earth=0.25,water=1.0,fire=-1.0},skillTable={SkillID1=1001,SkillID2=1008,SkillID3=1009}},
}
return MonsterTable
