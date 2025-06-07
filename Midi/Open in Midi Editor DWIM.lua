-- function msg(m) reaper.ShowConsoleMsg(tostring(m)) end

local windowName
local _, windows = reaper.JS_Window_ListAllTop()

-- Item: Open in built-in MIDI editor (set default behavior in preferences)
reaper.Main_OnCommand(40153, 0)

for w in string.gmatch(windows, "[^,]+") do
   windowName = reaper.JS_Window_GetTitle(reaper.JS_Window_HandleFromAddress(w))

   if string.sub(windowName, 1, 4) == "MIDI" then
	  return
   end
end

if reaper.CountSelectedTracks(0) == 0 then
   track = reaper.GetLastTouchedTrack()
end

-- Xenakios/SWS: Select items under edit cursor on selected tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELITEMSUNDEDCURSELTX"), 0)

-- Item: Open in built-in MIDI editor (set default behavior in preferences)
reaper.Main_OnCommand(40153, 0)
