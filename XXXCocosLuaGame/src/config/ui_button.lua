----Button txt key to texture and title text configuration table
-- If text=nil, programe will not generate any title text on the button
-- If disabled is set to be "normal", program will use normal + dark cover as the disabled state
local ButtonTable = {
    ["Upgrade"] = {text=nil, normal="res/imgs/btns/btn_upgrade.png", selected="imgs/btns/btn_upgrade_selected.png", disabled="normal"},
    ["OptionBtn"] = {text=nil, normal="imgs/btns/icon/icon_option.png", selected="imgs/btns/icon/icon_option_selected.png", disabled="normal",},
    ["ReturnBtn"] = {text=nil, normal="imgs/btns/icon/icon_return.png", selected="imgs/btns/icon/icon_return_selected.png", disabled="normal",},
    ["CloseBtn"] = {text=nil, normal="imgs/btns/icon/icon_close.png", selected="imgs/btns/icon/icon_close_selected.png", disabled="normal",},
}
return ButtonTable