--------------------------------
-- InitRequest.lua - 游戏初始化请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

InitRequest = class(BaseRequest, function() return BaseRequest.create() end)

function InitRequest:ctor()
    self.endpoint = "/init"
    
    local inst = cc.UserDefault:getInstance()
    local uuid = inst:getStringForKey("uuid")
    local skey = DataManager.sessionKey
    
    self.params.skey = skey
    self.params.uuid = uuid
end

function InitRequest.create()
    local request = InitRequest.new()
    return request
end

function InitRequest.onSuccess(data)
    local realSkills = {}
    for key, value in pairs(data.skillInfo) do
        table.insert(realSkills, value["skillID"], value)
    end
    
    DataManager.setCrystalNum(data.userInfo.crystal)
    
    DataManager.userSkillStatus[DataManager.userInfo.currentUser].availableSkills = realSkills
    DataManager.userSkillStatus[DataManager.userInfo.currentUser].currentSkills = allSkill()
    
    ---[[
    local maxMissionId = 0
    
    for key, value in pairs(data.missionInfo) do
        if value.missionID then
            maxMissionId = maxMissionId>value.missionID and maxMissionId or value.missionID
        end
    end
    --]]
    local _, nowLevelKey = GeneralUtil.getSubTableByKey(MetaManager["battle_mission"], 
        {name = "id", value = maxMissionId})
    DataManager.setStoryProgress(nowLevelKey==-1 and 0 or nowLevelKey)
end
