----Button txt key to texture and title text configuration table
-- If text=nil, programe will not generate any title text on the button
-- If disabled is set to be "normal", program will use normal + dark cover as the disabled state
local ButtonTable = {
    ["Upgrade"] = {text=nil, normal="res/imgs/btns/btn_upgrade.png", selected="imgs/btns/btn_upgrade_selected.png", disabled="normal"},
    ["Confirm"] = {text=nil, normal="res/imgs/btns/btn_confirm.png", selected="imgs/btns/btn_confirm_selected.png", disabled="normal"},
    ["Cancel"] = {text=nil, normal="res/imgs/btns/btn_cancel.png", selected="imgs/btns/btn_cancel_selected.png", disabled="normal"},

    
    ["OptionBtn"] = {text=nil, normal="imgs/btns/icon/icon_option.png", selected="imgs/btns/icon/icon_option_selected.png", disabled="normal",},
    ["ReturnBtn"] = {text=nil, normal="imgs/btns/icon/icon_return.png", selected="imgs/btns/icon/icon_return_selected.png", disabled="normal",},
    ["CloseBtn"] = {text=nil, normal="imgs/btns/icon/icon_close.png", selected="imgs/btns/icon/icon_close_selected.png", disabled="normal",},
    ["TutorialBtn"] = {text=nil, normal="imgs/btns/icon/icon_tutorial.png", selected="imgs/btns/icon/icon_tutorial_selected.png", disabled="normal",},
    
    ["Endless"] = {text=nil, normal="res/imgs/btns/btn_endless.png", selected="imgs/btns/btn_endless_selected.png", disabled="normal"},
    ["Story"] = {text=nil, normal="res/imgs/btns/btn_story.png", selected="imgs/btns/btn_story_selected.png", disabled="normal"},
    ["VS"] = {text=nil, normal="res/imgs/btns/btn_vs.png", selected="imgs/btns/btn_vs_selected.png", disabled="normal"},
    
    ["OptionBtn_Menu"] = {text=nil, normal="imgs/btns/btn_option_menu.png", selected="imgs/btns/btn_option_menu_selected.png", disabled="normal",},
    ["SkillBtn"] = {text=nil, normal="imgs/btns/btn_skill.png", selected="imgs/btns/btn_skill_selected.png", disabled="normal",},
    ["MonsterBtn"] = {text=nil, normal="imgs/btns/btn_monster.png", selected="imgs/btns/btn_monster_selected.png", disabled="normal",},
    ["TutorialBtn_Menu"] = {text=nil, normal="imgs/btns/btn_tutorial.png", selected="imgs/btns/btn_tutorial_selected.png", disabled="normal",},
    
    ["+1"] = {text=nil, normal="imgs/btns/btn_1.png", selected="imgs/btns/btn_1_selected.png", disabled="normal",},
    ["+10"] = {text=nil, normal="imgs/btns/btn_10.png", selected="imgs/btns/btn_10_selected.png", disabled="normal",},
    ["+100"] = {text=nil, normal="imgs/btns/btn_100.png", selected="imgs/btns/btn_100_selected.png", disabled="normal",},
}
return ButtonTable