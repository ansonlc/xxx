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

end
