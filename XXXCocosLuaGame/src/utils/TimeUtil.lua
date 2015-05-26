--------------------------------
-- TimeUtil.lua
-- @author fangzhou.long
-- UTILITY This is a tool class
--------------------------------

--------------------------------
--  Time utility for the game
-- @module utils.TimeUtil
TimeUtil = class()

--------------------------------
--  Get the seconds difference between local machine and server
-- @function [parent=#TimeUtil] getUtcDiffSeconds
-- @return #int Seconds difference
function TimeUtil.getUtcDiffSeconds()
    return _G.__g_utcDiffSeconds and _G.__g_utcDiffSeconds or 0
end

--------------------------------
--  Get the server time seconds
-- @function [parent=#TimeUtil] getServerTime
-- @return #int Server time seconds
function TimeUtil.getServerTime()
    local utcDiffSeconds = TimeUtil.getUtcDiffSeconds()
    return os.time() + utcDiffSeconds
end

--[[
Deprecated, use os.date("%X", timeNum) to convert
--------------------------------
--  Convert a seconds time to a 
-- @function [parent=#TimeUtil] formatTime
-- @return #string Formmated time
function TimeUtil.formatTime( timeNum )
    local aTime = {hh = 0, mm = 0, ss = 0}
    aTime.ss = math.mod(timeNum, 60) 
    timeNum = math.modf(timeNum/60)
    aTime.mm = math.mod(timeNum, 60)
    timeNum = math.modf(timeNum/60)
    aTime.hh = math.mod(timeNum, 24) --TODO Add time zone diff here

    return "" .. (((aTime.hh>=10) and aTime.hh) or "0"..aTime.hh) .. ":" .. (((aTime.mm>=10) and aTime.mm) or "0"..aTime.mm) .. ":" .. (((aTime.ss>=10) and aTime.ss) or "0"..aTime.ss)
end
--]]

--------------------------------
--  Get current hh:mm:ss time string
-- @function [parent=#TimeUtil] getTimeString
-- @return #string Current time
function TimeUtil.getTimeString(givenTime)
    return os.date("%X", givenTime and givenTime or TimeUtil.getServerTime())
end

--------------------------------
--  Get current program run time(Since started
-- @function [parent=#TimeUtil] getRunningTime
-- @return #string Current running time
function TimeUtil.getRunningTime()
    return os.clock()
end