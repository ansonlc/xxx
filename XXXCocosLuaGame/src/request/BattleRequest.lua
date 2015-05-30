--------------------------------
-- BattleRequest.lua - 进入游戏的请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

BattleRequest = class(BaseRequest, function() return BaseRequest.create() end)

function BattleRequest:ctor()
    self.endpoint = "/battle"

    local skey = DataManager.sessionKey
    self.params.skey = skey
end

function BattleRequest.create()
    local request = BattleRequest.new()
    return request
end

function BattleRequest.onSuccess(data)

end
