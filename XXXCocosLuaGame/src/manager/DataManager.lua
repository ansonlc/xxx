require("utils.GeneralUtil")

DataManager = {
    userInfo = {},
    
    metaDataVersion = {
        ["battle_effect"] = 1,
        ["battle_mission"] = 1,
        ["battle_monster"] = 1,
    },
    
}

function DataManager.loadUserInfo()
    print ("load userInfo")
    DataManager.userInfo.availableSkills = allSkill()
    DataManager.userInfo.availableSkills[1006] = nil
    DataManager.userInfo.availableSkills[1007] = nil
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
	return nil
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