--------------------------------------------------------------------------------
-- CreditScene.lua
-- @author fangzhou.long
--------------------------------------------------------------------------------

local CreditScene = class("CreditScene", function() return BaseScene.create() end)

function CreditScene:ctor()
    self.sceneName = "CreditScene"
    self.scrollView = nil
end

function CreditScene.create(params)
    local scene = CreditScene.new()
    scene:initScene(params)
    return scene
end

function CreditScene:onInit()
    local rootNode = cc.CSLoader:createNode("CreditScene.csb")
    local function onRtnTouch(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then
            local params = SceneManager.generateParams(self, "MainMenuScene", nil)
            SceneManager.replaceSceneWithName("MainMenuScene", params)
        end
    end
    local rtnNode = rootNode:getChildByName("node_rtn_btn");
    local rtnBtn = GameButton.create("ReturnBtn", true, 0.5)
    rtnBtn:addTouchEventListener(onRtnTouch)
    rtnNode:addChild(rtnBtn)
    
    
    self.scrollView = rootNode:getChildByName("scroll_credit")
    print(self.scrollView:getInnerContainer():getPosition())
    self:addChild(rootNode)
end

local pos = -1500
function CreditScene:onUpdate()
    if pos<0 and self.scrollView then
        self.scrollView:getInnerContainer():setPosition(cc.p(0, pos))
        pos = pos + 2
    end
end

return CreditScene