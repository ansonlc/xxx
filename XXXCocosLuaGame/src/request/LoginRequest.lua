--------------------------------
-- LoginRequest.lua - 登陆请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

LoginRequest = class(BaseRequest, function() return BaseRequest.create() end)

function LoginRequest:ctor()
    self.endpoint = "/login"
    
    local inst = cc.UserDefault:getInstance()
    local uuid = inst:getStringForKey("uuid")
    self.params.uuid = uuid
end

function LoginRequest.create()
    local request = LoginRequest.new()
    return request
end

function LoginRequest.onSuccess(data)
    local skey = data.skey
    DataManager.sessionKey = skey
end
