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
    self.server = "https://httpbin.org"

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