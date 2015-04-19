--------------------------------
-- utils.lua
-- @author Gaoyuan Chen
--------------------------------

require("manager.MetaManager")

GeneralUtil = {}

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

----------------------------------------
-- Description: 从 目标表 中根据 键名和键值 获得 相关子表 的函数
-- Warning: 朴素遍历，仅返回满足条件的第一张子表，及其key
-- Note: 仅在查询的键值不是主键时使用
--[[
Example: 从card_meta表中获取 "id" 的值为 "101011" 的卡片子表
local aCard, cardNo = GeneralUtil.getSubTableByKey(
MetaManager.card_meta,
{name = "id", value = "101011"}
)
]]
function GeneralUtil.getSubTableByKey(sourceTable, key)
    local subTable = nil
    local keyNo = -1
    for aKey, aValue in pairs(sourceTable) do
        if (tostring(sourceTable[aKey][key.name])==tostring(key.value)) then
            subTable = sourceTable[aKey]
            keyNo = aKey
            break;
        end
    end
    return subTable,keyNo
end
