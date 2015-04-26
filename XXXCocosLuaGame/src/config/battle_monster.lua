local MonsterTable = {
    [1001] = {
    	monsterID =1001,
    	monsterName='Level1',
    	monsterHP=200,
    	elementTable={physical=1.5,air=0.3,earth=0.3,water=0.3,fire=0.3},
    	skillTable={SkillID1=-10011,SkillID2=-10011,SkillID3=-10011},
        picture = "monster_air_bird"
    	},
    [1002] = {
    	monsterID =1002,
        monsterName='Level2',
    	monsterHP=400,
    	elementTable={physical=1.0,air=1.0,earth=1.0,water=1.0,fire=1.0},
    	skillTable={SkillID1=-10021,SkillID2=-10021,SkillID3=-10021},
        picture = "monster_earth_rock"
    	},
    [1003] = {
        monsterID =1003,
        monsterName='Level3',
        monsterHP=600,
        elementTable={physical=3.0,air=1.0,earth=1.0,water=1.0,fire=1.0},
        skillTable={SkillID1=-10021,SkillID2=-10021,SkillID3=-10021},
        picture = "monster_water_element"
    },
    [1004] = {
        monsterID =1004,
        monsterName='Level4',
        monsterHP=5000,
        elementTable={physical=4.0,air=0.1,earth=0.1,water=0.1,fire=0.1},
        skillTable={SkillID1=-10021,SkillID2=-10021,SkillID3=-10021},
        picture = "monster_fire_skull"
    },
}
return MonsterTable
