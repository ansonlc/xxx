--------------------------------
-- BattleResultRequest.lua - 游戏结算的请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

BattleResultRequest = class(BaseRequest, function() return BaseRequest.create() end)

function BattleResultRequest:ctor()
    self.endpoint = "/battleResult"

    local skey = DataManager.sessionKey
    self.params.skey = skey
end

function BattleResultRequest.create()
    local request = BattleResultRequest.new()
    return request
end

function BattleResultRequest.onSuccess(data)

end
