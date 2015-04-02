require("utils.GeneralUtil")

require("utils.StringUtil")

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




DataManager = {}

local function loadData(dataName)
    DataManager[dataName] = require("config." .. dataName)
end

function DataManager.loadUserInfo()
    
    print ("load userInfo!!")
    --cclog("Loading the user information")
    loadData("user_skill_status")
    local userData = table.load("../../data/UserData.txt")
    -- TODO: replace here with the data read in
    if userData == nil then
        DataManager.userData = {}
    else
        DataManager.userData = userData
    end
    DataManager.userSkillStatus = UserSkillStatusTable
    DataManager.userInfo = {}
    DataManager.userInfo.currentSkills = {1001, 1100, 1200, 1300, 1400}
end

--[[
function DataManager.init()
    loadData("user_level_status")
    loadData("user_status")
end
]]--

function DataManager.setCurrentSkill(userID, toSkills)
    --self.userData[userID].currentSkills = toSkills
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