--------------------------------
-- NetworkManager.lua - 网络连接管理器
-- @author fangzhou.long
--------------------------------

NetworkManager = {}

function NetworkManager.init()

end

function NetworkManager.send(request, onSuccess, onFailed)
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
    
    -- リクエストの初期化  引数1 (string) HTTPメソッド  引数2 (string) アクセス先URL
    xhr:open("GET", "https://httpbin.org/get?userId=123456", true)
    
    -- 認証情報の送信の有無をBoolean型で設定
    xhr.withCredentials = true
    
    -- 通信がタイムアウトするまでの時間をNumber型で設定
    xhr.timeout = 10

    -- XHR通信開始した時間を記録
    local responseTime = TimeUtil.getRunningTime()
    
    local function onReadyStateChange()
        ---[[ HTTPステータスをNumber型で取得
        local readyState = xhr.readyState
        cclog(readyState)
        --]]
        
        ---[[ HTTPステータスをNumber型で取得
        local status = xhr.status
        cclog(status)
        --]]
        
        ---[[ HTTPレスポンスヘッダを全て取得
        local headers = xhr:getAllResponseHeaders()
        cclog(headers)
        --]]
        
        --[[ HTTPレスポンスヘッダを指定して取得  引数1 (string) ラベル名
        local header = xhr:getResponseHeader("Date")
        cclog(header)
        --]]
        
        ---[[ HTTPレスポンスボディの内容をString型で取得
        local response = xhr.response
        cclog(xhr.response)
        --]]
        
        ---[[ jsonファイルをパースしてみる
        local table = json.decode(xhr.response)
        cclog(table.origin)
        --]]
        
        -- レスポンスタームを計算
        responseTime = TimeUtil.getRunningTime() - responseTime
        cclog("Request finished in " .. responseTime .. "s")
    end

    -- 関数を登録  引数1 (function) 関数
    xhr:registerScriptHandler(onReadyStateChange)
    
    -- 関数の登録を解除 引数1 (function) 関数
    --xhr:unregisterScriptHandler(onReadyStateChange)
    
    -- registerScriptHandlerで登録した内容を用い、XHR通信を開始
    xhr:send()
    
    -- XHR通信を停止
    --xhr:abort()
    
    cclog("Request sent...")
end