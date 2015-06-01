--------------------------------
-- NetworkManager.lua - 网络连接管理器
-- @author fangzhou.long
--------------------------------

NetworkManager = {}

function NetworkManager.init()
    NetworkManager.useJson = true
    require("request.RegisterRequest")
    require("request.LoginRequest")
    require("request.InitRequest")
    require("request.BattleRequest")
    require("request.BattleResultRequest")
    require("request.UpgradeSkillsRequest")
end

local function showLoadingBox()
    local ccRunning = cc.Director:getInstance():getRunningScene()
    if ccRunning then
        ccRunning:showLoadingPanel()
    end
end

local function killLoadingBox()
    local ccRunning = cc.Director:getInstance():getRunningScene()
    if ccRunning then
        ccRunning:closeLoadingPanel()
    end
end

local function xhrBuilder(request)
    -- インスタンス宣言 XMLHttpRequestの慣例に従い、createではなくnewになっている模様
    local xhr = cc.XMLHttpRequest:new()

    --[[ HTTPレスポンスボディのデータ型をNumber型（以下の定数が使えます）で設定
    0 : cc.XMLHTTPREQUEST_RESPONSE_STRING
    1 : cc.XMLHTTPREQUEST_RESPONSE_ARRAY_BUFFER
    2 : cc.XMLHTTPREQUEST_RESPONSE_BLOB
    3 : cc.XMLHTTPREQUEST_RESPONSE_DOCUMENT
    4 : cc.XMLHTTPREQUEST_RESPONSE_JSON
    ]]
    xhr.responseText = cc.XMLHTTPREQUEST_RESPONSE_JSON

    local params = ""
    local first = true
    if request.params then
        for key, value in pairs(request.params) do
            print(key)
            print(value)
            params = params .. (first and "" or "&") .. tostring(key) .. "=" .. tostring(value)
            first = false
        end
    end
    local trueUrl = request.server .. request.endpoint .. ".php"
    -- リクエストの初期化  引数1 (string) HTTPメソッド  引数2 (string) アクセス先URL
    cclog(trueUrl)
    cclog(params)
    xhr:open(request.method, trueUrl, true)
    request.body = params

    -- 認証情報の送信の有無をBoolean型で設定
    xhr.withCredentials = true

    -- 通信がタイムアウトするまでの時間をNumber型で設定
    xhr.timeout = 3
    
    return xhr
end

local function doSuccess(request, data)
    request.onSuccess(data)
    request.postRequest()
    killLoadingBox()
end

local function doFail(request, data)
    request.onFail(data)
    killLoadingBox()
    
    local reconnectMessage = {
        title="Error: " .. data.retcode,
        msg= data.errmsg,
        btn= data.btn,
        callback = data.callback,
    }
    local ccRunning = cc.Director:getInstance():getRunningScene()
    if ccRunning.messageBoxPanel then
        ccRunning:removeChild(ccRunning.messageBoxPanel, true)
    end
    local MessageBoxPanel = require("panel.MessageBoxPanel")
    ccRunning.messageBoxPanel = MessageBoxPanel.create(ccRunning, reconnectMessage)
end

function NetworkManager.send(request)
    showLoadingBox()
    
    local xhr = xhrBuilder(request)

    -- XHR通信開始した時間を記録
    local requestTime = TimeUtil.getRunningTime()
    local nowServerTime = TimeUtil.getServerTime()
    
    local retryCount = 0
    local function onReadyStateChange()
        ---[[ HTTPステータスをNumber型で取得
        local readyState = xhr.readyState
        cclog("Ready state " .. readyState)
        --]]
        
        ---[[ HTTPステータスをNumber型で取得
        local status = xhr.status
        cclog("HTTP status code " .. status)
        --]]
        
        if readyState == 4 then
            if status == 200 then
                -- レスポンスタームを計算
                requestTime = TimeUtil.getRunningTime() - requestTime
                cclog("Request received at " .. TimeUtil.getTimeString())
                cclog("Request finished in " .. requestTime .. "s")
                
                ---[[ HTTPレスポンスヘッダを全て取得
                local headers = xhr:getAllResponseHeaders()
                --cclog(headers)
                --]]

                --[[ HTTPレスポンスヘッダを指定して取得  引数1 (string) ラベル名
                local header = xhr:getResponseHeader("Date")
                cclog(header)
                --]]

                -- HTTPレスポンスボディの内容をString型で取得
                local response = xhr.response

                if NetworkManager.useJson then
                    ---[[ jsonファイルをパースしてみる
                    cclog(xhr.response)
                    local data = json.decode(xhr.response)
                    --cclog(data.origin)
                    --]]
                    
                    if data.retcode then
                        cclog("Request error code: " .. data.retcode)
                        cclog(data.errmsg)
                        data.errmsg = "You need to login again"
                        data.btn = "Login"
                        data.callback = function()  SceneManager.replaceSceneWithName("LoginScene")  end
                        doFail(request, data)
                    else
                        doSuccess(request, data)
                    end
                    
                    if data.serverTime then
                        --Since the server returns the request time,
                        --so it's more accurate to calculate use local request time
                        _G.__g_utcDiffSeconds = nowServerTime - data.serverTime
                    end
                else
                    cclog(xhr.response)
                    doSuccess(request, response)
                end
            else
                local data = {}
                data.retcode = "Network Unavailable"
                data.errmsg = "Please connect to network and \npress 'Retry' to reconnect."
                data.btn = "Retry"
                data.callback = function()
                    NetworkManager.send(request)
                end
                doFail(request, data)
            end
        else
            if retryCount<5 then
                cclog("Try to resend the request " .. request.endpoint .. " " .. retryCount+1 .. " time(s).")
                xhr = xhrBuilder(request)
                xhr:registerScriptHandler(onReadyStateChange)
                xhr:send(request.body)
                retryCount = retryCount + 1
            else
                local data = {}
                data.retcode = "Network Unavailable"
                data.errmsg = "Please connect to network and \npress 'Retry' to reconnect."
                data.btn = "Retry"
                data.callback = function()
                    NetworkManager.send(request)
                end
                doFail(request, data)
            end
        end
    end

    -- 関数を登録  引数1 (function) 関数
    xhr:registerScriptHandler(onReadyStateChange)
    
    -- 関数の登録を解除 引数1 (function) 関数
    --xhr:unregisterScriptHandler(onReadyStateChange)
    
    -- registerScriptHandlerで登録した内容を用い、XHR通信を開始
    xhr:send(request.body)
    
    -- XHR通信を停止
    --xhr:abort()
    
    cclog("Request sent at " .. TimeUtil.getTimeString())
end