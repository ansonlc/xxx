MetaManager = {}

local function loadMetaData(metaName)
    MetaManager[metaName] = require("config." .. metaName)
end

function MetaManager.init()
    loadMetaData("skill_effect")
    loadMetaData("battle_mission")
    loadMetaData("battle_monster")
    loadMetaData("battle_skill")
    loadMetaData("particle_effect")
    loadMetaData("skill_level")
    loadMetaData("ui_button")
end

function MetaManager.checkMetaVersion(metaName)
    --[[if (DataManager.metaDataVersion[metaName] and
        DataManager.metaDataVersion[metaName]==1) then
        return
    end--]]
    
    -- TODO Pull new meta data from server
    --loadMetaData(metaName)
end

function MetaManager.getBtnUI(text)
    MetaManager.checkMetaVersion("ui_button")
    return MetaManager["ui_button"][text]
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

function MetaManager.getParticle(particleID)
    MetaManager.checkMetaVersion("particle_effect")
    local particle = MetaManager["particle_effect"][particleID]
    return particle
end

function MetaManager.getSkillLevel(level)
    --MetaManager.checkMetaVersion("")
    local level = MetaManager["skill_level"][level]
    return level
end