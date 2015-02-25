--Level id explaination:
--1AABCC
--10 : Fixed level id header
--A : World number
--B : Chapter number
--C : Level number
local battle_mission = {
    [1]={id=101101,missionName="Blessing Wind",levelMin=1,preMissionId=0,missionType=0,missionBossType=0},
    [2]={id=101102,missionName="Middle Earth",levelMin=1,preMissionId=101101,missionType=0,missionBossType=0},
    [3]={id=101103,missionName="Mystery Ocean",levelMin=1,preMissionId=101102,missionType=0,missionBossType=0},
    [4]={id=101104,missionName="Flaming Mountain",levelMin=1,preMissionId=101103,missionType=0,missionBossType=0},
    [5]={id=101105,missionName="Crystal Mine",levelMin=1,preMissionId=101104,missionType=0,missionBossType=0},
}
return battle_mission
