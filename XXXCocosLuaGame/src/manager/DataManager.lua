require("utils.GeneralUtil")

require("utils.StringUtil")

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



--[[
DataManager = {}
]]--
local function loadData(dataName)
    DataManager[dataName] = require("config." .. dataName)
end

function DataManager.loadUserInfo()
    
    print ("load userInfo!!")
    userData = table.load("../../data/UserData.txt")
    DataManager.userInfo.availableSkills = userData[1001].availableSkills
    DataManager.userInfo.currentSkills = userData[1001].currentSkills
    
end

--[[
function DataManager.init()
    loadData("user_level_status")
    loadData("user_status")
end
]]--
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