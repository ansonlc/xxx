--------------------------------
-- RegisterRequest.lua - 注册请求
-- @author fangzhou.long
-- @version 1.0
--------------------------------

RegisterRequest = class(BaseRequest, function() return BaseRequest.create() end)

function RegisterRequest:ctor()
    self.endpoint = "/register"
end

function RegisterRequest.create()
    local request = RegisterRequest.new()
    return request
end

function RegisterRequest.onSuccess(data)
    local inst = cc.UserDefault:getInstance()
    local uuid = data.uuid
    inst:setStringForKey("uuid", uuid)
end
