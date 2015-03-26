local SkillTable = {
   [1001] = {skillID=1001,skillName='Strike',skillSum='',skillDesc='Basic Strike Attack',runeCostTable= {air=1,earth=1,water=1,fire=1},animationID = nil,growthRatio = nil,effectTable ={effectID1=1001,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1002] = {skillID=1002,skillName='Wind Sword',skillSum='',skillDesc='Basic Wind Attack',runeCostTable= {air=1,earth=0,water=0,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1002,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1003] = {skillID=1003,skillName='Wind Arrow',skillSum='',skillDesc='Advanced Wind Attack',runeCostTable= {air=2,earth=0,water=0,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1002,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1004] = {skillID=1004,skillName='Stone Sword',skillSum='',skillDesc='Basic Stone Attack',runeCostTable= {air=0,earth=1,water=0,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1003,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1005] = {skillID=1005,skillName='Stone Arrow',skillSum='',skillDesc='Advanced Stone Attack',runeCostTable= {air=0,earth=2,water=0,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1003,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1006] = {skillID=1006,skillName='Water Sword',skillSum='',skillDesc='Basic Water Attack',runeCostTable= {air=0,earth=0,water=1,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1004,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1007] = {skillID=1007,skillName='Water Arrow',skillSum='',skillDesc='Advanced Water Attack',runeCostTable= {air=0,earth=0,water=2,fire=0},animationID = nil,growthRatio = nil,effectTable ={effectID1=1004,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1008] = {skillID=1008,skillName='Fire Sword',skillSum='',skillDesc='Basic Fire Attack',runeCostTable= {air=0,earth=0,water=0,fire=1},animationID = nil,growthRatio = nil,effectTable ={effectID1=1005,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1009] = {skillID=1009,skillName='Fire Arrow',skillSum='',skillDesc='Advanced Fire Attack',runeCostTable= {air=0,earth=0,water=0,fire=2},animationID = nil,growthRatio = nil,effectTable ={effectID1=1005,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   [1100] = {skillID=1100,skillName='Minor Heal',skillSum='',skillDesc='Minor Healing', runeCostTable = {air=0,earth=0,water=2,fire=0},animationID = nil,growthRatio = nil,effectTable={effectID1=1010,effectValue1=100,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil}},
   
}
return SkillTable

-- Note: The continous Skill will consume the first and second effect slot to store both the value and duration
-- of that skill.