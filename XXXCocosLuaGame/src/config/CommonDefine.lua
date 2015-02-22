--------------------------------------------------------------------------------
-- CommonDefine.lua - 常量定义
-- @author fangzhou.long
--------------------------------------------------------------------------------

GBackGroundWidth = 712
GBackGroundHeight = 1024

GCellWidth = 150

GBoardSizeX = 6
GBoardSizeY = 6

GLeftBottomOffsetX = (1080 - GCellWidth * GBoardSizeX) / 2
GLeftBottomOffsetY = (1200 - 240 - GCellWidth * GBoardSizeY)/2 + 240

GGameIconCount = 7
GBlinkIconIndex = 21

GBackGroundMiddlePoint = {x = 356, y = 540}

-- Constant for the GUI layout
GPanelGapRatio = 15 / 1920
-- Constant used by GameSkillSlotManagerLayer
GMaxSkillsInSlot = 5

GSkillSlotPanelVerticalRatio = 240 / 1920

GSkillSlotBGVerticalRatio = 200 / 1920
GSkillSlotBGHorizontalRatio = 1000 / 1080
GSkillSlotBGVerticalStartOffsetRatio = 40 / 1920
GSkillSlotBGHorizontalStartOffsetRatio = 40 / 1080

GSkillSlotHorizontalStartOffsetRatio = 65 / 1080
GSkillSlotVerticalStartOffsetRatio = 55 / 1920  -- 40 + 15
GSkillSlotHorizontalOffsetRatio = 25 / 1080
GSkillSlotIdelSizeRatio = 170 / 1080
GSkillSlotStartIndex = 1

-- Constant used by the GameBattlePanel
GBattlePanelVerticalRatio = 720 / 1920
GBattlePanelVerticalStartOffsetRatio = 1200 / 1920

GBattleFieldVerticalRatio = 620 / 1920
GBattleFieldHorizontalRatio = 1000 / 1080
GBattleFieldVerticalStartOffsetRatio = 65 / 1920
GBattleFieldHorizontalStartOffsetRatio = 40 / 1080

GBattleHPBarVerticalRatio = 50 / 1920
GBattleHPBarHorizontalRatio = 950 / 1080
GBattleHPBarVerticalStartOffsetRatio = 0 / 1920
GBattleHPBarHorizontalStartOffsetRatio = 65 / 1080

GBattleRuneBlockVerticalRatio = 470 / 1920
GBattleRuneBlockHorizontalRatio = 130 / 1080
GBattleRuneBlockVerticalStartOffsetRatio = 80 / 1920
GBattleRuneBlockHorizontalStartOffsetRatio = 80 / 1080

GBattleLevelBlockVerticalRatio = 110 / 1920
GBattleLevelBlockHorizontalRatio = 950 / 1080
GBattleLevelBlockVerticalStartOffsetRatio = 560 / 1920
GBattleLevelBlockHorizontalStartOffsetRatio = 65 / 1080

