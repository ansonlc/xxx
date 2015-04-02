--------------------------------
-- utils.lua
-- @author Gaoyuan Chen
--------------------------------

require("manager.MetaManager")

local function getAllKeys(t)
    local ret = {}
    for key in pairs(t) do
        table.insert(ret, key)
    end
    return ret
end

function allSkill()
    --ret = getAllKeys(MetaManager.getSkillTable())
    local ret = getAllKeys(DataManager.getAvailableSkill(DataManager.userInfo.currentUser))
    table.sort(ret)
    return ret
end
