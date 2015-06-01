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

GGameIconCount = 5
GBlinkIconIndex = 21

GBackGroundMiddlePoint = {x = 356, y = 540}
-- Contang for battle logic
GMaxRuneNumber = 99
-- Constant for the GUI layout
GPanelGapRatio = 15 / 1920

-- Constant used by tile-matching panel
GTileMatchingPanelVerticalRatio = 930 / 1920
GTileMatchingPanelHorizontalRatio = 950 / 1080
GTileMatchingPanelVerticalStartOffsetRatio = 255 / 1920
GTileMatchingPanelHorizontalStartOffsetRatio = 65 / 1080

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
GSkillSlotIdleSizeRatio = 170 / 1080
GSkillSlotRuneIdleSizeRatio = 40 / 1080
GSkillSlotRuneIdleGapRatio = 2 / 1080
GSkillSlotStartIndex = 1

-- Constant used by the GameBattlePanel
GBattlePanelVerticalRatio = 720 / 1920
GBattlePanelVerticalStartOffsetRatio = 1200 / 1920

GBattleFieldVerticalRatio = 620 / 1920
GBattleFieldHorizontalRatio = 1000 / 1080
GBattleFieldVerticalStartOffsetRatio = 65 / 1920
GBattleFieldHorizontalStartOffsetRatio = 40 / 1080

GBattleHPBarFrameVerticalRatio = 40 / 1920
GBattleHPBarFrameHorizontalRatio = 950 / 1080
GBattleHPBarFrameVerticalStartOffsetRatio = 0 / 1920
GBattleHPBarFrameHorizontalStartOffsetRatio = 62.5 / 1080


GBattleHPBarVerticalRatio = 40 / 1920
GBattleHPBarHorizontalRatio = 937 / 1080
GBattleHPBarVerticalStartOffsetRatio = 0 / 1920
GBattleHPBarHorizontalStartOffsetRatio = 69.5 / 1080

GBattleRuneBlockVerticalRatio = 470 / 1920
GBattleRuneBlockHorizontalRatio = 250 / 1080
GBattleRuneBlockVerticalStartOffsetRatio = 80 / 1920
GBattleRuneBlockHorizontalStartOffsetRatio = 65 / 1080

GBattleRuneIdelWidthRatio = 235 / 1080
GBattleRuneIdelHeightRatio = 110 / 1920
GBattleRuneIdelHorizontalStartOffsetRatio = 15 / 1080
GBattleRuneIdelVerticalStartOffsetRatio = 15 / 1920
GBattleRuneFireVerticalStartOffsetRatio = 0 * GBattleRuneIdelHeightRatio + GBattleRuneIdelVerticalStartOffsetRatio
GBattleRuneWaterVerticalStartOffsetRatio = 1 * GBattleRuneIdelHeightRatio + GBattleRuneIdelVerticalStartOffsetRatio
GBattleRuneEarthVerticalStartOffsetRatio = 2 * GBattleRuneIdelHeightRatio + GBattleRuneIdelVerticalStartOffsetRatio
GBattleRuneAirVerticalStartOffsetRatio = 3 * GBattleRuneIdelHeightRatio + GBattleRuneIdelVerticalStartOffsetRatio
-- Temp Data for the test
GBattleRuneTextLabelIdelWidthRatio = 80 / 1080
GBattleRuneTextLabelIdelHeightRatio = 80 / 1920
GBattleRuneTextLabelHorizontalStartOffsetRatio = 135 / 1080
GBattleRuneTextLabelVerticalStartOffsetRatio = 15 / 1920
GBattleRuneFireTextLabelVerticalStartOffsetRatio = 0 * GBattleRuneIdelHeightRatio + GBattleRuneTextLabelVerticalStartOffsetRatio
GBattleRuneWaterTextLabelVerticalStartOffsetRatio = 1 * GBattleRuneIdelHeightRatio + GBattleRuneTextLabelVerticalStartOffsetRatio
GBattleRuneEarthTextLabelVerticalStartOffsetRatio = 2 * GBattleRuneIdelHeightRatio + GBattleRuneTextLabelVerticalStartOffsetRatio
GBattleRuneAirTextLabelVerticalStartOffsetRatio = 3 * GBattleRuneIdelHeightRatio + GBattleRuneTextLabelVerticalStartOffsetRatio

GBattleLevelBlockVerticalRatio = 100 / 1920
GBattleLevelBlockHorizontalRatio = 300 / 1080
GBattleLevelBlockVerticalStartOffsetRatio = 560 / 1920
GBattleLevelBlockHorizontalStartOffsetRatio = 380 / 1080

GBattleMonsterBlockVerticalRatio = 350 / 1920
GBattleMonsterBlockHorizontalRatio = 350 / 1080
GBattleMonsterBlockVerticalStartOffsetRatio = 85 / 1920
GBattleMonsterBlockHorizontalStartOffsetRatio = 390 / 1080


GBattleCrystalBlockVerticalRatio = 100 / 1920
GBattleCrystalBlockHorizontalRatio = 285 / 1080
GBattleCrystalBlockVerticalStartOffsetRatio = 560 / 1920
GBattleCrystalBlockHorizontalStartOffsetRatio = 80 / 1080

GBattleCrystalTextVerticalRatio = 70 / 1920
GBattleCrystalTextHorizontalRatio = 80 / 1080
GBattleCrystalTextVerticalStartOffsetRatio = 570 / 1920
GBattleCrystalTextHorizontalStartOffsetRatio = 200 / 1080

--[[GBattleMonsterBlockVerticalRatio = 470 / 1920
GBattleMonsterBlockHorizontalRatio = 470 / 1080
GBattleMonsterBlockVerticalStartOffsetRatio = 80 / 1920
GBattleMonsterBlockHorizontalStartOffsetRatio = 330 / 1080--]]

GBattleMonsterHPBarVerticalRatio = 30 / 1920
GBattleMonsterHPBarHorizontalRatio = 396 / 1080
GBattleMonsterHPBarVerticalStartOffsetRatio = 500 / 1920
GBattleMonsterHPBarHorizontalStartOffsetRatio = 372.5 / 1080

GBattleMonsterHPBarFrameVerticalRatio = 30 / 1920
GBattleMonsterHPBarFrameHorizontalRatio = 400 / 1080
GBattleMonsterHPBarFrameVerticalStartOffsetRatio = 500 / 1920
GBattleMonsterHPBarFrameHorizontalStartOffsetRatio = 370 / 1080

GBattlePlayerEffectBlockVerticalRatio = 180 / 1920
GBattlePlayerEffectBlockHorizontalRatio = 220 / 1080
GBattlePlayerEffectBlockVerticalStartOffsetRatio = 80 / 1920
GBattlePlayerEffectBlockHorizontalStartOffsetRatio = 800 / 1080

GBattleMonsterEffectBlockVerticalRatio = 180 / 1920
GBattleMonsterEffectBlockHorizontalRatio = 220 / 1080
GBattleMonsterEffectBlockVerticalStartOffsetRatio = 300 / 1920
GBattleMonsterEffectBlockHorizontalStartOffsetRatio = 800 / 1080

GBattleEffectVerticalStartOffset = 15 / 1920
GBattleEffectHorizontalStartOffset = 20 / 1080
GBattleEffectGapVerticalRatio = 10 / 1920
GBattleEffectGapHorizontalRatio = 5 / 1080
GBattleEffectIconVerticalRatio = 60 / 1920
GBattleEffectIconHorizontalRatio = 60 / 1080
GBattleMaxEffectInRow = 3
GBattleMaxEffectNumber = 6

GBattleOptionBlockVerticalRatio = 110 / 1920
GBattleOptionBlockHorizontalRatio = 110 / 1080
GBattleOptionBlockVerticalStartOffset = 625 / 1920
GBattleOptionBlockHorizontalStartOffset = 980 / 1080

GBattleToggleBlockVerticalRatio = 110 / 1920
GBattleToggleBlockHorizontalRatio = 110 / 1080
GBattleToggleBlockVerticalStartOffset = 560 / 1920
GBattleToggleBlockHorizontalStartOffset = 750 / 1080

GSkillPublicCD = 3
GSkillLevelBonus = 1.2
GEffectPublicCD = 0.3

GMonsterAIInterval = 3.5

GSkillMaxLevel = 10


