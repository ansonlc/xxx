require("utils.GeneralUtil")
require("utils.StringUtil")
require("config.user_skill_status")

if _G.dataManagerInit == nil then
    print("require manager.DataManager")
    
    DataManager = {
        userInfo = {},
        userData = {},
        metaDataVersion = {
            ["battle_effect"] = 1,
            ["battle_mission"] = 1,
            ["battle_monster"] = 1,
        },
        
    }
    _G.dataManagerInit = true
end

local function loadData(dataName)
    DataManager[dataName] = require("config." .. dataName)
end

function DataManager.getRecommendSkills()
    --print ('!!!')
    --print (DataManager.userInfo.currentLevelID)
    if DataManager.userInfo.currentLevelID == 101101 then
        DataManager.userInfo.currentSkills = {1002, 1004, 1006, 1008, 1001}
    end
    
    if DataManager.userInfo.currentLevelID == 101102 then
        DataManager.userInfo.currentSkills = {1002, 1004, 1008, 2000, 1001}
    end
    
    if DataManager.userInfo.currentLevelID == 101103 then
        DataManager.userInfo.currentSkills = {1100, 1400, 1004, 1008, 1006}
    end

    
    
end

function DataManager.loadUserInfo()
    
    --loadData("user_skill_status")
    --loadData("user_status")
    --local userData = table.load("../../data/UserData.txt")
    -- TODO: replace here with the data read in
    if userData == nil then
        --DataManager.userData = {}
    else
        --DataManager.userData = userData
    end
    DataManager.userData = require("config.user_status")
    DataManager.userSkillStatus = require("config.user_skill_status")
    -- TODO: Delete the predefined table
    DataManager.userInfo = {}
    DataManager.userInfo.currentUser = 1001
    DataManager.userInfo.currentSkills = DataManager.userSkillStatus[DataManager.userInfo.currentUser].currentSkills
end

--[[
function DataManager.init()
    loadData("user_level_status")
    loadData("user_status")
end
]]--

local SkillLevelTable = nil

function DataManager.expToLevel(exp)
    if SkillLevelTable == nil  then
        SkillLevelTable = MetaManager["skill_level"]
    end
    if exp < 0 then
        return 0
    end
    local x = 1
    while x+1 <= #SkillLevelTable and SkillLevelTable[x+1] <= exp do
        x = x + 1
    end
    return x
end

function DataManager.expToMax(skillID)
    if SkillLevelTable == nil  then
        SkillLevelTable = MetaManager["skill_level"]
    end
    
    return SkillLevelTable[#SkillLevelTable] - DataManager.getSkillExp(skillID)
end

function DataManager.expToNextLevelNeedExp(exp)
    if SkillLevelTable == nil  then
        SkillLevelTable = MetaManager["skill_level"]
    end
    if exp < 0 or DataManager.expToLevel(exp) == #SkillLevelTable then
        return 0;
    end
    return SkillLevelTable[DataManager.expToLevel(exp) + 1] - exp
end

function DataManager.expToRate(exp)
    if SkillLevelTable == nil  then
        SkillLevelTable = MetaManager["skill_level"]
    end
    if exp < 0 or DataManager.expToLevel(exp) == #SkillLevelTable then
        return 1;
    end
    return (exp - SkillLevelTable[DataManager.expToLevel(exp)]) / (SkillLevelTable[DataManager.expToLevel(exp) + 1] - SkillLevelTable[DataManager.expToLevel(exp)])
end

function DataManager.getStoryProgress()
    return DataManager.userData[DataManager.userInfo.currentUser].StoryProgress
end

function DataManager.setStoryProgress(num)
    DataManager.userData[DataManager.userInfo.currentUser].StoryProgress = num
end

function DataManager.getCrystalNum()
    return DataManager.userData[DataManager.userInfo.currentUser].CrystalNum;
end

function DataManager.setCrystalNum(toValue)
    DataManager.userData[DataManager.userInfo.currentUser].CrystalNum = toValue;
end

function DataManager.getUserHP()
    return DataManager.userData[DataManager.userInfo.currentUser].userHP;
end

function DataManager.setCurrentSkill(userID, toSkills)
    --self.userData[userID].currentSkills = toSkills
end

function DataManager.getAvailableSkill(userID)
    return DataManager.userSkillStatus[userID].availableSkills
end

function DataManager.getSkillExp(skillID)
    local userID = DataManager.userInfo.currentUser
    if DataManager.userSkillStatus[userID].availableSkills[skillID] ~= nil then
        return DataManager.userSkillStatus[userID].availableSkills[skillID].exp
    end
    return -1
end

function DataManager.setSkillExp(skillID, newExp)
    local userID = DataManager.userInfo.currentUser
    if DataManager.userSkillStatus[userID].availableSkills[skillID] ~= nil then
        DataManager.userSkillStatus[userID].availableSkills[skillID].exp = newExp
    end
end



function DataManager.getSkillLevel(skillID)
    return DataManager.expToLevel(DataManager.getSkillExp(skillID))
end

function DataManager.getSkillNextLevelNeedExp(skillID)
    return DataManager.expToNextLevelNeedExp(DataManager.getSkillExp(skillID))
end

function DataManager.getSkillRate(skillID)
    return DataManager.expToRate(DataManager.getSkillExp(skillID))
end

function DataManager.saveData()
    --table.save(DataManager.userData, "../../data/UserData.txt")
    --table.save(DataManager.userSkillStatus, "../../data/UserSkillStatus.txt")
end

function DataManager.getLevel(userID)
	return nil
end

function DataManager.getUserLevelStatus(userID, levelNum)
	return nil
end

function DataManager.getMonsterStatus(userID, monsterID)
	return nil
end

function DataManager.getSkillStatus(userID, skillID)
	return nil
end

function DataManager.getUserStatus(userID)
	return DataManager[userID]
end


function DataManager.setUserLevelStatus(userLevelStatus)
	return nil
end

function DataManager.setMonsterStatus(monsterStatus)
	return nil
end

function DataManager.setSkillStatus(skillStatus)
	return nil
end

function DataManager.setUserStatus(userStatus)
	return nil
end