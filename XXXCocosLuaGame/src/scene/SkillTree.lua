--------------------------------
-- SkillTree.lua
-- @author Gaoyuan Chen
--------------------------------

require("utils.GeneralUtil")

local battle_mission_cfg = require("config.battle_mission")
local SkillTagHeader = 10000
local currentSelect = 0
local SkillTree = class("SkillTree", function() return BaseScene.create() end)

local skillIconList = {}
local upgradePanelOn = false
local upgradePanelCost = 0

local function skillIconListUpdates()
    --print('now update: ' .. #skillIconList)
    for i = 1, #skillIconList do
        skillIconList[i].updateLevel()
    end
end

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

local function toString6(x)
    local ret = x .. ""
    while string.len(ret) < 6 do
        ret = '0' .. ret
    end
    return ret
end

local function toString2(x)
    local ret = x .. ""
    while string.len(ret) < 2 do
        ret = '0' .. ret
    end
    return ret
end



function SkillTree:updateCrystalNum()
    self.CrystalNumDisplay:setString(toString6(DataManager.getCrystalNum()))
end

function SkillTree:drawSkillInfo()
    if self.currentSelectSkill ~= nil then
        self.currentSelectSkill.skillIcon:setVisible(false)
        self.currentSelectSkill.skillName:setVisible(false)
        self.currentSelectSkill.skillDesc:setVisible(false)
        self.currentSelectSkill.skillLevel:setVisible(false)
        self.currentSelectSkill.expBar:setVisible(false)
        self.currentSelectSkill.runesCost:setVisible(false)
        self.currentSelectSkill.runesCostIcon1:setVisible(false)
        self.currentSelectSkill.runesCostIcon2:setVisible(false)
        self.currentSelectSkill.runesCostIcon3:setVisible(false)
        self.currentSelectSkill.runesCostIcon4:setVisible(false)

    end
    
    
    self.currentSelectSkill = {}
    
    -- Icon
    if (currentSelect ~= nil) then
        self.currentSelectSkill.skillIcon = self:getSkillButton(currentSelect, false)
        self.currentSelectSkill.skillIcon:setPosition(cc.p(137, 267))
        self.currentSelectSkill.skillIcon.removeLevel()
        self:addChild(self.currentSelectSkill.skillIcon, 1001)
    end
    
    local skill = MetaManager.getSkill(currentSelect)
    -- Name
    self.currentSelectSkill.skillName = cc.LabelTTF:create(
        -- "[" .. currentSelect .. "] " .. 
        skill.skillName , "Arial", 35)
    self.currentSelectSkill.skillName:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillName:setPosition(cc.p(650, 190))
    self:addChild(self.currentSelectSkill.skillName)
    
    -- Desc
    self.currentSelectSkill.skillDesc = cc.LabelTTF:create(skill.skillDesc , "Arial", 35)
    self.currentSelectSkill.skillDesc:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillDesc:setPosition(cc.p(650, 140))
    self:addChild(self.currentSelectSkill.skillDesc)
    
    -- Level
    self.currentSelectSkill.skillLevel = cc.LabelTTF:create(toString2(DataManager.getSkillLevel(currentSelect)) , "Arial", 35)
    self.currentSelectSkill.skillLevel:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.skillLevel:setPosition(cc.p(350, 335))
    self:addChild(self.currentSelectSkill.skillLevel)
    
    -- Exp bar
    self.currentSelectSkill.expBar = cc.Sprite:create("res/imgs/SkillTree/red.png")
    
    -- Runes
    local c1 = skill.runeCostTable.air
    local c2 = skill.runeCostTable.earth
    local c3 = skill.runeCostTable.water
    local c4 = skill.runeCostTable.fire
    
    local p = 350
    self.currentSelectSkill.runesCost = cc.LabelTTF:create(toString2('                   x ' .. c1 .. '        x ' .. c2 .. '        x ' .. c3 .. '        x ' .. c4) , "Arial", 50)
    self.currentSelectSkill.runesCost:setColor(cc.c3b(255, 255, 255))
    self.currentSelectSkill.runesCost:setPosition(cc.p(p + 210, 270))
    self:addChild(self.currentSelectSkill.runesCost)
    
    self.currentSelectSkill.runesCostIcon1 = cc.Sprite:create("res/imgs/rune/rune_02_air.png")
    self.currentSelectSkill.runesCostIcon1:setScale(0.7)
    self.currentSelectSkill.runesCostIcon1:setPosition(cc.p(p, 270))
    self:addChild(self.currentSelectSkill.runesCostIcon1)
    
    self.currentSelectSkill.runesCostIcon2 = cc.Sprite:create("res/imgs/rune/rune_03_earth.png")
    self.currentSelectSkill.runesCostIcon2:setScale(0.7)
    self.currentSelectSkill.runesCostIcon2:setPosition(cc.p(p + 175, 270))
    self:addChild(self.currentSelectSkill.runesCostIcon2)
    
    self.currentSelectSkill.runesCostIcon3 = cc.Sprite:create("res/imgs/rune/rune_01_water.png")
    self.currentSelectSkill.runesCostIcon3:setScale(0.7)
    self.currentSelectSkill.runesCostIcon3:setPosition(cc.p(p + 175 * 2, 270))
    self:addChild(self.currentSelectSkill.runesCostIcon3)
    
    self.currentSelectSkill.runesCostIcon4 = cc.Sprite:create("res/imgs/rune/rune_04_fire.png")
    self.currentSelectSkill.runesCostIcon4:setScale(0.7)
    self.currentSelectSkill.runesCostIcon4:setPosition(cc.p(p + 175 * 3, 270))
    self:addChild(self.currentSelectSkill.runesCostIcon4)

    --[[ 100%
    self.currentSelectSkill.expBar:setScale(610, 20)
    self.currentSelectSkill.expBar:setPosition(cc.p(705, 335))
    ]]--
    
    local  rate = DataManager.getSkillRate(currentSelect)
    self.currentSelectSkill.expBar:setScale(10 + 600 * rate, 20)
    self.currentSelectSkill.expBar:setPosition(cc.p(405 + 300 * rate, 335))
    
    self:addChild(self.currentSelectSkill.expBar)
    
    
    
end

function SkillTree:getSkillButton(skillID, canClick)
    local xSize = 100
    local ySize = 100
    local skillButton = ccui.Button:create()
    skillButton:loadTextures("res/imgs/temp/white.png", "res/imgs/temp/white.png")
    local size = 150
    skillButton:setScale(size, size)
    
    
    local pic = GameIconManager.getSkillSprite(skillID, 1, true, 99)
    pic:setScale(0.65 / 100.0, 0.65 / 100.0)
    pic:setPosition(0, 0)
    pic:setAnchorPoint(0, 0)
    skillButton:addChild(pic)
    
    
    if DataManager.getSkillLevel(skillID) > 0 then
        skillButton:addTouchEventListener(function(sender, eventType)
            if not self.touchEnabled then return true end
            if eventType == 0 and upgradePanelOn == false then
            currentSelect = skillID
            self:drawSkillInfo()
        end
  
        end)
    end
       
    skillButton.updateLevel = function()
        local skillLvl = DataManager.getSkillLevel(skillID)
        if skillLvl == 0 then
            pic:setDisabled(true)
        end
            pic.skillLevelLabel:setString("Lv. " .. (skillLvl<10 and "0" or "") .. skillLvl)
    end
  
    skillButton.removeLevel = function()
        local skillLvl = DataManager.getSkillLevel(skillID)
        if skillLvl == 0 then
            pic:setDisabled(true)
        end
        pic.skillLevelLabel:setString("")
    end
      
    skillButton.updateLevel()
    if DataManager.getSkillLevel(skillID) == 0 then
        skillButton.removeLevel()
    end
    
    
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
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 1
            self.ScrollView1:setVisible(true)
            self.ScrollView2:setVisible(false)
            self.ScrollView3:setVisible(false)
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
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 2
            self.ScrollView1:setVisible(false)
            self.ScrollView2:setVisible(true)
            self.ScrollView3:setVisible(false)
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
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            tabSelect = 3
            self.ScrollView1:setVisible(false)
            self.ScrollView2:setVisible(false)
            self.ScrollView3:setVisible(true)
            self:drawTab()
        end
    end
    )
     
end



function SkillTree:drawSkillIcon()
    
    local startX = 120
    local total = 1080 - startX * 2
    local space = (total - 150 * 4) / 3.0
    
    local skills1 = {
        {1001, 1002},
        {nil, 1004},
        {nil , 1006},
        {nil , 1008}
    }

    local skills2 = {
        {1100},
        {1200},
        {1300},
        {}
    }
    
    local skills3 = {
        {1400, 1500, 1900},
        {2000, 2100},
        {1800},
        {1600}
    }
    
    local topSpace = 200
    
    local skillsList = {skills1, skills2, skills3 }
    local scrollViewList = {self.ScrollView1, self.ScrollView2, self.ScrollView3}
    
    skillIconList = {}
    
    for t = 1,3 do
        local scrollView = scrollViewList[t]
        
        local skills = skillsList[t]
        for i = 1,4 do
            local y = scrollView:getInnerContainerSize().height - topSpace
            for j = 1, table.getn(skills[i]) do
                if (skills[i][j] ~= nil) then
                    local icon1 = self:getSkillButton(skills[i][j], true)
                    icon1:setPosition(cc.p(startX + (150 + space) * (i-1) + 75, y))
                    scrollView:addChild(icon1)
                    skillIconList[#skillIconList+1] = icon1
                end
                y = y - (space + 150)
            end
        end
    
    end
    
    
    
    
    

end

function SkillTree:updateUpgradePanel()
    
    
    if(upgradePanelOn) then
        self.UpgradePanel:setVisible(true)
        if upgradePanelCost > DataManager.expToMax(currentSelect) then
            upgradePanelCost = DataManager.expToMax(currentSelect)
        end
        if upgradePanelCost > DataManager.getCrystalNum() then
            upgradePanelCost = DataManager.getCrystalNum()
        end
        
        local newExp = DataManager.getSkillExp(currentSelect) + upgradePanelCost
        local newLevel = DataManager.expToLevel(newExp)
        local newRate = DataManager.expToRate(newExp)
       
        self.UpgradePanel:getChildByName("display_number"):setString(upgradePanelCost)
        self.UpgradePanel:getChildByName("display_level"):setString(toString2(newLevel))
        -- .. " (+" .. math.floor(newRate*100) .. "%)" )
        
        
        
    else
        self.UpgradePanel:setVisible(false)
    end
end

function SkillTree:onInit()


    local rootNode = cc.CSLoader:createNode("SkillTree.csb")
    
    self.btnTutorial = GameButton.create("TutorialBtn", true, 0.5)
    rootNode:getChildByName("btn_tutorial"):addChild(self.btnTutorial)
    
    self:addChild(rootNode)
    self.CrystalNumDisplay = rootNode:getChildByName("CrystalNumDisplay")
    
    self:updateCrystalNum()
    
    self.ScrollView1 = rootNode:getChildByName("ScrollView_1")
    self.ScrollView2 = rootNode:getChildByName("ScrollView_2")
    self.ScrollView3 = rootNode:getChildByName("ScrollView_3")
    
    self.UpgradePanel = rootNode:getChildByName("UpgradePanel")
    self.UpgradePanel:setVisible(false)
    upgradePanelOn = false
    upgradePanelCost = 0
    currentSelect = 0
    
    self.ScrollView1:setVisible(tabSelect == 1)
    self.ScrollView2:setVisible(tabSelect == 2)
    self.ScrollView3:setVisible(tabSelect == 3)
    
    self:drawSkillIcon()
    
    self:drawTab()
    
    GameButton.ChangeTo(self.UpgradePanel:getChildByName("confirm"), GameButton.create("Confirm", true))
    GameButton.ChangeTo(self.UpgradePanel:getChildByName("cancel"), GameButton.create("Cancel", true))
    GameButton.ChangeTo(self.UpgradePanel:getChildByName("plus100"), GameButton.create("+100", true))
    GameButton.ChangeTo(self.UpgradePanel:getChildByName("plus10"), GameButton.create("+10", true))
    GameButton.ChangeTo(self.UpgradePanel:getChildByName("plus1"), GameButton.create("+1", true))
    
    
    rootNode:getChildByName("ButtonReturn"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            SceneManager.replaceSceneWithName("MainMenuScene")
        end

    end
    )
    
    
    rootNode:getChildByName("Button_1"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            if currentSelect > 0 then
                upgradePanelOn = true
                upgradePanelCost = 0
                self:updateUpgradePanel()
                --self:updateCrystalNum()
            end
        end

    end
    )
    
    self.UpgradePanel:getChildByName("cancel"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            upgradePanelOn = false
            self:updateUpgradePanel()
            self:updateCrystalNum()
            self:drawSkillInfo()
        end
    end
    )
    
    self.UpgradePanel:getChildByName("confirm"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            
            
            local request = UpgradeSkillsRequest.create()
            request.params.crystal = upgradePanelCost
            request.params["skillID[0]"] = currentSelect
            request.params["skillExp[0]"] = upgradePanelCost + DataManager.getSkillExp(currentSelect)
            request.onSuccess = function(data)
                upgradePanelOn = false
                DataManager.setSkillExp(currentSelect, upgradePanelCost + DataManager.getSkillExp(currentSelect))
                DataManager.setCrystalNum(DataManager.getCrystalNum() - upgradePanelCost)
                self:updateUpgradePanel()
                self:updateCrystalNum()
                self:drawSkillInfo()
                skillIconListUpdates()
            end
            
            NetworkManager.send(request)
            
            
        end
    end
    )

    self.UpgradePanel:getChildByName("plus100"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            upgradePanelCost = upgradePanelCost + 100
            self:updateUpgradePanel()
            self:updateCrystalNum()
        end
    end)
    
    self.UpgradePanel:getChildByName("plus10"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            upgradePanelCost = upgradePanelCost + 10
            self:updateUpgradePanel()
            self:updateCrystalNum()
        end
    end)
    
    self.UpgradePanel:getChildByName("plus1"):addTouchEventListener( function(sender, eventType)
        if not self.touchEnabled then return true end
        if eventType == ccui.TouchEventType.ended then 
            upgradePanelCost = upgradePanelCost + 1
            self:updateUpgradePanel()
            self:updateCrystalNum()
        end
    end)

    
    
    
    local panel = require("panel.TutorialPanel")
    rootNode:addChild(panel.create(self, self.btnTutorial),10001)

end

return SkillTree
