require("utils.GeneralUtil")

if _G.dataManagerInit == nil then
    print("require manager.DataManager")
    
    DataManager = {
        userInfo = {},
        
        metaDataVersion = {
            ["battle_effect"] = 1,
            ["battle_mission"] = 1,
            ["battle_monster"] = 1,
        },
        
    }
    _G.dataManagerInit = true
end

function DataManager.loadUserInfo()
    print ("load userInfo")
    DataManager.userInfo.availableSkills = allSkill()
    DataManager.userInfo.currentSkills = {1001, 1002, 1003, 1004, 1005}
end


DataManager = {}

local function loadData(dataName)
    DataManager[dataName] = require("config." .. dataName)
end

function DataManager.init()
    loadData("user_level_status")
    loadData("user_status")
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