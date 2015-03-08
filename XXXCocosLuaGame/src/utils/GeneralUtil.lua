--------------------------------
-- utils.lua
-- @author Gaoyuan Chen
--------------------------------

require("manager.MetaManager")

local function getAllKeys(t)
    ret = {}
    for key in pairs(t) do
        table.insert(ret, key)
    end
    return ret
end

function allSkill()
    return getAllKeys(MetaManager.getSkillTable())
end
