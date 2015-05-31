--------------------------------
-- BaseRequest.lua - 模板请求
-- @author fangzhou.long
-- @version 1.0
-- TEMPLATE This is a template request
--------------------------------

--------------------------------
--  Base request for every request
-- @module request.BaseRequest
-- @extend cc.EventDispatcher
BaseRequest = class(cc.EventDispatcher)

--------------------------------
--  Constructor of the request, will be execute when called "new"
-- @function [parent=#BaseRequest] ctor
-- @param self 
function BaseRequest:ctor()
    -- Request server address
    self.server = "http://oristein.com"
    --self.server = "http://localhost:21401/www"

    -- Request method, can be GET/POST, default POST
    self.method = "POST"
    
    -- Request end point, should be /xxx
    self.endpoint = ""
    
    -- Request parameters, should be a table
    self.params = {}
    
    -- Request body
    self.body = ""
end

--------------------------------
--  Create method of the request, will be execute when called
--  @function [parent=#BaseRequest] create
--  @return #cc.EventDispatcher Created request
function BaseRequest.create()
    local request = BaseRequest.new()
    return request
end

function BaseRequest.onSuccess(data)
    cclog("WARN: No success handler for " .. request.endpoint)
end

function BaseRequest.onFail(data)
    cclog("WARN: No failed handler for this request")
end

function BaseRequest.postRequest() end