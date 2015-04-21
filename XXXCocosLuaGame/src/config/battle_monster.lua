local MonsterTable = {
    [1001] = {
    	monsterID =1001,
    	monsterName='Air Fairy',
    	monsterHP=200,
    	elementTable={physical=1.5,air=0.1,earth=0.1,water=0.1,fire=0.1},
    	skillTable={SkillID1=-10011,SkillID2=-10011,SkillID3=-10011},
    	picture = "pink_monster"
    	},
    [1002] = {
    	monsterID =1002,
    	monsterName='pipikachu~',
    	monsterHP=2000,
    	elementTable={physical=0.1,air=0.1,earth=0.1,water=0.1,fire=0.1},
    	skillTable={SkillID1=-10021,SkillID2=-10021,SkillID3=-10021},
    	picture = "pikachu"
    	},
    [1003] = {monsterID =1003,monsterName='Water Fairy',monsterHP=600,elementTable={physical=0.5,air=0.5,earth=1.0,water=-1.0,fire=0.0},skillTable={SkillID1=1001,SkillID2=1006,SkillID3=1007}},
    [1004] = {monsterID =1004,monsterName='Fire Fairy',monsterHP=400,elementTable={physical=0.5,air=0,earth=0.25,water=1.0,fire=-1.0},skillTable={SkillID1=1001,SkillID2=1008,SkillID3=1009}},
}
return MonsterTable
