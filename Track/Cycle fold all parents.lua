-- local track = reaper.GetLastTouchedTrack()
-- function msg(str) reaper.ShowConsoleMsg(tostring(str)) end
function SWS_OnCommand(str) return reaper.Main_OnCommand(reaper.NamedCommandLookup(str), 0) end

-- SWS: Save current track selection
SWS_OnCommand("_SWS_SAVESEL")

-- SWS: Select all folders (parents only)
SWS_OnCommand("_SWS_SELALLPARENTS")

-- Track: Cycle folder collapsed state
reaper.Main_OnCommand(1042, 0)

-- SWS: Restore saved track selection
SWS_OnCommand("_SWS_RESTORESEL")
