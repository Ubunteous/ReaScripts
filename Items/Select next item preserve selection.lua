function SWS_OnCommand(str) return reaper.Main_OnCommand(reaper.NamedCommandLookup(str), 0) end

-- SWS: Add item(s) to right of selected item(s) to selection
SWS_OnCommand("_SWS_ADDRIGHTITEM")

-- Item navigation: Move cursor right to edge of item
reaper.Main_OnCommand(40319, 0)
reaper.Main_OnCommand(40319, 0)
