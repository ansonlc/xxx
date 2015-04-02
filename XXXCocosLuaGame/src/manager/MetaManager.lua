MetaManager = {}

local function loadMetaData(metaName)
    MetaManager[metaName] = require("config." .. metaName)
end

function MetaManager.init()
    loadMetaData("skill_effect")
    loadMetaData("battle_mission")
    loadMetaData("battle_monster")
    loadMetaData("battle_skill")
end

function MetaManager.checkMetaVersion(metaName)
    --[[if (DataManager.metaDataVersion[metaName] and
        DataManager.metaDataVersion[metaName]==1) then
        return
    end--]]
    
    -- TODO Pull new meta data from server
    --loadMetaData(metaName)
end

function MetaManager.getEffect(effectID)
    MetaManager.checkMetaVersion("skill_effect")
    local effect = MetaManager["skill_effect"][effectID]
    return effect
end

function MetaManager.getMonster(monsterID)
    MetaManager.checkMetaVersion("battle_monster")
    local monster = MetaManager["battle_monster"][monsterID]
    return monster
end

function MetaManager.getSkillTable()
    MetaManager.checkMetaVersion("battle_skill")
    return MetaManager["battle_skill"]
end

function MetaManager.getMissionTable()
    MetaManager.checkMetaVersion("battle_mission")
    return MetaManager["battle_mission"]
end

function MetaManager.getMission(missionID)
    MetaManager.checkMetaVersion("battle_mission")
    local monster = MetaManager["battle_mission"][missionID]
    return monster
end

function MetaManager.getSkill(skillID)
    MetaManager.checkMetaVersion("battle_skill")
    local skill = MetaManager["battle_skill"][skillID]
    return skill
end