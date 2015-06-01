--------------------------------
-- UpgradeSkillsRequest.lua - 进入游戏的请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

UpgradeSkillsRequest = class(BaseRequest, function() return BaseRequest.create() end)

function UpgradeSkillsRequest:ctor()
    self.endpoint = "/upgradeSkills"

    local skey = DataManager.sessionKey
    self.params.skey = skey
end

function UpgradeSkillsRequest.create()
    local request = UpgradeSkillsRequest.new()
    return request
end

function UpgradeSkillsRequest.onSuccess(data)

end
