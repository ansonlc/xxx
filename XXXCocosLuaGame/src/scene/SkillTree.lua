--------------------------------
-- SkillTree.lua
-- @author Gaoyuan Chen
--------------------------------

require("utils.GeneralUtil")

local battle_mission_cfg = require("config.battle_mission")
local SkillTagHeader = 10000
local currentSelect = 0
local SkillTree = class("SkillTree", function() return BaseScene.create() end)

local currentCrystalNumDisplay = 0001000;

function SkillTree:ctor()
    self.sceneName = "SkillTree"
end

function SkillTree.create(params)
    local scene = SkillTree.new()
    scene:initScene(params)
    return scene
end

local skillIcons = {}
local skillSlotButton = {}
local currentSelect = nil
local tabSelect = 1

function toString6(x)
    local ret = x .. ""
    while string.len(ret) < 6 do
        ret = '0' .. ret
    end
    return ret
end

function SkillTree:updateCrystalNum()
    self.CrystalNumDisplay:setString(toString6(currentCrystalNumDisplay))
end

function SkillTree:drawSkillInfo()
    if self.currentSelectSkill ~= nil then
        self.currentSelectSkill.skillIcon:setVisible(false)
        self.currentSelectSkill.skillName:setVisible(false)
        self.currentSelectSkill.skillDesc:setVisible(false)
        self.currentSelectSkill.skillLevel:setVisible(false)
    end
    
    
    self.currentSelectSkill = {}
    
    -- Icon
    if (currentSelect ~= nil) then
        self.currentSelectSkill.skillIcon = self:getSkillButton(currentSelect)
        self.currentSelectSkill.skillIcon:setPosition(cc.p(145, 275))
        self:addChild(self.currentSelectSkill.skillIcon)

    end
    
    local skill = MetaManager.getSkill(currentSelect)
    -- Name
    self.currentSelectSkill.skillName = cc.LabelTTF:create("[" .. currentSelect .. "] " .. skill.skillName , "Arial", 35)
    self.currentSelectSkill.skillName:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillName:setPosition(cc.p(650, 190))
    self:addChild(self.currentSelectSkill.skillName)
    
    -- Desc
    self.currentSelectSkill.skillDesc = cc.LabelTTF:create(skill.skillDesc , "Arial", 35)
    self.currentSelectSkill.skillDesc:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillDesc:setPosition(cc.p(650, 140))
    self:addChild(self.currentSelectSkill.skillDesc)
    
    -- Level
    self.currentSelectSkill.skillLevel = cc.LabelTTF:create("42" , "Arial", 35)
    self.currentSelectSkill.skillLevel:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillLevel:setPosition(cc.p(350, 335))
    self:addChild(self.currentSelectSkill.skillLevel)

    
    
    
    
    
end

function SkillTree:getSkillButton(skillID)
    local xSize = 100
    local ySize = 100
    local skillButton = ccui.Button:create()
    skillButton:loadTextures("res/imgs/temp/white.png", "res/imgs/temp/white.png")
    local size = 150
    skillButton:setScale(size, size)
    

    local pic = GameIconManager.getSkillSprite(skillID, 1, true, 99)
    pic:setScale(0.78 / 100.0, 0.78 / 100.0)
    pic:setPosition(0, 0)
    pic:setAnchorPoint(0, 0)
    skillButton:addChild(pic)
    
    
    skillButton:addTouchEventListener(function(sender, eventType)
        if eventType == 0 then
            currentSelect = skillID
            self:drawSkillInfo()
        end
    end)
    return skillButton
end

function SkillTree:drawTab()
    
    if self.tab ~= nil then
        self.tab.tab1:setVisible(false)
        self.tab.tab2:setVisible(false)
        self.tab.tab3:setVisible(false)
    end
    
    self.tab = {}
    
    self.tab.tab1 = ccui.Button:create()
    if tabSelect == 1 then
        self.tab.tab1:loadTextures("res/imgs/SkillTree/Tab_select.png", "res/imgs/SkillTree/Tab_select.png")
    else
        self.tab.tab1:loadTextures("res/imgs/SkillTree/Tab.png", "res/imgs/SkillTree/Tab.png")
    end
    self.tab.tab1:setPosition(1080 / 2 - 340, 1700)
    self:addChild(self.tab.tab1)
    
    local tab1Text = cc.Sprite:create("res/imgs/SkillTree/Tab_OffenceL.png")
    tab1Text:setPosition(0, 4)
    tab1Text:setAnchorPoint(0, 0)
    self.tab.tab1:addChild(tab1Text)
    
    self.tab.tab1:addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 1
            self:drawTab()
        end
    end
    )
    
    
    
    self.tab.tab2 = ccui.Button:create()
    if tabSelect == 2 then
        self.tab.tab2:loadTextures("res/imgs/SkillTree/Tab_select.png", "res/imgs/SkillTree/Tab_select.png")
    else
        self.tab.tab2:loadTextures("res/imgs/SkillTree/Tab.png", "res/imgs/SkillTree/Tab.png")
    end
    self.tab.tab2:setPosition(1080 / 2, 1700)
    self:addChild(self.tab.tab2)
    
    local tab2Text = cc.Sprite:create("res/imgs/SkillTree/Tab_DeffenceL.png")
    tab2Text:setPosition(0, 4)
    tab2Text:setAnchorPoint(0, 0)
    self.tab.tab2:addChild(tab2Text)
    
    self.tab.tab2:addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 2
            self:drawTab()
        end
    end
    )
    
    self.tab.tab3 = ccui.Button:create()
    if tabSelect == 3 then
        self.tab.tab3:loadTextures("res/imgs/SkillTree/Tab_select.png", "res/imgs/SkillTree/Tab_select.png")
    else
        self.tab.tab3:loadTextures("res/imgs/SkillTree/Tab.png", "res/imgs/SkillTree/Tab.png")
    end
    self.tab.tab3:setPosition(1080 / 2 + 340, 1700)
    self:addChild(self.tab.tab3)
    
    local tab3Text = cc.Sprite:create("res/imgs/SkillTree/Tab_UtilityL.png")
    tab3Text:setPosition(0, 4)
    tab3Text:setAnchorPoint(0, 0)
    self.tab.tab3:addChild(tab3Text)
   
    self.tab.tab3:addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 3
            self:drawTab()
        end
    end
    )
     
end



function SkillTree:drawSkillIcon()
    
    local startX = 120
    local total = 1080 - startX * 2
    local space = (total - 150 * 4) / 3.0
    
    local skills = {
        {1001, 1002, 1003},
        {nil , 1004, 1005},
        {nil , 1006, 1007},
        {nil , 1008, 1009}
    }
    
    local topSpace = 200
    
    for i = 1,4 do
        local y = self.ScrollView:getInnerContainerSize().height - topSpace
        for j = 1, table.getn(skills[i]) do
            if skills[i][j] ~= nil then
                local icon1 = self:getSkillButton(skills[i][j])
                icon1:setPosition(cc.p(startX + (150 + space) * (i-1) + 75, y))
                self.ScrollView:addChild(icon1)
            end
            y = y - (space + 150)
        end
    end

end

function SkillTree:onInit()


    local rootNode = cc.CSLoader:createNode("SkillTree.csb")


    --drawIcons(rootNode)

    self:addChild(rootNode)
    self.CrystalNumDisplay = rootNode:getChildByName("CrystalNumDisplay")
    
    self:updateCrystalNum()
    
    self.ScrollView = rootNode:getChildByName("ScrollView_1")
    
    self:drawSkillIcon()
    
    self:drawTab()
    
    rootNode:getChildByName("ButtonReturn"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("MainMenuScene")
        end

    end
    )
    
    
    rootNode:getChildByName("Button_1"):addTouchEventListener( function(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            currentCrystalNumDisplay = currentCrystalNumDisplay - 100
            self:updateCrystalNum()
        end

    end
    )
    


end

return SkillTree
