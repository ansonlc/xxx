
local monsterSkill = function(eff1, eff2, eff3)
    local effectTable = {}
    if eff1 ~= nil then
        local t = eff1
        effectTable.effectID1 = t[1]
        effectTable.effectValue1 = t[2]
    end
    if eff2 ~= nil then
        local t = eff2
        effectTable.effectID2 = t[1]
        effectTable.effectValue2 = t[2]
    end
    if eff3 ~= nil then
        local t = eff3
        effectTable.effectID3 = t[1]
        effectTable.effectValue3 = t[2]
    end
    ret = {effectTable = effectTable}
    return ret
end

local damage = 1001

local SkillTable = {

    -- monster skills
    [-10011] = monsterSkill({damage, 10}, nil, nil),
    [-10021] = monsterSkill({damage, 30}, nil, nil),
    



    -- Attack skills
    [1001] = {skillID=1001,skillQuality=1,skillName='Strike',runeCostTable= {air=1,earth=1,water=1,fire=1},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1001,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Strike Attack'},
    [1002] = {skillID=1002,skillQuality=2,skillName='Wind Sword',runeCostTable= {air=1,earth=0,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1002,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Wind Attack'},
    [1003] = {skillID=1003,skillQuality=3,skillName='Wind Arrow',runeCostTable= {air=2,earth=0,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1002,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Advanced Wind Attack'},
    [1004] = {skillID=1004,skillQuality=2,skillName='Stone Sword',runeCostTable= {air=0,earth=1,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1003,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Stone Attack'},
    [1005] = {skillID=1005,skillQuality=3,skillName='Stone Arrow',runeCostTable= {air=0,earth=2,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1003,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Advanced Stone Attack'},
    [1006] = {skillID=1006,skillQuality=2,skillName='Water Sword',runeCostTable= {air=0,earth=0,water=1,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1004,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Water Attack'},
    [1007] = {skillID=1007,skillQuality=3,skillName='Water Arrow',runeCostTable= {air=0,earth=0,water=2,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1004,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Advanced Water Attack'},
    [1008] = {skillID=1008,skillQuality=2,skillName='Fire Sword',runeCostTable= {air=0,earth=0,water=0,fire=1},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1005,effectValue1=25,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Fire Attack'},
    [1009] = {skillID=1009,skillQuality=3,skillName='Fire Arrow',runeCostTable= {air=0,earth=0,water=0,fire=2},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1005,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Advanced Fire Attack'},
    [1010] = {skillID=1010,skillQuality=1,skillName='Slash',runeCostTable= {air=2,earth=2,water=2,fire=2},animationID = nil,particleID = nil,growthRatio = 1,CD = 2,effectTable ={effectID1=1001,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Basic Slash Attack'},
    -- Heal skills
    [1100] = {skillID=1100,skillQuality=4,skillName='Minor Heal',runeCostTable = {air=2,earth=0,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 5,effectTable={effectID1=1010,effectValue1=50,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Healing'},
    [1101] = {skillID=1101,skillQuality=4,skillName='Major Heal',runeCostTable = {air=0,earth=0,water=5,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 7,effectTable={effectID1=1010,effectValue1=200,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Healing'},
    -- Shell skills
    [1200] = {skillID=1200,skillQuality=4,skillName='Minor Shell',runeCostTable = {air=0,earth=3,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 30,effectTable={effectID1=1020,effectValue1= 120,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Shell'},
    -- Recovery skill
    [1300] = {skillID=1300,skillQuality=5,skillName='Minor Recovery',runeCostTable = {air=2,earth=0,water=2,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 30,effectTable={effectID1=1030,effectValue1=10,effectID2=1030,effectValue2=20,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Recovery'},
    -- Bleed skills
    [1400] = {skillID=1400,skillQuality=6,skillName='Minor Bleed',runeCostTable = {air=0,earth=0,water=0,fire=2},animationID = nil,particleID = nil,growthRatio = 1,CD = 3,effectTable={effectID1=1040,effectValue1=5,effectID2=1040,effectValue2=10,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Bleed'},
    -- Silence skills
    [1500] = {skillID=1500,skillQuality=4,skillName='Minor Silence',runeCostTable = {air=0,earth=4,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 20,effectTable={effectID1=1050,effectValue1=0,effectID2=1050,effectValue2=4,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Silence'},
    -- Bless skills
    [1600] = {skillID=1600,skillQuality=4,skillName='Minor Bless',runeCostTable = {air=1,earth=1,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1,CD = 10,effectTable={effectID1=1060,effectValue1=2,effectID2=1060,effectValue2=20,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Bless'},
    -- Curse skills
    [1700] = {skillID=1700,skillQuality=4,skillName='Minor Curse',runeCostTable = {air=0,earth=1,water=0,fire=1},animationID = nil,particleID = nil,growthRatio = 1,CD = 5,effectTable={effectID1=1070,effectValue1=1,effectID2=1070,effectValue2=20,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Curse'},
    -- Bravery skills
    [1800] = {skillID=1800,skillQuality=7,skillName='Minor Bravery',runeCostTable = {air=0,earth=0,water=0,fire=2},animationID = nil,particleID = nil,growthRatio = 1,CD = 10,effectTable={effectID1=1080,effectValue1=2.0,effectID2=1080,effectValue2=10,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Bravery'},
    -- Fear skills
    [1900] = {skillID=1900,skillQuality=7,skillName='Minor Fear',runeCostTable = {air=0,earth=1,water=1,fire=3},animationID = nil,particleID = nil,growthRatio = 1,CD = 30,effectTable={effectID1=1090,effectValue1=0.4,effectID2=1090,effectValue2=20,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Fear'},   
    -- Purify skills
    [2000] = {skillID=2000,skillQuality=1,skillName='Minor Purify',runeCostTable = {air=0,earth=0,water=2,fire=0},animationID = nil,particleID = nil,growthRatio = 1, CD = 10, effectTable={effectID1=1100,effectValue1=nil,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Fear'},
    -- Disperse skills
    [2100] = {skillID=2100,skillQuality=1,skillName='Minor Disperse',runeCostTable = {air=2,earth=0,water=0,fire=0},animationID = nil,particleID = nil,growthRatio = 1, CD = 10, effectTable={effectID1=1110,effectValue1=nil,effectID2=nil,effectValue2=nil,effectID3=nil,effectValue3=nil},skillSum='',skillDesc='Minor Fear'},
    
}


return SkillTable

-- Note: The continous Skill will consume the first and second effect slot to store both the value and duration
-- of that skill.