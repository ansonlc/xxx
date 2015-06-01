----Level id explaination:
--1AABCC
--10 : Fixed level id header
--A : World number
--B : Chapter number
--C : Level number
-- monster id
-- skill acquired
-- missionType : Normal/Activity/Time Limited mission
-- missionElement : 
local battle_mission = {
    --[[
    [1]={id=101101,missionName="Blessing Wind",levelMin=1,preMissionId=0,missionType=0,missionBossType=0,missionBossID=1001},
    [2]={id=101102,missionName="Middle Earth",levelMin=1,preMissionId=101101,missionType=0,missionBossType=0,missionBossID=1002},
    [3]={id=101103,missionName="Mystery Ocean",levelMin=1,preMissionId=101102,missionType=0,missionBossType=0,missionBossID=1003},
    [4]={id=101104,missionName="Flaming Mountain",levelMin=1,preMissionId=101103,missionType=0,missionBossType=0,missionBossID=1004},
    [5]={id=101105,missionName="Crystal Mine",levelMin=1,preMissionId=101104,missionType=0,missionBossType=0,missionBossID=1001},
    ]]--
    [1]={id=101101,missionName="Blessing Wind",levelMin=1,preMissionId=0,missionType=0,isBossLevel=false,missionBossType=1,missionBossID=1001},
    [2]={id=101102,missionName="Middle Earth",levelMin=1,preMissionId=0,missionType=0,isBossLevel=true,missionBossType=2,missionBossID=1002},
    [3]={id=101103,missionName="Mystery Ocean",levelMin=1,preMissionId=0,missionType=0,isBossLevel=false,missionBossType=3,missionBossID=1003},
    [4]={id=101104,missionName="Flaming Mountain",levelMin=1,preMissionId=0,missionType=0,isBossLevel=false,missionBossType=4,missionBossID=1004},
    [5]={id=101105,missionName="Crystal Mine",levelMin=1,preMissionId=0,missionType=0,isBossLevel=false,missionBossType=1,missionBossID=1005},
    [6]={id=101106,missionName="And Then There Were None",levelMin=1,preMissionId=0,missionType=0,isBossLevel=true,missionBossType=2,missionBossID=1006},
  --[7]={id=101107,missionName=">_<",levelMin=1,preMissionId=0,isBossLevel=true,missionType=0,missionBossType=0,missionBossID=1007},
}
return battle_mission
